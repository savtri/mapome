function [ InputIndex ] = ReadConnectivityOfElements( text,InputIndex )
%% Find the Number of Elements
%Find the start index
startIdx = find(~cellfun('isempty',strfind(text,'$$ELEMENT')));

if ~isempty(startIdx)
    %Find the number of nodes of each finite element
    n = cellfun(@(x) textscan(x,'%f'),text(startIdx+1),'un',0);
    n = size(cell2mat([n{:}]).',2)-3;
    %Find the end index
    endIdx=InputIndex.Dollar2(find(InputIndex.Dollar2==startIdx)+1,1);
    %Re-Assign start/end index 
    startIdx=startIdx+1;
    endIdx=endIdx-1;
    %Find the Number of Elements
    InputIndex.NumberOfElements=endIdx-startIdx+1;

    %% Read the elements connectivity
    Elements=cellfun(@(x) textscan(x,'%f'),text(startIdx:endIdx),'un',0);
    Elements=cell2mat([Elements{:}]).';
    %Assign the Elements Type
    InputIndex.ElementsType=Elements(1,2);
    %Read the different kind of sections and material
    InputIndex.NumberOfDifferentSections=max(Elements(:,n+3));
    %Read the elements connectivity
    InputIndex.Elements=Elements(:,3:3+n);
else
    error('$$ELEMENT key must exist');
end

end

