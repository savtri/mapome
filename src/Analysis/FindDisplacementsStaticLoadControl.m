function [ u,lagrMulti,Cl,Cff,G,InputIndex ] = FindDisplacementsStaticLoadControl( inc,iter,K,pres,V,UnKnownDis,KnownDis,u,lagrMulti,Fem,Mp,InputIndex )
%% Load Control
KV=transpose(V)*K*V; %rearrange global stiffness matrix
Kff=KV(1:UnKnownDis,1:UnKnownDis); %stiffness matrix assosiaced with unknown stiffness matrix
%PositiveDefineCheck( Kff,InputIndex.SparseIndex ); %Check if stiffness matrix is positive defined
PV=transpose(V)*pres; %rearrange global external force matrix 
pf=PV(1:UnKnownDis,:); %external force matrix assosiaced with unknown stiffness matrix
us=zeros(KnownDis,1); %displacement matrix assosiaced with known stiffness matrix
%Imposition of kinematic constrains
[ Kff,pf,Cl,Cff,G ] = KinemConstrAlg( UnKnownDis,pf,Kff,V,Fem,Mp,InputIndex );
uf=Kff\pf; %solve system
if iter==1 %case first iteration
    u=transpose(V)\[uf(1:UnKnownDis,1);us]; %current displacement in increment
    if InputIndex.ImposKinemConstAlgIndex(1,1)==1 %case Lagrange Multiplier Method
        lagrMulti(:,1)=uf(UnKnownDis+1:size(uf,1),1); %current Lagrange Multipliers in increment
    end
else %case other iterations
    u=transpose(V)\[uf(1:UnKnownDis,1);us]+u; %current displacement in increment
    if InputIndex.ImposKinemConstAlgIndex(1,1)==1 %case Lagrange Multiplier Method
        lagrMulti(:,1)=uf(UnKnownDis+1:size(uf,1),1)+lagrMulti(:,1); %current Lagrange Multipliers in increment
    end
end
end