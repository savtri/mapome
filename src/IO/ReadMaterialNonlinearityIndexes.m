function [ InputIndex ] = ReadMaterialNonlinearityIndexes( text,InputIndex )
%% Read the material nonlinearity indexes
idx = find(~cellfun('isempty',strfind(text,'$MATERIAL_NONLINEARITY'))) + 1;

if ~isempty(idx)
    LWm = cellfun(@(x) textscan(x,'%f'),text(idx),'un',0);
    LWm = cell2mat([LWm{:}]).';
    AnalysisIndex(1,:)=LWm;
    InputIndex.AnalIndex.MaterialNLIndex=AnalysisIndex;
else
    InputIndex.AnalIndex.MaterialNLIndex=0;
end

%% Read the tolerances for plasticity analysis
idx = find(~cellfun('isempty',strfind(text,'-$TOLERANCE_PLASTICITY'))) + 1;

if ~isempty(idx)
    LWm = cellfun(@(x) textscan(x,'%f'),text(idx),'un',0);
    LWm = cell2mat([LWm{:}]).';
    TolerancePlasticityIndex(1,:)=LWm;
    InputIndex.AnalIndex.TolerancePlasticityIndex=TolerancePlasticityIndex;
else
    InputIndex.AnalIndex.TolerancePlasticityIndex=0;
end

%% Read the max iteration for plasticity analysis
idx = find(~cellfun('isempty',strfind(text,'-$MAX_ITERATIONS_PLASTICITY'))) + 1;

if ~isempty(idx)
    LWm = cellfun(@(x) textscan(x,'%f'),text(idx),'un',0);
    LWm = cell2mat([LWm{:}]).';
    MaxIterationsPlasticityIndex(1,:)=LWm;
    InputIndex.AnalIndex.MaxIterationsPlasticityIndex=MaxIterationsPlasticityIndex;
else
    InputIndex.AnalIndex.MaxIterationsPlasticityIndex=0;
end

end

