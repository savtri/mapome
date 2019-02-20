function [ InputIndex ] = ReadMaterialPointMethodIndexes( text,textAddress,InputIndex )
%% Read the material point method index
idx = find(~cellfun('isempty',strfind(text,'$MATERIAL_POINT_METHOD'))) + 1;

if ~isempty(idx)

    LWm = cellfun(@(x) textscan(x,'%f'),text(idx),'un',0);
    LWm = cell2mat([LWm{:}]).';
    MPMIndex(1,:)=LWm;
    InputIndex.AnalIndex.MPMIndex=MPMIndex(1,1);

    %% Assign Index for Storing/Loading the Initial Grid
    InputIndex.MpProps.InitialGrid=1; 

    %% Assign Index for Cartesian grid type
    InputIndex.MpProps.CartesianGrid=MPMIndex(1,2:size(MPMIndex,2));

    %% Read the address of the material points input file
    if InputIndex.AnalIndex.MPMIndex(1,1)==1 %case Material Point Method
        %case Linear Boundary Conditions
        idx = find(~cellfun('isempty',strfind(text,'$INPUT_ADDRESS_FILE_MATERIAL_POINTS'))) + 1;
        LWm = cellfun(@(x) textscan(x,'%c'),text(idx),'un',0);
        LWm = cell2mat([LWm{:}]).';
        MaterialPointsAdressIndex(1,:)=LWm;
        path=['Input' filesep MaterialPointsAdressIndex]; %Assign the Path
        InputIndex.AnalIndex.MaterialPointsAdressIndex=path;
        %copy the Input Material Points Data
        path=[InputIndex.JobIndex filesep 'Input' filesep MaterialPointsAdressIndex]; %Assign the Path
        copyfile(InputIndex.AnalIndex.MaterialPointsAdressIndex,path,'f');
    end
else
    error('$MATERIAL_POINT_METHOD key missing in input file');
    
end
end

