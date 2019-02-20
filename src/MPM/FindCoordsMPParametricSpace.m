function [ Fem,Mp,InputIndex ] = FindCoordsMPParametricSpace( Fem,Mp,InputIndex )
%% Find the coords of Material Point in Parametric Space
for i=1:InputIndex.NumberOfElements %Loop for all Elements
    MPsX=Fem.MPs{i,:}; %Material Points in that Finite Element
    InputIndex.NumberOfIntegPoints=size(MPsX,1);  %Number of material points in that Finite Element
    %Assign x,y coords of element
    XYZ(1,:)=InputIndex.IndexXYNodes(Fem.NodeIndex(i,:),2); %x ccords
    XYZ(2,:)=InputIndex.IndexXYNodes(Fem.NodeIndex(i,:),3); %y coords
    %XYZ(3,i)=InputIndex.IndexXYNodes(Fem.NodeIndex(i,:),4); %z coords
    for j=1:InputIndex.NumberOfIntegPoints %Loop for all Integration Points
        xyzMp=Mp.coords(MPsX(j,1),:);
        if InputIndex.MpProps.CartesianGrid(1,1)==0 %case no cartesian grid (random grid)
            startX=[0 0];
            options = optimoptions('fsolve','Display','off');
            Mp.coordsPar(MPsX(j,1),:)=fsolve(@(x)ParametricCoords(x,xyzMp,XYZ,i,InputIndex),startX,options);
        elseif InputIndex.MpProps.CartesianGrid(1,1)==1 %case cartesian grid (random grid)
            %BoundaryConnectivity=convhull(XYZ(1,:),XYZ(2,:),'simplify',true);
            %BourdaryNodeCoords=XYZ(1:2,BoundaryConnectivity(1:size(BoundaryConnectivity,1)-1)); %element node coords
            BourdaryNodeCoords=XYZ;
            deltaX=InputIndex.MpProps.CartesianGrid(1,3); %Assign Cell Spacing x-direction
            deltaY=InputIndex.MpProps.CartesianGrid(1,4); %Assign Cell Spacing y-direction)
            xi=(2*xyzMp(1,1)-(BourdaryNodeCoords(1,1)+BourdaryNodeCoords(1,3)))/deltaX;
            eta=(2*xyzMp(1,2)-(BourdaryNodeCoords(2,1)+BourdaryNodeCoords(2,3)))/deltaY;
            Mp.coordsPar(MPsX(j,1),:)=[ xi,eta ];
        end
    end 
end
end

% if InputIndex.ParallelIndex(1,1)==0 %case no Parallel
%     for i=1:InputIndex.NumberOfElements %Loop for all Elements
%         MPsX=Fem.MPs{i,:}; %Material Points in that Finite Element
%         InputIndex.NumberOfIntegPoints=size(MPsX,1);  %Number of material points in that Finite Element
%         %Assign x,y coords of element
%         XYZ(1,:)=InputIndex.IndexXYNodes(Fem.NodeIndex(i,:),2); %x ccords
%         XYZ(2,:)=InputIndex.IndexXYNodes(Fem.NodeIndex(i,:),3); %y coords
%         %XYZ(3,i)=InputIndex.IndexXYNodes(Fem.NodeIndex(i,:),4); %z coords
%         for j=1:InputIndex.NumberOfIntegPoints %Loop for all Integration Points
%             startX=[0 0];
%             xyzMp=Mp.coords(MPsX(j,1),:);
%             options = optimoptions('fsolve','Display','off');
%             Mp.coordsPar(MPsX(j,1),:)=fsolve(@(x)ParametricCoords(x,xyzMp,XYZ,i,InputIndex),startX,options);
%         end 
%     end
% elseif InputIndex.ParallelIndex(1,1)==1 %case Parallel
%     nel=InputIndex.NumberOfElements; %Loop for all Elements
%     MPsX=struct([]); %Define Material Point Indices
%     MPsY=struct([]); %Define Material Point Indices
%     NumberOfIntegPoints=struct([]);
%     X=struct([]);
%     Y=struct([]);
%     coordsX=struct([]);
%     coordsY=struct([]);
%     for i=1:nel
%         MPsX{i,1}=Fem.MPs{i,:}; %Material Points in that Finite Element
%         MPsY{i,1}=Fem.MPs{i,:}; %Material Points in that Finite Element
%         NumberOfIntegPoints{i,1}=size(MPsX{i,1},1);  %Number of material points in that Finite Element
%         X{i,1}(1,:)=InputIndex.IndexXYNodes(Fem.NodeIndex(i,:),2); %x coords
%         Y{i,1}(1,:)=InputIndex.IndexXYNodes(Fem.NodeIndex(i,:),3); %y coords
%         for j=1:NumberOfIntegPoints{i,1}
%             coordsX{MPsX{i,1}(j,1),1}=Mp.coords(MPsX{i,1}(j,1),1);
%             coordsY{MPsX{i,1}(j,1),1}=Mp.coords(MPsX{i,1}(j,1),2);
%         end
%     end
%     options = optimoptions('fsolve','Display','off');
%     startX=[0 0];
%     parfor i=1:nel
%         for j=1:NumberOfIntegPoints{i,1}
%             %xyzMp=[coordsX{MPsX{i,1}(j,1),1},coordsY{MPsY{i,1}(j,1),1}];
%             %XYZ=[X{i,1};Y{i,1}];
%             %coordsPar{MPsX{i,1}(j,1),1}(1,:)=fsolve(@(x)ParametricCoords(x,xyzMp,XYZ,i,InputIndex),startX,options);
%             xMp=coordsX{MPsX{i,1}(j,1),1};
%             yMp=coordsY{MPsY{i,1}(j,1),1};
%             XFem=X{i,1};
%             YFem=Y{i,1};
%             coordsPar{i,1}{j,1}=fsolve(@(x)ParametricCoordsParallel( x,xMp,yMp,XFem,YFem ),startX,options);
%         end
%     end
%     ih=1;
%     for i=1:nel
%         nsize=size(coordsPar{i,1},1);
%         Mp.coordsPar(ih:ih+nsize-1,:)=cell2mat(coordsPar{i,1});
%         ih=ih+nsize;
%     end
% end

