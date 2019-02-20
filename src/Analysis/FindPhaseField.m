function [ c ] = FindPhaseField( inc,iter,c,Kc,Rc,Fem,Mp,InputIndex )
%% Find Phase Field
if InputIndex.JacobFreeNewtonKrylovIndex(1,1)==0 %case with stiffness matrix
    c=Kc\Rc; %solve system
elseif InputIndex.JacobFreeNewtonKrylovIndex(1,1)==1 %case without stiffness matrix
    %tol=InputIndex.JacobFreeNewtonKrylovIndex(1,2); %Newton Krylov Tolerance
    %max_iter=InputIndex.JacobFreeNewtonKrylovIndex(1,3); %Max number of Newton iterations
    %c0=c'; %Assign Initial Guess for Phase Field
    %%Find the Dislacement / Phase Field with GMRES
    %[ c,Fc ] = JFNK(@(c)PhaseFieldJacobFree(c,inc,Fem,Mp,InputIndex),c0,tol,max_iter); 
    %c=c';
end
end