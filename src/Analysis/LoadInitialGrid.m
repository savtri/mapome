function [ Fem,LoadParameters ] = LoadInitialGrid( )
%% Load Initial Grid
load 'InputIndex.mat';
LoadParameters.IndexXYNodes=InputIndex.IndexXYNodes;
LoadParameters.Constrains.IndividualConstrainsIndex=InputIndex.Constrains.IndividualConstrainsIndex;
LoadParameters.Loads.IndividualLoadIndex=InputIndex.Loads.IndividualLoadIndex;
LoadParameters.NumberOfElements=InputIndex.NumberOfElements;
LoadParameters.NumberOfNodes=InputIndex.NumberOfNodes;
LoadParameters.SolAlg.SolAlgParam=InputIndex.SolAlg.SolAlgParam;
end

