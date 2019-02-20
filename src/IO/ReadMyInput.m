function [ Fem,Mp,InputIndex ] = ReadMyInput( fid,fid2,textAddress,InputIndex )
tic %Start Time for Input Data File

%% Read the whole text
text = textscan(fid,'%s','Delimiter','');
text = text{1};
fid  = fclose(fid);

%% Find the '$' and '$$' symbols in text 
[ InputIndex ] = Find2Dollar( text,InputIndex );

%% Read the name of Job
[ InputIndex ] = ReadJobName( text,fid2,InputIndex );

%% Read Material Point Method Indexes
[ InputIndex ] = ReadMaterialPointMethodIndexes( text,textAddress,InputIndex );

%% Read Material Nonlinearity Indexes
[ InputIndex ] = ReadMaterialNonlinearityIndexes( text,InputIndex );

%% Read Crack Propagation Indexes
[ InputIndex ] = ReadCrackPropagationIndexes( text,InputIndex );

%% Read the Solution Algorithm
[ InputIndex ] = ReadSolAlgoIndexes( text,InputIndex );

%% Read Time Indexes
[ InputIndex ] = ReadTimeIndexes( text,InputIndex );

%% Read Sparse Matrix Index
[ InputIndex ] = ReadSparseMatrixIndex( text,InputIndex );

%% Read Jacobian-free Newton krylov method Index
[ InputIndex ] = ReadJacobianFreeNewtonKrylovMethodIndexes( text,InputIndex );

%% Read the coordinates of nodes
[ InputIndex ] = ReadCoordinatesOfNodes( text,InputIndex );

%% Read the connectivity of elements
[ InputIndex] = ReadConnectivityOfElements( text,InputIndex );

%% Read Materials
[ InputIndex ] = ReadMaterials( text,InputIndex );

%% Read Sections
[ InputIndex ] = ReadSection( text,InputIndex );

%% Imposition of kinematic constrains algorithm
[ InputIndex ] = ReadKinemConstrAlg( text,InputIndex );

%% Read Boundary Conditions
[ InputIndex ] = ReadBoundaryConditions( text,InputIndex );

%% Read Loads
[ InputIndex ] = ReadLoads( text,InputIndex );

%% Read Draw Indexes
[ InputIndex ] = ReadDrawIndexes( text,InputIndex );

%% Create Material Points
[ Mp,InputIndex ] = CreateMaterialPoints( InputIndex );

%% Create Finite Elements
[ Fem ] = CreateFiniteElements( InputIndex );

%% Find the Total Number Of Integration Points
[ InputIndex ] = FindTotumberIntegrPoints( Mp,InputIndex );

%% Delete unused variables
[ InputIndex ] = DeleteVariables1( InputIndex );

%% Assign Figure ID Number
[ InputIndex ] = AssignFigureID( InputIndex );

%% Draw Function
[ InputIndex ] = DrawFunction1 ( Fem,Mp,InputIndex );

%% Create Files for Drawing
FilesForDrawing( Fem,InputIndex );

X=sprintf('Read Input File: ok'); %Assign
disp(X); %Display
toc %End Time for Input Data File
end


