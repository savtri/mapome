function [ InputIndex ] = ReadIndividualLoads( text,InputIndex )
%% Find the number of Individual Loads
%Find the start index
startIdx = find(~cellfun('isempty',strfind(text,'$L_IDB')));

if ~isempty(startIdx)
    %Find the end index
    endIdx=InputIndex.Dollar(find(InputIndex.Dollar==startIdx)+1,1);
    %Re-Assign start/end index 
    startIdx=startIdx+1;
    endIdx=endIdx-1;
    %Find the total number of Individual loads
    InputIndex.Loads.NumberOfIndividualLoads=endIdx-startIdx+1;

    %% Read the Individual loads
    LWm=cellfun(@(x) textscan(x,'%f'),text(startIdx:endIdx),'un',0);
    InputIndex.Loads.IndividualLoadIndex=cell2mat([LWm{:}]).';
end

end
