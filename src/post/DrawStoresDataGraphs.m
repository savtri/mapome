function [ InputIndex ] = DrawStoresDataGraphs(inc,InputIndex)
%% Draw stored data (Graphs)
inc=inc-1; %Reduce by one the increment due to last increment
for i=1:InputIndex.NumberOfDrawGraphs %Loop for all Graphs
    idGraph=num2str(cell2mat(InputIndex.DrawIndex.DrawGraphs{i,1}(1,1))); %id of graph
    VisibleIndex=cell2mat(InputIndex.DrawIndex.DrawGraphs{i,1}(1,1)); %Visible Index
    SaveIndex=cell2mat(InputIndex.DrawIndex.DrawGraphs{i,1}(1,1)); %Save Index
    Form=num2str(cell2mat(InputIndex.DrawIndex.DrawGraphs{i,1}(1,5))); %Format Index
    FileName=strcat(idGraph,'_idGraph'); %Name of File
    namePath=[InputIndex.JobIndex filesep 'Draw' filesep strcat(FileName,'.out')]; %Path Name
    namePathDraw=[InputIndex.JobIndex filesep 'Draw' filesep FileName]; %Path Name for save drawing
    fidGraph  = fopen(namePath,'r'); %Open and read file
    text = textscan(fidGraph,'%s','Delimiter',''); %Read the whole text
    text = text{1}; %Assign text 
    fidGraph  = fclose(fidGraph); %Close file
    xyValues = cellfun(@(x) textscan(x,'%f'),text(1:inc),'un',0); %Assign text in variables
    xyValues = cell2mat([xyValues{:}]).'; %Convert variable to double matrix
    if VisibleIndex==0 %case no Visible
        figure('Name',FileName,'Visible','off')
    else %case Visible
        figure('Name',FileName);
    end
    plot(xyValues(:,1),xyValues(:,2),'-ro'); %Plot drawing 
    %title(FileName); %Assign title
    grid on %Grid on 
    box on  %Box on 
    if SaveIndex==1 %case Save
        saveas(gcf,namePathDraw,Form) %Save drawing 
    end
end
end

