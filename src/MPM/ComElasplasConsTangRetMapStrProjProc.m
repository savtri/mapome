function [ Dmatx ] = ComElasplasConsTangRetMapStrProjProc( j,i,iid,Fem,Mp,De,E,v,NumberOfHardeningPoints,HardeningPoints )
%% Elastoplastic Tangent Plane Stress
PP=(1/3)*[2 -1 0;-1 2 0;0 0 6];
xi=Mp.s(1:3,iid)'*PP*Mp.s(1:3,iid);
[ H ] = HardeningInterpolationFunction( Mp.e(5,iid),NumberOfHardeningPoints,HardeningPoints );
C=inv(De);
E1=inv(C+Mp.dg(1,iid)*PP);
n1=E1*PP*Mp.s(1:3,iid);
a=inv(Mp.s(1:3,iid)'*PP*n1+2*xi*H/(3-2*H*Mp.dg(1,iid)));
Dmatx=E1-a*n1*n1';
end

