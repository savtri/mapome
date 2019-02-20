function [ ulocal ] = DisplacementsLocal( i,Fem,u )
nnEl=size(Fem.NodeIndex(i,:),2); %Number of nodes in each element
n=zeros(nnEl,1); %Nodes Connectivity of element
ulocal=zeros(2*nnEl,1); %Define local displacement  field
for k=1:nnEl
    n(k,1)=Fem.NodeIndex(i,k);
    ulocal(2*k-1:2*k,1)=u(2*n(k,1)-1:2*n(k,1),1);
end
end

