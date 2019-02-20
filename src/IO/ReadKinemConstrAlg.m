function [ InputIndex ] = ReadKinemConstrAlg( text,InputIndex )
%% Imposition of kinematic constrains algorithm
idx=find(~cellfun('isempty',strfind(text,'$$IMPOSITION_KINEM_CONSTRAINS'))) + 1;
LWm=cellfun(@(x) textscan(x,'%f'),text(idx),'un',0);
LWm=cell2mat([LWm{:}]).';
InputIndex.ImposKinemConstAlgIndex(1,:)=LWm; 
end

