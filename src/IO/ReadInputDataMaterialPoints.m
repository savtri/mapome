function [ nMp,MpProp ] = ReadInputDataMaterialPoints( InputIndex )
%% Read the Input Data of Material Points
path=InputIndex.AnalIndex.MaterialPointsAdressIndex;
%Read the whole text
fid=fopen(path,'r');
text = textscan(fid,'%s','Delimiter','');
text = text{1};
fid  = fclose(fid);

%% Find the Number of Material Points
%Find the start index
startIdx = find(~cellfun('isempty',strfind(text,'$$MATERIAL_POINTS')));
%Find the end index
endIdx=find(~cellfun('isempty',strfind(text,'$$')));
%Re-Assign start/end index 
startIdx=startIdx+1;
endIdx=endIdx(2,1)-1;
%Find the total number of Material Points
nMp=endIdx-startIdx+1;

%% Read material points properties
MpProp=cellfun(@(x) textscan(x,'%f'),text(startIdx:endIdx),'un',0);
MpProp=cell2mat([MpProp{:}]).';
end

