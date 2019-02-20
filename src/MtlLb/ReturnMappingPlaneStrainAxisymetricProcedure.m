function [ Fem,Mp ] = ReturnMappingPlaneStrainAxisymetricProcedure( i,j,iid,E,v,NumberOfHardeningPoints,HardeningPoints,Fem,Mp,InputIndex )
%% Return Mapping Plane Strain/Axisymetric Procedure
Mp.dg(1,iid)=0;
G=E/(2*(1+v));
K1=E/(3*(1-2*v));
%Volumetric strain
Mp.e(4,iid)=0;
eev(j,1)=Mp.e(1,iid)+Mp.e(2,iid)+Mp.e(4,iid);
P=K1*eev(j,1);
%Elastic trial deviatoric strain
eet(1,j)=Mp.e(1,iid)-eev(j,1)/3;
eet(2,j)=Mp.e(2,iid)-eev(j,1)/3;
eet(4,j)=Mp.e(4,iid)-eev(j,1)/3;
%Convert engineering shear component into physical component
eet(3,j)=Mp.e(3,iid)/2;
%Compute trial effective stress and uniaxial yield stress
varj2t=((2*G)^2)*((eet(3,j)^2)+0.50*((eet(1,j)^2)+(eet(2,j)^2)+(eet(4,j)^2)));
qtrail=sqrt(3*varj2t);
[ sy ] = SyInterpolationFunction( Mp.epnEquil(iid,1),NumberOfHardeningPoints,HardeningPoints );
phi(j,1)=qtrail-sy;
if (phi(j,1)/sy)>InputIndex.AnalIndex.TolerancePlasticityIndex(1,1)
    disp('Plastic Step')
    %Plastic step: Apply return mapping - use Newton-Raphson algorithm to solve the return mapping equation (Box 7.4)
    ep(j,1)=Mp.epnEquil(iid,1);
    for h=1:InputIndex.AnalIndex.MaxIterationsPlasticityIndex(1,1)
        %Compute residual derivative
        [ checkMaxIter ]=CheckForMaxIterations( h,InputIndex.AnalIndex.MaxIterationsPlasticityIndex(1,1) );
        [ H ] = HardeningInterpolationFunction( ep(j,1),NumberOfHardeningPoints,HardeningPoints );
        denom=-3*G-H;
        %Compute Newton-Raphson increment and update variable dg
        Ddg=-phi(j,1)/denom;
        Mp.dg(1,iid)=Mp.dg(1,iid)+Ddg;
        %Compute new residual
        ep(j,1)=ep(j,1)+Mp.dg(1,iid);
        [ sy ] = SyInterpolationFunction( ep(j,1),NumberOfHardeningPoints,HardeningPoints );
        phi(j,1)=qtrail-3*G*Mp.dg(1,iid)-sy;
        resnor=abs(phi(j,1)/sy);
        if resnor<=InputIndex.AnalIndex.TolerancePlasticityIndex(1,1)
            Mp.e(5,iid)=ep(j,1);
            %update stress components
            factorS=2*G*(1-3*G*Mp.dg(1,iid)/qtrail);
            Mp.s(1,iid)=factorS*eet(1,j)+P;
            Mp.s(2,iid)=factorS*eet(2,j)+P;
            Mp.s(3,iid)=factorS*eet(3,j);
            Mp.s(4,iid)=factorS*eet(4,j)+P;
            %compute converged elastic (engineering) strain components
            factorE=factorS/(2*G);
            Mp.e(1,iid)=factorE*eet(1,j)+eev(j,1)/3;
            Mp.e(2,iid)=factorE*eet(2,j)+eev(j,1)/3;
            Mp.e(3,iid)=factorE*eet(3,j)*2;
            Mp.e(4,iid)=factorE*eet(4,j)+eev(j,1)/3;
            break;
        end
    end
else
    %Elastic step: Update stress using linear elastic law     
    Mp.s(1,iid)=2*G*eet(1,j)+P;
    Mp.s(2,iid)=2*G*eet(2,j)+P;
    Mp.s(3,iid)=2*G*eet(3,j);
    Mp.s(4,iid)=2*G*eet(4,j)+P;
    %elastic engineering strain
    Mp.e(1:4,iid)=Mp.e(1:4,iid);
    Mp.smax(1,iid)=((Mp.s(1,iid)+Mp.s(2,iid))/2)+((((Mp.s(1,iid)-Mp.s(2,iid))/2).^2)+(Mp.s(3,iid)^2)).^(1/2);
    Mp.smin(1,iid)=((Mp.s(1,iid)+Mp.s(2,iid))/2)-((((Mp.s(1,iid)-Mp.s(2,iid))/2).^2)+(Mp.s(3,iid)^2)).^(1/2);
    Peff=(Mp.s(1,iid)+Mp.s(2,iid)+Mp.s(4,iid))/3;
    %A1=(Mp.s(1,iid)-Peff)^2;
    %A2=(Mp.s(2,iid)-Peff)^2;
    %A3=2*(Mp.s(3,iid))^2;
    %A4=(Mp.s(4,iid)-Peff)^2;
    %A5=A1+A2+A3+A4;
    %A6=(3/2)*(A5);
    %A7=sqrt(A6);
    Mp.seff(1,iid)=sqrt((3/2)*(((Mp.s(1,iid)-Peff)^2)+((Mp.s(2,iid)-Peff)^2)+2*(Mp.s(3,iid)^2)+(Mp.s(4,iid)-Peff)^2));
end
end

