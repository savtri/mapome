function [ K ] = StiffnessMatrix( i,K,k,Fem )
%% Find Global Degree of Freedom in i element
sctrB=[];
for j=1:size(Fem.NodeIndex(i,:),2)
    sctrB=[sctrB 2*Fem.NodeIndex(i,j)-1 2*Fem.NodeIndex(i,j)];
end
%% Assign to Global Stiffness Matrix
K(sctrB,sctrB) = K(sctrB,sctrB)+k;
end

