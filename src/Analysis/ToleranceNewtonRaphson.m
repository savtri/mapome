function [ tolerance ] = ToleranceNewtonRaphson( inc,InputIndex )
%% Assign Newton-Raphson tolerance
if InputIndex.JacobFreeNewtonKrylovIndex(1,1)==0 %case with stiffness matrix
    if InputIndex.SolAlg.CaseIndex==1 %case set Index
        tolerance=InputIndex.SolAlg.SolAlgParam(1,2);
    elseif InputIndex.SolAlg.CaseIndex==2 %case history Index 
        tolerance=InputIndex.SolAlg.SolAlgParam(inc,2);
    end
elseif InputIndex.JacobFreeNewtonKrylovIndex(1,1)==1 %case without stiffness matrix
    tolerance=InputIndex.JacobFreeNewtonKrylovIndex(1,2); %Newton Krylov Tolerance
end
end

