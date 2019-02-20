function [ K,Fem,InputIndex ] = CalculateStiffnessMatrix( inc,iter,K,Fem,Mp,InputIndex )
if InputIndex.JacobFreeNewtonKrylovIndex(1,1)==0 %case with stiffness matrix
tic %Start Time for Global Stiffness matrix
%% Define analysis indexes
iMatNL=InputIndex.AnalIndex.MaterialNLIndex(1,1); %Material non-linearity Index
iCrProp=InputIndex.AnalIndex.CrackPropagationIndex(1,1); %Crack Propagation Index
%% Evaluate Global Stiffness matrix
for i=1:InputIndex.NumberOfElements %Loop for all elements
     mps=Fem.MPs{i,:}; %Material Points in that Finite Element
     InputIndex.NumberOfIntegPoints=size(mps,1);  %Number of material points in that Finite Element
     %Define stiffness matrix of element
     k=zeros(2*size(Fem.NodeIndex(i,:),2),2*size(Fem.NodeIndex(i,:),2));
     for j=1:InputIndex.NumberOfIntegPoints %Loop for all integration points
         %Define Material Properties
         E=InputIndex.E(Mp.GroupType(mps(j,1),1)); %Assign Young's modulus
         v=InputIndex.v(Mp.GroupType(mps(j,1),1)); %Assign Poisson ratio
         l=InputIndex.Lambda(Mp.GroupType(mps(j,1),1)); %Assign Lambda (lame constant)
         mu=InputIndex.mu(Mp.GroupType(mps(j,1),1)); %Assign mu (lame constant)
         if iMatNL==1 
            NumberOfHardeningPoints=InputIndex.NumberOfHardeningPoints(Mp.GroupType(mps(j,1),1)); %Assign Number Of Hardening Points
            HardeningPoints=(cell2mat(InputIndex.HardeningPoints(Mp.GroupType(mps(j,1),1))))'; %Assign Hardening Points
         elseif iCrProp==1 %case Crack Propagation
            kPF=InputIndex.k(Mp.GroupType(mps(j,1),1)); %k parameter (Phase-Field)
         end
         %Strain-Displacement Matrix
         B=Mp.B{mps(j,1),1};
         %Volume
         dVolume=Mp.vol(mps(j,1),1);
         if iMatNL==1
            if Mp.e(5,mps(j,1))~=0 %case Material non-linearity
                %Constitutive matrix
                [ De ] = ElasticTensor( E,v,InputIndex );
                %Compute elastoplastic consistent tangent matrix
                [ Dmatx ] = ComputeElastoplasticConsistentTangent( j,i,mps(j,1),De,E,v,NumberOfHardeningPoints,HardeningPoints,Fem,Mp,InputIndex );
            else %case Elastic
                %Constitutive matrix
                [ Dmatx ] = ElasticTensor( E,v,InputIndex );
            end
         elseif iCrProp==1 %case crack propagation
             %Damage Elastic Tangent Contitutive Matrix
             [ Dmatx,InputIndex ] = ComputeDamageElasticConsistentTangent( inc,j,i,mps(j,1),l,mu,E,v,kPF,Fem,Mp,InputIndex );
         else %case Elastic
             %Constitutive matrix
             [ Dmatx ] = ElasticTensor( E,v,InputIndex );             
         end
         %Assign stiffness matrix due to Gauss point j
         k=k+B'*Dmatx*B*dVolume;         
     end
     %Add to Global Stiffeness matrix
     [ K ] = StiffnessMatrix( i,K,k,Fem );
end
X=sprintf('Global Stiffness matrix: ok'); %Assign
disp(X); %Display 
toc %End Time for Global Stiffness matrix
end
end

