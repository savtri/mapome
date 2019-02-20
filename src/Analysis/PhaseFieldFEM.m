function [ Rc ] = PhaseFieldFEM( i,Rc,PFintgp,Fem )
%% Assign local phase field to global phase field
%Sum Phase-Field from all gauss points
PFintgp=sum(PFintgp,2);
%Find Global Degree of Freedom in i element
sctrB=[];
for j=1:size(Fem.NodeIndex(i,:),2)
    sctrB=[sctrB;Fem.NodeIndex(i,j)];
end
%Assign local internal forces to global internal forces
Rc(sctrB,1)=Rc(sctrB,1)+PFintgp;
end