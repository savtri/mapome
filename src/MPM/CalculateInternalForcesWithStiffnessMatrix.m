function [ pint,Fem,Mp,InputIndex ] = CalculateInternalForcesWithStiffnessMatrix( inc,u,pint,Fem,Mp,InputIndex )
tic %Start Time for Internal Forces
%% Define analysis indexes
iMatNL=InputIndex.AnalIndex.MaterialNLIndex(1,1); %Material non-linearity Index
iCrProp=InputIndex.AnalIndex.CrackPropagationIndex(1,1); %Crack Propagation Index
%% Evaluate internal forces / phase field residuals
for i=1:InputIndex.NumberOfElements %Loop for all elements
     mps=Fem.MPs{i,:}; %Material Points in that Finite Element
     InputIndex.NumberOfIntegPoints=size(mps,1);  %Number of material points in that Finite Element
     %Find the local displacements
     [ ulocal ] = DisplacementsLocal( i,Fem,u );
     %dof Element
     dofEl=2*size(Fem.NodeIndex(i,:),2);
     %Number Of Integration Points
     ngp=InputIndex.NumberOfIntegPoints;
     %Initialize Force Vectors   
     pintgp=zeros(dofEl,ngp);
     for j=1:InputIndex.NumberOfIntegPoints %Loop for all integration points
         %Define Material Properties
         E=InputIndex.E(Mp.GroupType(mps(j,1),1)); %Assign Young's modulus
         v=InputIndex.v(Mp.GroupType(mps(j,1),1)); %Assign Poisson ratio
         l=InputIndex.Lambda(Mp.GroupType(mps(j,1),1)); %Assign Lambda (lame constant)
         mu=InputIndex.mu(Mp.GroupType(mps(j,1),1)); %Assign mu (lame constant)         
         if iMatNL==1 %case Material non-linearity
            %Define Hardening Parameters
            NumberOfHardeningPoints=InputIndex.NumberOfHardeningPoints(Mp.GroupType(mps(j,1),1)); %Number of Hardening Points
            HardeningPoints=(cell2mat(InputIndex.HardeningPoints(Mp.GroupType(mps(j,1),1))))'; %Hardening Points
         end
         if iCrProp==1 %case crack propagation
            lo=InputIndex.lo(Mp.GroupType(mps(j,1),1)); %length scale parameter (Phase-Field)
            Gc=InputIndex.Gc(Mp.GroupType(mps(j,1),1)); %critical energy rate (Phase-Field)  
            k=InputIndex.k(Mp.GroupType(mps(j,1),1)); %k parameter (Phase-Field) 
         end
         %Derivatives
         B=Mp.B{mps(j,1),1};
         %Volume
         dVolume=Mp.vol(mps(j,1),1);
         %Calculate the increments and total strains 
         einc(1:3,1)=B*ulocal; %incremental strain 
         Mp.e(1:3,mps(j,1))=Mp.eo(1:3,mps(j,1))+einc(1:3,1); %total strain
         %Evolution of Stresses
         if iMatNL==1 %case Material non-linearity
            %Plasticity algorithms
            [ Fem,Mp,InputIndex ] = EvolutionOfPlasticity( inc,i,j,mps(j,1),E,v,NumberOfHardeningPoints,HardeningPoints,Fem,Mp,InputIndex );
         elseif iCrProp==1 %case crack propagation
             %Phase field algorithms
             [ Fem,Mp,InputIndex ] = EvolutionOfFractureFEM( inc,i,j,mps(j,1),E,v,l,mu,k,Fem,Mp,InputIndex );
         end
         %Calculate incremental Internal Forces
         pintgp(:,j)=dVolume*B'*(Mp.s(1:3,mps(j,1))-Mp.so(1:3,mps(j,1)));
     end
     %Calculate incremental Global Internal Forces
     [ pint ] = InternalForces( i,pint,pintgp,Fem );
end
X=sprintf('Internal Forces: ok'); %Assign
disp(X); %Display 
toc %End Time for Internal Forces
end

