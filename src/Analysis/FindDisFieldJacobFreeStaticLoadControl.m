function [ u,InputIndex ] = FindDisFieldJacobFreeStaticLoadControl( inc,iter,pext,V,UnKnownDis,KnownDis,Fem,Mp,InputIndex )
%% Load Control (Jacob Free)
tol=InputIndex.JacobFreeNewtonKrylovIndex(1,2); %Newton Krylov Tolerance
max_iter=InputIndex.JacobFreeNewtonKrylovIndex(1,3); %Max number of Newton iterations
pint=zeros(InputIndex.DegreeOfFreedom,1);
%Define the Initial Guess for displacement field
u0=zeros(1,UnKnownDis); %Assign Initial Guess for displacement field
%Find Displacement field
[uf, Ruf ] = JFNK(@(uf)DisFieldJacobFree( uf,inc,pext,pint,KnownDis,UnKnownDis,V,Fem,Mp,InputIndex ),u0,tol,max_iter);
uf=uf';
us=zeros(KnownDis,1); %known displacements 
u=transpose(V)\[uf(1:UnKnownDis,1);us]; %current displacement in increment
end