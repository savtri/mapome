function [ InputIndex ] = ReadDrawIndexesGeneral( text,InputIndex )
%% Read if you want draw initial structure in draw folder
idx = find(~cellfun('isempty',strfind(text,'$DRAW_INITIAL_STRUCTURE'))) + 1;

if ~isempty(idx)

    LWm = cellfun(@(x) textscan(x,'%f'),text(idx),'un',0);
    LWm = cell2mat([LWm{:}]).';
    DrawInitialStructureIndex(1,:)=LWm;
    InputIndex.DrawIndex.DrawInitialStructureIndex=DrawInitialStructureIndex;

end

%% Read Graphs Parameters 
[ InputIndex ] = ReadDrawGraphsIndexes( text,InputIndex );
end

