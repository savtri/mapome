function [ u,U ] = DefineDisplacementMatrix( InputIndex )
%% Define Displacement Matrix
u=zeros(InputIndex.DegreeOfFreedom,1); %Define incremental displacement field
%Total Displacement Matrix
U=zeros(InputIndex.DegreeOfFreedom,1);
end

