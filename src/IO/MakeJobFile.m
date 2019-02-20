function [ InputIndex ] = MakeJobFile( fid )
%% Read the whole text
text = textscan(fid,'%s','Delimiter','');
text = text{1};
fid  = fclose(fid);

%% Read Abaqus or Savvas Input
idx = find(~cellfun('isempty',strfind(text,'$$ABAQUS'))) + 1;
LWm = cellfun(@(x) textscan(x,'%f'),text(idx),'un',0);
LWm = cell2mat([LWm{:}]).';
InputIndex.ReadInput=LWm;

%% Read the name of the job
idx = find(~cellfun('isempty',strfind(text,'$$JOBS'))) + 1;
LWm = cellfun(@(x) textscan(x,'%c'),text(idx),'un',0);
LWm = cell2mat([LWm{:}]).';
JobIndex(1,:)=LWm;
InputIndex.JobIndex=JobIndex;
mkdir_if_not_exist(InputIndex.JobIndex);
end

