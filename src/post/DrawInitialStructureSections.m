function DrawInitialStructureSections( Fem,Mp,InputIndex,fid,figureID )
%% Visible Index
if InputIndex.DrawIndex.DrawInitialStructureIndex(1,1)==0 %case no Visible
    figure('Visible','off')
else %case Visible
    figure(figureID);
end
%Number of Different Section of Structure
NumberOfDSections=InputIndex.NumberOfDifferentSections;
%Assign the colors for each section
cmap = hsv(NumberOfDSections);
hold on
%% Draw Initial Sections of Structure
for i=1:InputIndex.NumberOfElements %Loop over elements
    NodeIndex=Fem.NodeIndex(i,:); %Define element connectivity
    XYZ=zeros(2,size(NodeIndex,2)); %Define element coords
    %Assign element coords
    for j=1:size(NodeIndex,2)
        XYZ(1,j)=InputIndex.IndexXYNodes(NodeIndex(1,j),2);
        XYZ(2,j)=InputIndex.IndexXYNodes(NodeIndex(1,j),3);
    end
    %Draw Lines
    for j=1:size(NodeIndex,2)-1 
        line([XYZ(1,j);XYZ(1,j+1)],[XYZ(2,j);XYZ(2,j+1)],'Color','k','LineWidth',2);
    end
    %Draw close Line
    line([XYZ(1,j+1);XYZ(1,1)],[XYZ(2,j+1);XYZ(2,1)],'Color','k','LineWidth',2);
    %Draw patches
    p=patch(XYZ(1,:),XYZ(2,:),[cmap(Fem.GroupType(i,1),:)]);
end
axis equal
grid on
box on
%% Save Index
if InputIndex.DrawIndex.DrawInitialStructureIndex(1,4)==1 %case Save
    saveas(gcf,fid,'png')
end
end

