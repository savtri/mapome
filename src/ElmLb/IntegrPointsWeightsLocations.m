function [ IntPoinWeights,IntPointLocations ] = IntegrPointsWeightsLocations( i,iid,Fem,Mp,InputIndex )
%% Assign Integration Point Weights and Locations
if InputIndex.AnalIndex.MPMIndex(1,1)==0 %case Material Point
    %Gauss quadrature rule
    [ IntPoinWeights,IntPointLocations ] = GaussPointsQuadrature( InputIndex ); 
elseif InputIndex.AnalIndex.MPMIndex(1,1)==1 %case no Material Point
    %Location of Material Point
    IntPointLocations=Mp.coordsPar(cell2mat(Fem.MPs(i,:)),:);
    %Weight of Material Point (always equal to 1)
    IntPoinWeights=ones(size(IntPointLocations,1),1);    
end
end

