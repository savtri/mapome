function [ Nm ] = ShapeFunctionMatrix( i,N,Fem )
%% Convert Shape Functions to Matrix Form
nNodes=Fem.nNodes(i,1);
ndofs=Fem.nDofPerNode(i,1);
Nm(1,1:2:ndofs*nNodes)=N;
Nm(2,2:2:ndofs*nNodes)=N;
end

