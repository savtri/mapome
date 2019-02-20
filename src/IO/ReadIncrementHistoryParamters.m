function [ InputIndex ] = ReadIncrementHistoryParamters( text,InputIndex )
%% Find the total number of increments
if InputIndex.SolAlg.SolAlgIndex(1,1)==1 %case Load Control
    SolKeyword='$LOAD_CONTROL'; %Assign Keyword
elseif InputIndex.SolAlg.SolAlgIndex(1,1)==2 %case Displacement Control
    SolKeyword='$DISPLACEMENT_CONTROL'; %Assign Keyword
end
%Find the start index
startIdx = find(~cellfun('isempty',strfind(text,SolKeyword)));
%Find the end index
endIdx=InputIndex.Dollar2(find(InputIndex.Dollar2==startIdx-1)+1,1);
%Re-Assign start/end index 
startIdx=startIdx+2;
endIdx=endIdx-1;
%Find the total number increments
InputIndex.SolAlg.NumberOfIncrements=endIdx-startIdx+1;

%% Read history of increments
if InputIndex.SolAlg.SolAlgIndex(1,1)==1 %case Load Control
    %Read the load increments
    InputIndex.SolAlg.SolAlgParam=cellfun(@(x) textscan(x,'%f'),text(startIdx:endIdx),'un',0);
    InputIndex.SolAlg.SolAlgParam=cell2mat([InputIndex.SolAlg.SolAlgParam{:}]).';
elseif InputIndex.SolAlg.SolAlgIndex(1,1)==2 %case Displacement Control
    %Read the displacement increments
    LWm=cellfun(@(x) textscan(x,'%f'),text(startIdx:endIdx),'un',0);
    LWm=cell2mat([LWm{:}]).';    
    MaxLoadFactor=zeros(InputIndex.SolAlg.NumberOfIncrements,1); %Assign max load factor
    MaxDisplacement=LWm(:,7);
    DispIncrement=zeros(InputIndex.SolAlg.NumberOfIncrements,1);
    NodeMPIndex=LWm(:,8); %Node/Material Point Index 
    for i=1:InputIndex.SolAlg.NumberOfIncrements
        if i==1 %case first increment
            DispIncrement(i,1)=LWm(i,7);
        else
            DispIncrement(i,1)=LWm(i,7)-LWm(i-1,7);
        end
    end
    InputIndex.SolAlg.SolAlgParam=[LWm(:,1:4),MaxLoadFactor(:,1),LWm(:,5:6),DispIncrement(:,1),MaxDisplacement(:,1),NodeMPIndex]; %Assign Solution Algorithm Parameters 
end
end
