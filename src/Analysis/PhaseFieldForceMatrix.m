function [ Fc ] = PhaseFieldForceMatrix( Fem,Mp,InputIndex )
%% Define phase field 'Force' Matrix
Fc=zeros(InputIndex.NumberOfNodes,1);
%% Evaluate phase field 'Force' Matrix
if InputIndex.AnalIndex.CrackPropagationIndex(1,1)==1 %case Crack Propagation
    for i=1:InputIndex.NumberOfElements %Loop for all elements
         mps=Fem.MPs{i,:}; %Material Points in that Finite Element
         InputIndex.NumberOfIntegPoints=size(mps,1);  %Number of material points in that Finite Element
         %Define Fracture Parameters
         fc=zeros(size(Fem.NodeIndex(i,:),2),1);
         for j=1:InputIndex.NumberOfIntegPoints %Loop for all integration points
             %Volume
             dVolume=Mp.vol(mps(j,1),1);
             A3=Mp.N{mps(j,1),1}*1;
             fc=fc+A3*dVolume;
         end
         %Calculate Global Phase Field Matrix
         [ Fc ] = PhaseFieldFEM( i,Fc,fc,Fem );
    end
end
