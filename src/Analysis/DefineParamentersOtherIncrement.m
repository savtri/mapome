function [ pext,pint,pres,Fc,Fem,Mp,InputIndex ] = DefineParamentersOtherIncrement( inc,P,pres,pint,UnKnownDis,Fem,Mp,InputIndex )
%% Define parameters
nInP=InputIndex.NumberTotOfIntegPoints; %Assign Total Number Of Integration Points
dof=InputIndex.DegreeOfFreedom; %Assign total number of degree of Freedom
nkc=InputIndex.Constrains.NumberOfKinemConst; %Assign Number of Kinematic Constrains
%% Define strain (eogp), stresses, plastic multiplier (dg), plastic strains(Z)
Mp.eo=Mp.e; %Assign strains in the beginning of each increment in GPs
Mp.so=Mp.s; %Assign stresses in the beginning of each increment in GPs
Mp.dg=zeros(1,nInP); %Assign Plastic Multiplier in GPs
%% Define Phase Field Parameters
if InputIndex.AnalIndex.CrackPropagationIndex(1,1)==1 %case Crack Propagation
    %Assign max Free Energy Plus (=History Field) (current) in GPs
    for i=1:InputIndex.NumberOfElements %Loop for all elements
       mps=Fem.MPs{i,:}; %Material Points in that Finite Element
       InputIndex.NumberOfIntegPoints=size(mps,1);  %Number of material points in that Finite Element
       for j=1:InputIndex.NumberOfIntegPoints %Loop for all integration points
          if Mp.H(1,mps(j,1))<Mp.psi_plus(1,mps(j,1))
              Mp.H(1,mps(j,1))=Mp.psi_plus(1,mps(j,1));
          end
       end
    end
end
%% Define Field Parameters
%Define the incremental Internal Forces Matrix
pint=zeros(dof,1);
%Define incremental external load
[ pres,pext ] = DefineIncrementalExternalForces( inc,pres,P,InputIndex );
if InputIndex.AnalIndex.CrackPropagationIndex(1,1)==0 %case no Crack Propagation
    %Define the Phase Field Residual Matrix
    Fc=[];
elseif InputIndex.AnalIndex.CrackPropagationIndex(1,1)==1 %case Crack Propagation
    %Define the Phase Field Residual Matrix
    [ Fc ] = PhaseFieldForceMatrix( Fem,Mp,InputIndex );
end
%% Define Load Factor Parameters
if InputIndex.SolAlg.SolAlgIndex==1 %case Load Control
    if InputIndex.SolAlg.CaseIndex==1 %case set Index
        InputIndex.SolAlg.Inc=1; %Define increment (only in history case)
        InputIndex.SolAlg.LoadFact=inc*InputIndex.SolAlg.SolAlgParam(InputIndex.SolAlg.Inc,1); %Total Load Factor 
        InputIndex.SolAlg.DLoadFact=InputIndex.SolAlg.SolAlgParam(InputIndex.SolAlg.Inc,1); %Total Incremental of Load Factor
    elseif InputIndex.SolAlg.CaseIndex==2 %case history Index
        InputIndex.SolAlg.Inc=inc; %Define increment (only in history case)
        InputIndex.SolAlg.LoadFact=InputIndex.SolAlg.SolAlgParam(InputIndex.SolAlg.Inc,1); %Total Load Factor 
        InputIndex.SolAlg.DLoadFact=InputIndex.SolAlg.SolAlgParam(InputIndex.SolAlg.Inc,1)-InputIndex.SolAlg.SolAlgParam(inc-1,1); %Total Incremental of Load Factor
    end
elseif InputIndex.SolAlg.SolAlgIndex==2 %case Displacement Control
    if InputIndex.SolAlg.CaseIndex==2 %case displacement history
        InputIndex.SolAlg.Inc=inc; %Define increment (only in history case)
        NodeIndex=InputIndex.SolAlg.SolAlgParam(InputIndex.SolAlg.Inc,6); %Assign the Node Index
        dofGlob=InputIndex.SolAlg.SolAlgParam(InputIndex.SolAlg.Inc,7); %Assign the Degree of Freedom of Node
        [ dofGlob ] = FindDegreeOfFreedomGlobal( NodeIndex,dofGlob,dof,dof ); %Find global degree of freedom
        InputIndex.SolAlg.SolAlgParam(InputIndex.SolAlg.Inc,9)=dofGlob; %Assign the Degree of Freedom of Node
    end
    InputIndex.SolAlg.DLoadFact=0; %Total Incremental of Load Factor
    InputIndex.SolAlg.DDLoadFact=0; %Total Iterational of Load Factor
    InputIndex.SolAlg.uIter1=zeros(dof,1); %Total incremental Displacement field at first iteration in each increment
    if InputIndex.ImposKinemConstAlgIndex(1,1)==1 %case Lagrange Multiplier Method
        InputIndex.SolAlg.delta_uf=zeros(UnKnownDis+nkc,1); %Delta displacement field in each iteration
        InputIndex.SolAlg.lagrMulti1=zeros(nkc,1); %Define Lagrange Multiplier vector at first iteration in each increment
    elseif InputIndex.ImposKinemConstAlgIndex(1,1)==2 %case Penalty Method
        InputIndex.SolAlg.delta_uf=zeros(UnKnownDis,1); %Delta displacement field in each iteration
    end
end
end

