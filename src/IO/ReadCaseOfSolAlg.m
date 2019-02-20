function [ InputIndex ] = ReadCaseOfSolAlg( text,InputIndex )
idx = find(~cellfun('isempty',strfind(text,'$$SOLUTION_ALGORITHM'))) + 1;

if ~isempty(idx)
    LWm = cellfun(@(x) textscan(x,'%c'),text(idx),'un',0);
    LWm = cell2mat([LWm{:}]).';
    if strcmp(LWm,'$LOAD_CONTROL') %case Load Control
        SolAlgIndex(1,:)=1;
    elseif strcmp(LWm,'$DISPLACEMENT_CONTROL') %case Displacement Control 
        SolAlgIndex(1,:)=2;
    end
    InputIndex.SolAlg.SolAlgIndex=SolAlgIndex; %Assign Solution Algorithm Index
else
    error('$$SOLUTION_ALGORITHM keu must exist');
end
end

