function [ DissEnergy,Fem,Mp,InputIndex ] = UpdateTotFracQuant(inc,iter,Fem,Mp,InputIndex)
%% Evaluate the Total Dissipated Energy
nMatPoints=InputIndex.NumberTotOfIntegPoints;
DissEnergy=0;
for imat=1:nMatPoints
    DissEnergy=DissEnergy+Mp.Ec(1,imat);
end
end