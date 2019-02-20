function [ Fem,Mp,InputIndex ] = FiniteElementProcedures( Fem,Mp,InputIndex )
%% Initialize Integration Point Location (only for Finite Element Method
[ Fem,Mp,InputIndex ] = InitializeFEMProps( Fem,Mp,InputIndex );
%% Initialize Material Point Properties (only for Material Point Method)
[ Fem,Mp,InputIndex ] = InitializeMPMProps( Fem,Mp,InputIndex );
%% Assign Material Point Properties
[ Fem,Mp,InputIndex ] = MatPointFunc( Fem,Mp,InputIndex );
%% Define Displacement Matrix
[ u,U ] = DefineDisplacementMatrix( InputIndex );
%% Define Phase Field Matrix
[ c,C ] = DefinePhaseFieldMatrix( InputIndex );
%% Define External Force Matrix
[ pext,Pext ] = DefineExternalForceMatrix( InputIndex );
%% Define Imposed Kinematic Constrain Matrix (Lagrange Multipliers)
[ lagrMulti] = DefineKinemConstMatrix( InputIndex );
%% Constrains Matrix
[ Constrains ] = ConstrainsMatrix( Fem,Mp,InputIndex );
%% Known Displacements
[ KnownDis ] = NumberOfKnownDisplacementsFEM( Constrains,InputIndex.DegreeOfFreedom );
%% Unknown Displacements
UnKnownDis=InputIndex.DegreeOfFreedom-KnownDis;
%% Rearrange Matrix
[ V ] = VRearrangeFunction( Constrains,InputIndex.DegreeOfFreedom,KnownDis );

%% Finite Element Proceduces
inc=1; %Assign increment equal to 1
while (inc<=InputIndex.SolAlg.NumberOfIncrements) %Loop for load increments)
    %Redefine Material Point Properties in each increment (only for Material Point Method)
    if InputIndex.AnalIndex.MPMIndex==1 %case Material Point Method
        if inc~=1 %case other increments
            [ u,U,c,C,pres,pext,Pext,KnownDis,UnKnownDis,V,Fem,Mp,InputIndex ] = DefineMPMPropsOtherIncrement( Fem,Mp,InputIndex );
        end
    end
    %Define the current time
    [ t ] = timeParameterIncremental( inc,InputIndex ); 
    %Define tolerance (Newton-Raphson)
    [ tolerance ] = ToleranceNewtonRaphson( inc,InputIndex );
    %External Incremental Forces (without load factor)
    [ P ] = ExternalForceMatrixIncremental( inc,t,Fem,Mp,InputIndex );
    if inc==1 %case first increment
        [ pext,pint,Fc,pres,Ratold,Remold,Fem,Mp,InputIndex ] = DefineParamentersFirstIncrement( inc,P,UnKnownDis,Fem,Mp,InputIndex );
    else %case other increments
        [ pext,pint,pres,Fc,Fem,Mp,InputIndex ] = DefineParamentersOtherIncrement( inc,P,pres,pint,UnKnownDis,Fem,Mp,InputIndex );
    end            
    iter=1; %Assign iteration eqaul to 1
    %***********************Phase-Field************************************
    %Initialize Global Phase Field tangent Matrix in each iteration
    if InputIndex.AnalIndex.CrackPropagationIndex(1,1); %Crack Propagation Index
        %Initialize Phase Field tangent Matrix
        [ Kc ] = InitializePhaseFieldTangMatrix( InputIndex );
        %Calculate Global Phase Field tangent Matrix
        [ Kc,Mp,InputIndex ] = CalculatePhaseFieldTangMatrix( inc,iter,Kc,Fem,Mp,InputIndex );
        %Find Phase Field
        [ c ] = FindPhaseField( inc,iter,c,Kc,Fc,Fem,Mp,InputIndex );
        %Assign Fracture Parameters
        [ Fem,Mp,InputIndex ] = AssignFractureParameters(inc,iter,c,Fem,Mp,InputIndex);            
        %Update Total "Fracture" Quantities
        [ DissEnergy,Fem,Mp,InputIndex ] = UpdateTotFracQuant(inc,iter,Fem,Mp,InputIndex);
    end
    %***********************Displacement Field*****************************
    while (iter<=InputIndex.SolAlg.SolAlgParam(1,3)) %Loop for iteretations
        tic %Time Start
        X=sprintf('inc: %d iter: %d time: %d',inc,iter,t); %Define current increment / iteration
        disp(X); %Display current increment / iteration
        %Initialize Stiffness Matrix in each iteration
        [ K ] = InitializeStiffMatrix( InputIndex );
        %Calculate Global Stiffness matrix
        [ K,Fem,InputIndex ] = CalculateStiffnessMatrix( inc,iter,K,Fem,Mp,InputIndex );     
        %Initialize Internal Forces in each iteration 
        [ pint ] = InitializeInternalForces( inc,iter,pint,InputIndex );
        %Find Displacement in Static Analysis
        [ u,lagrMulti,Cl,Cff,G,Fem,Mp,InputIndex ] = FindDisplacementsStatic( inc,iter,K,P,pres,pext,V,UnKnownDis,KnownDis,u,c,lagrMulti,Fem,Mp,InputIndex );
        %Calculate Internal Forces and Check for Plasticity / Fracture
        [ pint,Fem,Mp,InputIndex ] = CalculateInternalForcesWithStiffnessMatrix( inc,u,pint,Fem,Mp,InputIndex );
        %Converage
        [ pres,pext,convrg,diverg,Ratold,Remold,Ratio ] = CheckForConverageStatic( inc,iter,tolerance,P,V,UnKnownDis,KnownDis,Ratold,Remold,pext,pint,lagrMulti,u,Cl,Cff,G,InputIndex );
        %Store iter / inc history
        Anal{inc,1}=inc;
        Anal{inc,2}=iter;
        Anal{inc,3}(iter,1)=Ratio;
        iter=iter+1; %Update iteration
        toc %Time End
        if convrg==true %convergence is true
            X=sprintf('Convergence: TRUE'); %Assign ''Convergence: TRUE''
            disp(X); %Display 'Convergence: TRUE'
            break;
        elseif diverg==true
            %The algorithms is diverged
            break;
        end
    end
    [ U,C,Pext,Fem,Mp,InputIndex ] = ConvergenceTrueStatic( inc,u,U,c,C,pext,Pext,Fem,Mp,InputIndex );
    %Update Material Point Properties
    [ Fem,Mp,InputIndex ] = UpdateMaterialPointProps( u,Fem,Mp,InputIndex );      
    %Post-Processing
    clf;
    hold on;
    titleName = 'Displacement Field Y';
    xp=Mp.coords(:,1);
    yp=Mp.coords(:,2);
    AnimationField=Mp.u(:,2);
    AnimationFunction( 1,xp,yp,AnimationField,titleName,Fem,InputIndex );
    %
    titleName = 'Phase Field';
    xp=Mp.coords(:,1);
    yp=Mp.coords(:,2);
    AnimationField=Mp.c(1,:)';
    AnimationFunction( 2,xp,yp,AnimationField,titleName,Fem,InputIndex );
    drawnow;
    %%Draw Function
    DrawFunction2( inc,t,u,U,pext,Pext,Fem,Mp,InputIndex );
    inc=inc+1; %Update increment
end

%% Draw stored data
[ InputIndex ] = DrawFunction3(inc,InputIndex);
end