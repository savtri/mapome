function [ InputIndex ] = ReadTimeIndexes( text,InputIndex )
%% Read the duration of the analysis
idx = find(~cellfun('isempty',strfind(text,'$$TIME'))) + 1;

if ~isempty(idx)
    LWm = cellfun(@(x) textscan(x,'%f'),text(idx),'un',0);
    LWm = cell2mat([LWm{:}]).';
    TimeIndex(1,:)=LWm;
    InputIndex.AnalIndex.TimeIndex=TimeIndex; %Assign Dynamic time paramters

    %% Check if time is consistent with total number of increments
    tStart=InputIndex.AnalIndex.TimeIndex(1,1); %start time
    tEnd=InputIndex.AnalIndex.TimeIndex(1,2); %end time
    dt=InputIndex.AnalIndex.TimeIndex(1,3); %time step
    nIncTime=round((tEnd-tStart)/dt); %total number of increments from time parameters
    nIncSolAlg=InputIndex.SolAlg.NumberOfIncrements; %total number of increments from solution algorithm
    if nIncTime~=nIncSolAlg %case not equal
        disp('Increments from solution algorithm are not consistent with time parameters');
        stop
    end
else
    error('$$TIME key must exist');
end

end

