function StoreGraphsData( inc,t,u,U,pext,Pext,Fem,Mp,InputIndex )
%% Store data in Output files (Graphs)
for i=1:InputIndex.NumberOfDrawGraphs %Loop for all Graphs
    idGraph=num2str(cell2mat(InputIndex.DrawIndex.DrawGraphs{i,1}(1,1))); %id of graph
    Inc=cell2mat(InputIndex.DrawIndex.DrawGraphs{i,1}(1,4)); %Increment Index
    xDir=InputIndex.DrawIndex.DrawGraphs{i,1}(1,6); %variable x direction
    yDir=InputIndex.DrawIndex.DrawGraphs{i,1}(1,7); %variable x direction
    if mod(inc,Inc)==0 || inc==1 %case store data every Inc timesteps (always store first increment)
        FileName=strcat(idGraph,'_idGraph'); %Name of File
        namePath=[InputIndex.JobIndex filesep 'Draw' filesep strcat(FileName,'.out')]; %Path Name
        xValue=eval(xDir{1}); %vectorize x Direction variable
        yValue=eval(yDir{1}); %vectorize y Direction variable
        fidGraph  = fopen(namePath,'a+'); %Create and Open file
        fprintf(fidGraph,'%15.10f\t %15.10f\n',xValue,yValue ); %Store in output file
        fidGraph  = fclose(fidGraph); %Close file
    end
end
end

