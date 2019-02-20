function [ Fem,Mp,InputIndex ] = EvolutionOfPlasticity( inc,i,j,iid,E,v,NumberOfHardeningPoints,HardeningPoints,Fem,Mp,InputIndex )
%% Evolution of Plasticity
ElementsType=InputIndex.ElementsType; %Define the elements type
if ElementsType==8 || ElementsType==10 %case Plain Strain
    %RETURN MAPPING PROCEDURE
    [ Fem,Mp ] = ReturnMappingPlaneStrainAxisymetricProcedure( i,j,iid,E,v,NumberOfHardeningPoints,HardeningPoints,Fem,Mp,InputIndex );
elseif ElementsType==9 || ElementsType==11 %case Plain Stress
    %RETURN MAPPING PROCEDURE
    [ Fem,Mp ] = ReturnMappingStressProjectedProcedure( i,j,iid,E,v,NumberOfHardeningPoints,HardeningPoints,Fem,Mp,InputIndex );
end
end

