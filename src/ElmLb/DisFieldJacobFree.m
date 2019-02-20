function Ruf = DisFieldJacobFree(uf,inc,P,pint,KnownDis,UnKnownDis,V,Fem,Mp,InputIndex)
%% Find the Dislacement field with Optimization
if size(uf,1)<=1 %case vector row
    uf=uf'; %change vector row to vector column 
end
us=zeros(KnownDis,1); %displacement matrix assosiaced with known stiffness matrix
u=transpose(V)\[uf(1:UnKnownDis,1);us]; %current displacement in increment
%% Evaluate internal forces  
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
         thickness=InputIndex.thickness(Mp.GroupType(mps(j,1),1)); %Assign thickness of element
         %Define Hardening Parameters
         NumberOfHardeningPoints=InputIndex.NumberOfHardeningPoints(Mp.GroupType(mps(j,1),1)); %Number of Hardening Points
         HardeningPoints=(cell2mat(InputIndex.HardeningPoints(Mp.GroupType(mps(j,1),1))))'; %Hardening Points
         %Derivatives
         B=Mp.B{mps(j,1),1};
         %Volume
         dVolume=Mp.vol(mps(j,1),1);
         %Calculate the increments and total strains 
         einc(1:3,1)=B*ulocal; %incremental strain 
         Mp.e(1:3,mps(j,1))=Mp.eo(1:3,mps(j,1))+einc(1:3,1); %total strain
         %Plasticity algorithms
         [ Fem,Mp,InputIndex ] = EvolutionOfPlasticity( inc,i,j,mps(j,1),E,v,NumberOfHardeningPoints,HardeningPoints,Fem,Mp,InputIndex );
         %Calculate Internal Forces
         pintgp(:,j)=dVolume*B'*(Mp.s(1:3,mps(j,1))-Mp.so(1:3,mps(j,1)));
     end
     %Calculate Global Internal Forces
     [ pint ] = InternalForces( i,pint,pintgp,Fem );
end
pext=P;
%Check for congergence
Ru=pext-pint; %Assign Residual of forces
RuV=transpose(V)*Ru; %rearrange global Residual vector force matrix 
Ruf=RuV(1:UnKnownDis,:); %Residual vector matrix assosiaced with unknown stiffness matrix
norm(Ruf);
end

