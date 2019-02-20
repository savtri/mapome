function [ c,C ] = DefinePhaseFieldMatrix( InputIndex )
%% Define Phase Field Matrix
if InputIndex.AnalIndex.CrackPropagationIndex(1,1)==0 %case no Crack Propagation
    c=[]; %Define incremental Phase-Field
    C=[]; %Define total Phase-Field
elseif InputIndex.AnalIndex.CrackPropagationIndex(1,1)==1 %case Crack Propagation
    c=ones(InputIndex.NumberOfNodes,1); %Define incremental Phase-Field
    C=ones(InputIndex.NumberOfNodes,1); %Define total Phase-Field
end
end

