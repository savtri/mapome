function [ Fem,InputIndex ] = CreateActiveGridCells( Fem,InputIndex )
%% Create Active Cells (Fem)
%Store the previous Material Point Indices
MPs=struct([]); %Define Material Point Indices
for i=1:size(Fem.MPs,1) %Loop for all cells in the grid 
    MPs{i,1}=Fem.MPs{i,1}; %Assign Material Point Indices
end
%Find connectivity of active cells according to active nodes
elIndex=InputIndex.MpProps.ActiveCellsIndex(1:InputIndex.MpProps.ActiveCellsNumber,1);
A=Fem.NodeIndex(elIndex,:)';
B=InputIndex.MpProps.ActiveNodesTot(:,1);
InputIndex.Elements=arrayfun(@(x)(find(A(x)==B)),1:numel(A),'UniformOutput',true);
InputIndex.Elements=reshape(InputIndex.Elements,[size(Fem.NodeIndex,2),InputIndex.NumberOfElements])';
InputIndex.Elements(:,size(InputIndex.Elements,2)+1)=0;
%Create new Finite Elements (Cells)
[ Fem ] = CreateFiniteElements( InputIndex );
%Delete Elements
field = 'Elements';
InputIndex = rmfield(InputIndex,field);
%Assign the new Material Point Indices
for i=1:InputIndex.MpProps.ActiveCellsNumber
    iold=InputIndex.MpProps.ActiveCellsIndex(i,1); %Old Index
    inew=InputIndex.MpProps.ActiveCellsIndex(i,2); %New Index
    Fem.MPs{inew,1}=MPs{iold,1}; %New Material Point Indices
end
end

