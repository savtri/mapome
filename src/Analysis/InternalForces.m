function [ pint ] = InternalForces( i,pint,pintgp,Fem )
%% Assign local internal forces to global internal forces
%Sum internal forces from all gauss points
pintgp=sum(pintgp,2);
%Find Global Degree of Freedom in i element
sctrB=[];
for j=1:size(Fem.NodeIndex(i,:),2)
    sctrB=[sctrB 2*Fem.NodeIndex(i,j)-1 2*Fem.NodeIndex(i,j)];
end
%Assign local internal forces to global internal forces
pint(sctrB,1)=pint(sctrB,1)+pintgp;
end

