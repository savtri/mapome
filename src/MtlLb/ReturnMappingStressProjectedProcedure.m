function [ Fem,Mp ] = ReturnMappingStressProjectedProcedure( i,j,iid,E,v,NumberOfHardeningPoints,HardeningPoints,Fem,Mp,InputIndex )
%% Return Mapping Plane Stress Procedure
Mp.dg(1,iid)=0;
G=E/(2*(1+v));
K1=E/(3*(1-2*v));
%Volumetric strain
eev(j,1)=(Mp.e(1,iid)+Mp.e(2,iid))*2*G/(K1+(4/3)*G);
%Elastic trial deviatoric strain
eet(1,j)=Mp.e(1,iid)-eev(j,1)/3;
eet(2,j)=Mp.e(2,iid)-eev(j,1)/3;
eet(3,j)=0.5*Mp.e(3,iid);    
%Elastic trial stress components
strial(1,j)=2*G*eet(1,j)+K1*eev(j,1);
strial(2,j)=2*G*eet(2,j)+K1*eev(j,1);
strial(3,j)=2*G*eet(3,j);
%Compute yield function value at trial state
a1=(strial(1,j)+strial(2,j))^2;
a2=(strial(2,j)-strial(1,j))^2;
a3=strial(3,j)^2;
xi=(1/6)*a1+(1/2)*a2+2*a3;
%set previously (equilibrium) converged accumulated plastic strain
[ sy ] = SyInterpolationFunction( Mp.epnEquil(iid,1),NumberOfHardeningPoints,HardeningPoints );
phi(j,1)=(1/2)*xi-(1/3)*sy^2;
ep0=0;
if (phi(j,1)/sy)>InputIndex.AnalIndex.TolerancePlasticityIndex(1,1)
    disp('Plastic Step')
    ep(j,1)=Mp.epnEquil(iid,1);
    for h=1:InputIndex.AnalIndex.MaxIterationsPlasticityIndex(1,1)
        %Check if this algorithm can converg for this specific tolerance
        [ checkMaxIter ]=CheckForMaxIterations( h,InputIndex.AnalIndex.MaxIterationsPlasticityIndex(1,1) );
        [ H ] = HardeningInterpolationFunction( ep(j,1),NumberOfHardeningPoints,HardeningPoints );
        Coefxi1=-((strial(1,j)+strial(2,j))^2)*E/(((9*(1+E*Mp.dg(1,iid)/(3*(1-v)))^3))*(1-v));
        Coefxi2=-(2*G*(((strial(2,j)-strial(1,j))^2)+4*(strial(3,j)^2))/((1+2*G*Mp.dg(1,iid))^3));
        dxi=Coefxi1+Coefxi2;
        Hbar=2*sy*(sqrt(xi)+(Mp.dg(1,iid)*dxi/(2*sqrt(xi))))*H*sqrt(2/3);
        dphi=0.5*dxi-(1/3)*Hbar;
        Mp.dg(1,iid)=Mp.dg(1,iid)-phi(j,1)/dphi;
        Coefxi1=((strial(1,j)+strial(2,j))^2)/((6*(1+E*Mp.dg(1,iid)/(3*(1-v)))^2));
        Coefxi2=(0.5*((strial(2,j)-strial(1,j))^2)+2*(strial(3,j)^2))/((1+2*G*Mp.dg(1,iid))^2);
        xi=Coefxi1+Coefxi2;
        ep(j,1)=Mp.epnEquil(iid,1)+Mp.dg(1,iid)*sqrt(2*xi/3);
        [ sy ] = SyInterpolationFunction( ep(j,1),NumberOfHardeningPoints,HardeningPoints );
        phi(j,1)=(1/2)*xi-(1/3)*sy^2;
        resnor=abs(phi(j,1)/sy);
        if resnor<=InputIndex.AnalIndex.TolerancePlasticityIndex(1,1)
            Mp.e(5,iid)=ep(j,1);
            A11ast=3*(1-v)/(3*(1-v)+E*Mp.dg(1,iid));
            A22ast=1/(1+2*G*Mp.dg(1,iid));
            A33ast=A22ast;
            A=[0.5*(A11ast+A22ast) 0.50*(A11ast-A22ast) 0;0.50*(A11ast-A22ast) 0.50*(A11ast+A22ast) 0;0 0 A33ast];
            Mp.s(1:3,iid)=A*strial(:,j);
            Mp.e(1,iid)=(1/(2*G))*((2/3)*Mp.s(1,iid)-(1/3)*Mp.s(2,iid))+(1/3)*(1/3)*(Mp.s(1,iid)+Mp.s(2,iid))/K1;
            Mp.e(2,iid)=(1/(2*G))*((2/3)*Mp.s(2,iid)-(1/3)*Mp.s(1,iid))+(1/3)*(1/3)*(Mp.s(1,iid)+Mp.s(2,iid))/K1;
            Mp.e(3,iid)=(1/(2*G))*2*Mp.s(3,iid);
            Mp.e(4,iid)=-v*(Mp.e(1,iid)+Mp.e(2,iid))/(1-v);
            Mp.smax(1,iid)=((Mp.s(1,iid)+Mp.s(2,iid))/2)+((((Mp.s(1,iid)-Mp.s(2,iid))/2).^2)+(Mp.s(3,iid)^2)).^(1/2);
            Mp.smin(1,iid)=((Mp.s(1,iid)+Mp.s(2,iid))/2)-((((Mp.s(1,iid)-Mp.s(2,iid))/2).^2)+(Mp.s(3,iid)^2)).^(1/2);
            Peff=(Mp.s(1,iid)+Mp.s(2,iid))/3;
            Mp.seff(1,iid)=sqrt((3/2)*(((Mp.s(1,iid)-Peff)^2)+((Mp.s(2,iid)-Peff)^2)+2*(Mp.s(3,iid)^2)+Peff^2));
            break;
        end
     end
 else
    Mp.s(1:3,iid)=strial(:,j);
    Mp.e(1:3,iid)=Mp.e(1:3,iid);
    Mp.e(4,iid)=-(v/(1-v))*(Mp.e(1,iid)+Mp.e(2,iid));
    Mp.e(5,iid)=0;
    Mp.smax(1,iid)=((Mp.s(1,iid)+Mp.s(2,iid))/2)+((((Mp.s(1,iid)-Mp.s(2,iid))/2).^2)+(Mp.s(3,iid)^2)).^(1/2);
    Mp.smin(1,iid)=((Mp.s(1,iid)+Mp.s(2,iid))/2)-((((Mp.s(1,iid)-Mp.s(2,iid))/2).^2)+(Mp.s(3,iid)^2)).^(1/2);
    Peff=(Mp.s(1,iid)+Mp.s(2,iid))/3;
    Mp.seff(1,iid)=sqrt((3/2)*(((Mp.s(1,iid)-Peff)^2)+((Mp.s(2,iid)-Peff)^2)+2*(Mp.s(3,iid)^2)+Peff^2));
end 
end

