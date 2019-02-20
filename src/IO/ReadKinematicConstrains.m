function [ InputIndex ] = ReadKinematicConstrains( text,InputIndex )
%% Find the total number of kinematic constrains
%Find the start index
startIdx = find(~cellfun('isempty',strfind(text,'$KINEMATIC')));
%Find the end index   
endIdx=InputIndex.Dollar(find(InputIndex.Dollar==startIdx)+1,1);
%Re-Assign start/end index 
startIdx=startIdx+1;
endIdx=endIdx-1;
%Find the total number of kinematic constrains
InputIndex.Constrains.NumberOfKinemConst=endIdx-startIdx+1;

%% Read the kinematic constrains
LWm=cellfun(@(x) textscan(x,'%f'),text(startIdx:endIdx),'un',0);
for i=1:InputIndex.Constrains.NumberOfKinemConst %Loop for all Kinematic Constrains
    KinemConstIndex=cell2mat([LWm{i,1}]).';
    InputIndex.Constrains.KinemConstIndex{i,1}=KinemConstIndex;
end
end