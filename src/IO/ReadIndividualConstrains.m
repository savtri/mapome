function [ InputIndex ] = ReadIndividualConstrains( text,InputIndex )
%% Find the total number of boundary conditions
%Find the start index
startIdx = find(~cellfun('isempty',strfind(text,'$C_IDB')));

if ~isempty(startIdx)

    %Find the end index
    endIdx=InputIndex.Dollar(find(InputIndex.Dollar==startIdx)+1,1);
    %Re-Assign start/end index 
    startIdx=startIdx+1;
    endIdx=endIdx-1;
    %Find the total number of boundary conditions
    InputIndex.Constrains.NumberOfIndividualConstrains=endIdx-startIdx+1;

    %% Read the nodal constrains
    LWm=cellfun(@(x) textscan(x,'%f'),text(startIdx:endIdx),'un',0);
    InputIndex.Constrains.IndividualConstrainsIndex=cell2mat([LWm{:}]).';
else
    error('$C_IDB key must exist');
end

end

