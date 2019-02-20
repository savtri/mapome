function [ Fem,Mp,InputIndex ] = FindWhereMPsAreInCells( Fem,Mp,InputIndex )
%% Find where material points are in finite elements (only in Material Point Method)
if  InputIndex.MpProps.CartesianGrid(1,1)==0 %case no cartesian grid (random grid)
    for i=1:InputIndex.NumberOfElements %Loop for all Finite Elements
        %Assign x,y coords of element
        XYZ(:,1)=InputIndex.IndexXYNodes(Fem.NodeIndex(i,:),2); %x ccords
        XYZ(:,2)=InputIndex.IndexXYNodes(Fem.NodeIndex(i,:),3); %y coords
        %XYZ(:,3)=InputIndex.IndexXYNodes(Fem.NodeIndex(i,:),4); %z coords
        in = inpoly(Mp.coords,XYZ); %Find if Material Point are inside or not
        MPs=find(in==1); %Material Point Indices that are inside Finite Element i
        Fem.MPs{i,1}=MPs; %Assign Material Point Indices
    end
elseif InputIndex.MpProps.CartesianGrid(1,1)==1 %case cartesian grid
    nCellsX=InputIndex.MpProps.CartesianGrid(1,2); %Assign the number of Cells x-direction
    deltaX=InputIndex.MpProps.CartesianGrid(1,3); %Assign Cell Spacing x-direction
    deltaY=InputIndex.MpProps.CartesianGrid(1,4); %Assign Cell Spacing y-direction
    xmin=InputIndex.MpProps.CartesianGrid(1,5); %Mininum x-direction
    ymin=InputIndex.MpProps.CartesianGrid(1,6); %Mininum y-direction
    for p=1:InputIndex.NumberTotOfIntegPoints
        e=floor((Mp.coords(p,1)-xmin)/deltaX)+1+nCellsX*floor((Mp.coords(p,2)-ymin)/deltaY);
        pElems(p)=e;
    end
    for i=1:InputIndex.NumberOfElements %Loop for all finite elements
        id=find(pElems==i); %Material Point Indices that are inside Finite Element i
        Fem.MPs{i,1}=id'; %Assign Material Point Indices
    end
end
end

