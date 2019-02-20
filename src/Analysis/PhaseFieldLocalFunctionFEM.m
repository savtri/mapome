function [ clocal ] = PhaseFieldLocalFunctionFEM( i,Fem,c )
nnEl=size(Fem.NodeIndex(i,:),2); %Number of nodes in each element
clocal=zeros(nnEl,1); %Define local Phase Field
n=zeros(nnEl,1); %Nodes Connectivity of element
for k=1:nnEl
    n(k,1)=Fem.NodeIndex(i,k);
    clocal(k,1)=c(n(k,1),1);
end
end