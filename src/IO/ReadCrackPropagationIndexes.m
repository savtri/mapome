function [ InputIndex ] = ReadCrackPropagationIndexes( text,InputIndex )
%% Read the Crack Propagation index
idx = find(~cellfun('isempty',strfind(text,'$CRACK_PROPAGATION'))) + 1;
LWm = cellfun(@(x) textscan(x,'%f'),text(idx),'un',0);
LWm = cell2mat([LWm{:}]).';
CrackPropagationIndex(1,:)=LWm;
InputIndex.AnalIndex.CrackPropagationIndex=CrackPropagationIndex;
end

