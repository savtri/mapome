function AnimationFunction( SFId,xp,yp,AnimationField,titleName,Fem,InputIndex )
%% AnimationFunction
subplot(2,1,SFId);
hold on;
grey=[0.4,0.4,0.4];
for k=1:InputIndex.NumberOfElements
    NodeIndex=Fem.NodeIndex(k,:); %Define element connectivity
    XYZ=zeros(2,size(NodeIndex,2)); %Define element coords
    %Assign element coords
    for j=1:size(NodeIndex,2)
        XYZ(1,j)=InputIndex.IndexXYNodes(NodeIndex(1,j),2);
        XYZ(2,j)=InputIndex.IndexXYNodes(NodeIndex(1,j),3);
    end
    %Draw Lines
    for j=1:size(NodeIndex,2)-1 
        line([XYZ(1,j);XYZ(1,j+1)],[XYZ(2,j);XYZ(2,j+1)],'Color',grey,'LineWidth',1);
    end
    %Draw close Line
    line([XYZ(1,j+1);XYZ(1,1)],[XYZ(2,j+1);XYZ(2,1)],'Color',grey,'LineWidth',1);
end
subplot(2,1,SFId);
title(titleName);
scatter(xp(:,1),yp(:,1),30,AnimationField(:,1),'filled');
colorbar;
cmap=colorbar; %Assign colorbar
%cmap.Limits=[0 2550]; %Assign colorbar limits
cmap.FontSize=15; %Assign colorbar font size
cmap.FontName='Garamond'; %Assign font name
colormap(flipud(jet))
%colormap(jet) %Assign contour type
axis equal
grid on
box on
end

