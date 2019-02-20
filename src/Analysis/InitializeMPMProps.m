function [ Fem,Mp,InputIndex ] = InitializeMPMProps( Fem,Mp,InputIndex )
%% Initialize Properties (only for Material Point Method)
if InputIndex.AnalIndex.MPMIndex(1,1)==1 %case Material Point Method
    tic %Start Time for Initialize Material Point Method Properties
    %Store/Load Initial Grid
    [ Fem,InputIndex ] = StoreLoadInitialGrid( Fem,InputIndex );
    %Find where material points are in finite elements
    [ Fem,Mp,InputIndex ] = FindWhereMPsAreInCells( Fem,Mp,InputIndex );    
    %Find the Active Part
    [ InputIndex ] = FindActivePart( Fem,Mp,InputIndex );
    %Rearrange Contrains/Loads
    [ InputIndex ] = RearrangeConstrainsLoads( InputIndex );
    %Define the new Number of Nodes
    InputIndex.NumberOfNodes=InputIndex.MpProps.ActiveNodesNumber;
    %Define the new Number of Degree of Freedom
    InputIndex.DegreeOfFreedom=InputIndex.MpProps.ActiveDofNumber;
    %Define the new Number of Finite Elements (Cells)
    InputIndex.NumberOfElements=InputIndex.MpProps.ActiveCellsNumber;
    %Create Active Cells
    [ Fem,InputIndex ] = CreateActiveGridCells( Fem,InputIndex );
    %Define the new coords of Finite Elements according to active nodes
    [ InputIndex ] = RearrangeActiveGridCellsCoords( InputIndex );
    %Find the coords of Material Point in Parametric Space
    [ Fem,Mp,InputIndex ] = FindCoordsMPParametricSpace( Fem,Mp,InputIndex );
    X=sprintf('Material Point Method Properties: ok'); %Assign
    disp(X); %Display
    toc %End Time for Initialize Material Point Method Properties
end
end

