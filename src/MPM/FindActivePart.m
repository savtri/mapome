function [ InputIndex ] = FindActivePart( Fem,Mp,InputIndex )
%% Find Active Cells
ActiveCellsIndex(:,1)=find(~cellfun(@isempty,Fem.MPs)); %Find the Indices of Active Cells
ActiveCellsNumber=size(ActiveCellsIndex,1); %Assign the Number of Active Cells
ActiveCellsIndex(:,2)=colon(1,ActiveCellsNumber)'; %Assign the Indices of Active Cells in Local
%% Find the Active Nodes in Active Cells
ActiveNodesTot(:,1)=unique(Fem.NodeIndex(ActiveCellsIndex(:,1),:)); %Find the Indices of Active Nodes
ActiveNodesNumber=size(ActiveNodesTot,1); %Assign the Number of Active Nodes
ActiveNodesTot(:,2)=colon(1,ActiveNodesNumber)'; %Assign the Indices of Active Nodes in Local
%% Find the Active Degree of Freedom
ActiveDofTot(1:2:2*ActiveNodesNumber,1:2)=2*ActiveNodesTot(1:ActiveNodesNumber,1:2)-1; %Find the Indices of Active Degree of Freedom (x-direction)
ActiveDofTot(2:2:2*ActiveNodesNumber,1:2)=2*ActiveNodesTot(1:ActiveNodesNumber,1:2); %Find the Indices of Active Degree of Freedom (y-direction)
ActiveDofNumber=size(ActiveDofTot,1); %Assign the Number of Active Degree of Freedom

%% Assign Parameters
InputIndex.MpProps.ActiveCellsIndex=ActiveCellsIndex; %Assign Active Cells Index
InputIndex.MpProps.ActiveCellsNumber=ActiveCellsNumber; %Assign Active Cells Number
InputIndex.MpProps.ActiveNodesTot=ActiveNodesTot; %Assign Active Nodes Total
InputIndex.MpProps.ActiveNodesNumber=ActiveNodesNumber; %Assign Active Nodes Number
InputIndex.MpProps.ActiveDofTot=ActiveDofTot; %Assign the Active Degree of Freedom
InputIndex.MpProps.ActiveDofNumber=ActiveDofNumber; %Assign the Active Degree of Freedom Number
end

