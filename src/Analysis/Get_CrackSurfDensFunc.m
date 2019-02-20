function [ Mp ] = Get_CrackSurfDensFunc( lo,Mp,matId,InputIndex  )
%% Evaluate the crack density function
%Crack Surface Density Function (Miehe et el (2010)  eq. (7))
Coef=(1.0/(4.0*lo));
A1=(Mp.c(1,matId)-1.0)^2;
A2=4.0*(lo^2)*((Mp.dc(1,matId)^2)+(Mp.dc(2,matId)^2));
Mp.CrackSurfDensFunc(1,matId)=Coef*(A1+A2);
end