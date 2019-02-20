function [ Fem ] = CreateFiniteElements( InputIndex )
%% Create Finite Elements
nNodes=size(InputIndex.Elements(1,:),2)-1;
nEl=InputIndex.NumberOfElements;
Fem.NodeIndex=InputIndex.Elements(:,1:nNodes);
Fem.nNodes(1:nEl,1)=nNodes;
Fem.nDofPerNode(1:nEl,1)=2;
Fem.GroupType(1:nEl,1)=InputIndex.Elements(:,nNodes+1);
end

