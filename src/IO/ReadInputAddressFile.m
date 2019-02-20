function [ fid,text ] = ReadInputAddressFile( )
%% Read the address file
path=['Input' filesep 'InputAddressFile.inp']; %Assign the Path of InputAddress File
fid=fopen(path,'r');
text = textscan(fid,'%s','Delimiter','');
text = text{1};
fid  = fclose(fid);
idx = find(~cellfun('isempty',strfind(text,'$$INPUT_ADDRESS_FILE'))) + 1;
LWm = cellfun(@(x) textscan(x,'%c'),text(idx),'un',0);
LWm = cell2mat([LWm{:}]).';
[LWm] = strsplit(LWm,{','});
%% Read the address of Input Data File
fid=strcat('Input',filesep,LWm);
fid=char(fid);
end

