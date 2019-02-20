function [ Dmatx ] = ComElasplasConsTangRetMapPlStrAxisProc ( j,i,iid,Fem,Mp,De,E,v,NumberOfHardeningPoints,HardeningPoints )
%% Elastoplastic Tangent Plane Strain/Axisymetric 
devprj=[0.666666667 -0.333333333 0.00000000;
       -0.333333333  0.666666667 0.00000000;
        0.000000000  0.000000000 0.50000000];
soid=[1;1;0];
G=E/(2*(1+v)); 
K1=E/(3*(1-2*v));
%Hydrostatic pressure
P=(Mp.s(1,iid)+Mp.s(2,iid)+Mp.s(4,iid))*(1/3);
%Deviatoric stress components
s(1,1)=Mp.s(1,iid)-P;
s(2,1)=Mp.s(2,iid)-P;
s(3,1)=Mp.s(3,iid);
s(4,1)=Mp.s(4,iid)-P;
%Recover last elastic trial von Mises effective stress
snorm=sqrt((s(1,1)^2)+(s(2,1)^2)+2*(s(3,1)^2)+(s(4,1)^2));
q=sqrt(3/2)*snorm;
qtrial=q+3*G*Mp.dg(1,iid);
afact=2*G*(1-3*G*Mp.dg(1,iid)/qtrial);
[ H ] = HardeningInterpolationFunction( Mp.e(5,iid),NumberOfHardeningPoints,HardeningPoints );
bfact=6*(G^2)*((Mp.dg(1,iid)/qtrial)-(1/(3*G+H)))/(snorm^2);
Dmatx=afact*devprj+bfact*s(1:3,1)*s(1:3,1)'+K1*soid*soid';
end

