function [ K ] = InitializeStiffMatrix( InputIndex )
%% Define Stiffness Matrix (K)
if InputIndex.JacobFreeNewtonKrylovIndex(1,1)==0 %case with stiffness matrix
    if InputIndex.SparseIndex(1,1)==0 %case no sparse matrix
        K=zeros(InputIndex.DegreeOfFreedom); 
    elseif InputIndex.SparseIndex(1,1)==1 %case sparse matrix
        K=sparse(0); %Define Sparse matrix
    end
elseif InputIndex.JacobFreeNewtonKrylovIndex(1,1)==1 %case no stiffness matrix
    K=[]; %Define empty matrix
end
end