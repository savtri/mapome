function [ InputIndex ] = RearrangeActiveGridCellsCoords( InputIndex )
%% Define the new coords of Finite Elements according to active nodes
%% Find new coords of cells
nnIndex=InputIndex.MpProps.ActiveNodesTot(1:InputIndex.MpProps.ActiveNodesNumber,1);
A=InputIndex.IndexXYNodes(nnIndex,:);
A(:,1)=InputIndex.MpProps.ActiveNodesTot(:,2);
InputIndex.IndexXYNodes=A;
end

