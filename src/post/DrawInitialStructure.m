function DrawInitialStructure(  Fem,InputIndex,fid,figureID )
%% Visible Index
if InputIndex.DrawIndex.DrawInitialStructureIndex(1,1)==0 %case no Visible
    figure('Visible','off')
else %case Visible
    figure(figureID);
end
%% Draw Initial Structure
hold on
for i=1:InputIndex.NumberOfElements %Loop over elements
    NodeIndex=Fem.NodeIndex(i,:); %Define element connectivity
    XYZ=zeros(2,size(NodeIndex,2)); %Define element coords
    %Assign element coords
    for j=1:size(NodeIndex,2)
        XYZ(1,j)=InputIndex.IndexXYNodes(NodeIndex(1,j),2);
        XYZ(2,j)=InputIndex.IndexXYNodes(NodeIndex(1,j),3);
    end
    %Find element centroid
    [ geom, iner, cpmo ] = polygeom(XYZ(1,:),XYZ(2,:));
    InputIndex.xCentroid(i,1)=geom(2); %Assign x centroid
    InputIndex.yCentroid(i,1)=geom(3); %Assign y centroid  
    %Draw Lines
    for j=1:size(NodeIndex,2)-1 
        line([XYZ(1,j);XYZ(1,j+1)],[XYZ(2,j);XYZ(2,j+1)],'Color','k','LineWidth',2);
    end
    %Draw close Line
    line([XYZ(1,j+1);XYZ(1,1)],[XYZ(2,j+1);XYZ(2,1)],'Color','k','LineWidth',2);
    %Draw Node Point Index
    for j=1:size(NodeIndex,2)
        labels = cellstr( num2str([NodeIndex(1,j)]') );
        plot(XYZ(1,j),XYZ(2,j), '.b','MarkerSize', 20)
        text(XYZ(1,j),XYZ(2,j), labels, 'VerticalAlignment','bottom',  'HorizontalAlignment','right')
    end
    %Draw Centroid Point Index
    labels = cellstr( num2str([i]') );
    plot(InputIndex.xCentroid(i,1), InputIndex.yCentroid(i,1), 'rx')
    text(InputIndex.xCentroid(i,1), InputIndex.yCentroid(i,1), labels, 'VerticalAlignment','bottom',  'HorizontalAlignment','right');
end
axis equal
grid on
box on
%% Save Index
if InputIndex.DrawIndex.DrawInitialStructureIndex(1,2)==1 %case Save
    saveas(gcf,fid,'png')
end
end

