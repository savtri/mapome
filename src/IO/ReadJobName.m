function [ InputIndex ] = ReadJobName( text,fid2,InputIndex )
%% Read the name of the job
idx = find(~cellfun('isempty',strfind(text,'$$JOBS'))) + 1; %Find the Line of Keyword

if ~isempty(idx)
    LWm = cellfun(@(x) textscan(x,'%c'),text(idx),'un',0); %Read the line
    LWm = cell2mat([LWm{:}]).'; %Assign the text of this line
    JobIndex(1,:)=LWm;
    InputIndex.JobIndex=JobIndex; %Assign Job Index
    mkdir_if_not_exist(InputIndex.JobIndex); %Create a folder with Job's name 
    NameInput=InputIndex.JobIndex; %Assign the name of the folder of this Job
else
   error('$$JOBS key is not present');
end
%% Read Material Point Method Index
idx = find(~cellfun('isempty',strfind(text,'$MATERIAL_POINT_METHOD'))) + 1;
iMPM = cellfun(@(x) textscan(x,'%f'),text(idx),'un',0);
iMPM = cell2mat([iMPM{:}]).';
if iMPM(1,1)==0 %case no MPM
    %Assign Job Index
    path=[InputIndex.JobIndex filesep 'FEM']; %Assign the Path
    InputIndex.JobIndex=path;
elseif iMPM(1,1)==1 %case MPM
    %Assign Job Index
    path=[InputIndex.JobIndex filesep 'MPM']; %Assign the Path
    InputIndex.JobIndex=path;
end
%Create a folder FEM/MMPM
mkdir_if_not_exist(InputIndex.JobIndex);

%% Create subfolders in Job folder
%Animation Subfolder
path=[InputIndex.JobIndex filesep 'Animation']; %Assign the Path
mkdir_if_not_exist(path);
%Draw Subfolder
path=[InputIndex.JobIndex filesep 'Draw']; %Assign the Path
mkdir_if_not_exist(path);
%Output Subfolder
path=[InputIndex.JobIndex filesep 'Output']; %Assign the Path
mkdir_if_not_exist(path);
%Input Subfolder
path=[InputIndex.JobIndex filesep 'Input']; %Assign the Path
mkdir_if_not_exist(path);
%Restart Subfolder
path=[InputIndex.JobIndex filesep 'Restart']; %Assign the Path
mkdir_if_not_exist(path);

%% Copy Input Files into Job folder
%Copy the Input Data file into Job folder
path=[InputIndex.JobIndex filesep 'Input' filesep strcat(NameInput,'.inp')]; %Assign the Path
copyfile(fid2,path,'f');
%Create the place the Input Address file into Job folder
textAddress(1,:)=cellstr('$$INPUT_ADDRESS_FILE'); %First Line of Input Address File
textAddress(2,:)=cellstr(strcat('Input',NameInput,'.inp')); %Change the Input Data File Name
path=[InputIndex.JobIndex filesep 'Input' filesep 'InputAddressFile.inp']; %Assign the Path
fidAd=path; %Path for file
fidAd=fopen(fidAd,'w'); %Open file
%Create the new Input Address file
for i=1:2
    LWm = cellfun(@(x) textscan(x,'%c'),textAddress(i),'un',0);
    LWm = cell2mat([LWm{:}]).';
    fprintf(fidAd,'%s\n',LWm);
end
fidAd=fclose(fidAd); %Close the Input Address File
end