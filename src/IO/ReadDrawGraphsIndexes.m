function [ InputIndex ] = ReadDrawGraphsIndexes( text,InputIndex )
%% Find the total number of Graphs
%Find the start index
startIdx = find(~cellfun('isempty',strfind(text,'$DRAW_GRAPHS')))+1;

if ~isempty(startIdx)
    %Find the end index
    endIdx=InputIndex.Dollar(find(InputIndex.Dollar==startIdx)+1,1);
    %Re-Assign start/end index 
    startIdx=startIdx+1;
    endIdx=endIdx-1;
    %Find the total number of Graphs
    InputIndex.NumberOfDrawGraphs=endIdx-startIdx+1;

    %% Read the graphs paramters
    for i=1:InputIndex.NumberOfDrawGraphs
        idx = find(~cellfun('isempty',strfind(text,'$DRAW_GRAPHS'))) + i+1; %Find the Line of Keyword
        LWm = cellfun(@(x) textscan(x,'%c'),text(idx),'un',0); %Read the line
        LWm = cell2mat([LWm{:}]).'; %Assign the text of this line
        FindSlash=find(LWm=='/'); %Find / in text
        FindLine=find(LWm=='-'); %Find - in text
        nText=size(LWm,2); %Find the size of text
        idGraph=str2double(LWm(1:FindSlash(1,1)-3)); %Id of Graph
        VisibleIndex=str2double(LWm(FindSlash(1,1)-2)); %Visible Index
        SaveIndex=str2double(LWm(FindSlash(1,1)-1)); %Save Index
        VarX=LWm(FindSlash(1,3)+2:FindSlash(1,4)-1); %Variable x direction
        VarY=LWm(FindSlash(1,4)+1:nText); %Variable y direction 
        Inc=str2double(LWm(FindSlash(1,1)+1:FindSlash(1,2)-1)); %Increment Index
        Form=LWm(FindSlash(1,2)+1:FindSlash(1,3)-1); %Format of drawing
        %Assign Graphs Parameters
        InputIndex.DrawIndex.DrawGraphs{i,:}={idGraph,VisibleIndex,SaveIndex,Inc,Form,VarX,VarY};
    end
end

end

