function [ Mp ] = Get_DissipatedEnergy(Gc,Mp,matId)
%% Evaluate the Dissipated Energy in each Material Point
Mp.Ec(1,matId)=Gc*Mp.CrackSurfDensFunc(1,matId)*Mp.vol(matId,1);
end