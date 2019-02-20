function [ Kffg,Rg,Cl,Cff,G ] = KinemConstrAlg( UnKnownDis,pf,Kff,V,Fem,Mp,InputIndex )
%% Imposition of kinematic constrains
%Bathe 2007 Finite Element Procedures (pp. 143)
%Define the Kinematic Constrains Matrices
[ nkc,Cl,G ] = KinemConstrMatrices( Fem,Mp,InputIndex );
CV=transpose(V)*Cl'; %rearrange global coefficient matrix of contrained degree of freedom
Cff=CV(1:UnKnownDis,1:nkc); %coefficient matrix assosiaced with unknown stiffness matrix
if InputIndex.ImposKinemConstAlgIndex(1,1)==1 %case Lagrange Multiplier Method
    %Imposition of kinematic constrains with Lagrange Multiplier Method
    Kffg=[Kff,Cff;Cff',zeros(nkc,nkc)]; %Generalized stiffness matrix (with kinematic constrains)
    Rg=[pf;G]; %Generalized external force matrix (with kinematic constrains)
elseif InputIndex.ImposKinemConstAlgIndex(1,1)==2 %case Penalty Method
    if InputIndex.SparseIndex==1
        Cff=sparse(Cff);
        Cl=sparse(Cl);
    end 
    %Imposition of kinematic constrains with Penalty Method
    a=InputIndex.ImposKinemConstAlgIndex(1,2); %Parameter of Penalty Method
    Kffg=Kff+a*(Cff)*Cff'; %Generalized stiffness matrix (with kinematic constrains)
    if nkc==0 %case no kinematic constrains
        Rg=pf; %Generalized external force matrix (with kinematic constrains)
    else %case at least one kinematic constrains
        Rg=pf+a*(Cff)*G; %Generalized external force matrix (with kinematic constrains)
    end
end
end