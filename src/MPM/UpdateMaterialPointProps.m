function [ Fem,Mp,InputIndex ] = UpdateMaterialPointProps( u,Fem,Mp,InputIndex )
%% Update Material Points Properties
for i=1:InputIndex.NumberOfElements %Loop for all Elements
    mps=Fem.MPs{i,:}; %Material Points in that Finite Element
    InputIndex.NumberOfIntegPoints=size(mps,1);  %Number of material points in that Finite Element    
    %Find the local displacements
    [ ulocal ] = DisplacementsLocal( i,Fem,u );  
    for j=1:InputIndex.NumberOfIntegPoints %Loop for all Integration Points
        %Shape Function
        N=Mp.N{mps(j,1),1};
        %Convert Shape Functions to Matrix Form
        [ Nm ] = ShapeFunctionMatrix( i,N,Fem );
        %Update Material Point Position
        Mp.coords(mps(j,1),:)=Mp.coords(mps(j,1),:)+(Nm*ulocal)';
        %Update Material Point Displacement
        Mp.u(mps(j,1),:)=Mp.u(mps(j,1),:)+(Nm*ulocal)';
    end
end

for h=1:InputIndex.Loads.NumberOfIndividualLoads %Loop for all Individual Loads
    LoadMatrix=InputIndex.Loads.IndividualLoadIndex(h,:);
    nsize=size(LoadMatrix,2);
    if LoadMatrix(1,nsize)==2 %case Individual Load in Material Point 
        mpIndex=LoadMatrix(1,1);
        DLoadFact=InputIndex.SolAlg.DLoadFact; %Total Current Increment Load Factor
        Mp.Pext(mpIndex,:)=Mp.Pext(mpIndex,:)+DLoadFact*LoadMatrix(1,2:3); %External Forces with load factor
    end
end
end

