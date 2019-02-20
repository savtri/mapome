function FilesForDrawingGraphs( Fem,InputIndex )
%% Files for Drawing Graphs
for i=1:InputIndex.NumberOfDrawGraphs %Loop for all Graphs
    idGraph=num2str(cell2mat(InputIndex.DrawIndex.DrawGraphs{i,1}(1,1))); %id of graph
    FileName=strcat(idGraph,'_idGraph'); %Name of File
    namePath=[InputIndex.JobIndex filesep 'Draw' filesep strcat(FileName,'.out')]; %Path Name
    fidGraph  = fopen(namePath,'w'); %Create and Open file
    fidGraph  = fclose(fidGraph); %Close file
end
end

