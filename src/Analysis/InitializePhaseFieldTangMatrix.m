function [ Kc ] = InitializePhaseFieldTangMatrix( InputIndex )
%% Initialize Phase Field Tangential Matrix
if InputIndex.JacobFreeNewtonKrylovIndex(1,1)==0 %case with stiffness matrix
    if InputIndex.SparseIndex(1,1)==0 %case no sparse matrix
        Kc=zeros(InputIndex.NumberOfNodes); 
    elseif InputIndex.SparseIndex(1,1)==1 %case sparse matrix
        Kc=sparse(0); %Define Sparse matrix
    end
elseif InputIndex.JacobFreeNewtonKrylovIndex(1,1)==1 %case no stiffness matrix
    Kc=[]; %Define empty matrix
end
end


