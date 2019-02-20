function [ InputIndex ] = ReadBoundaryConditions( text,InputIndex )
%% Individual constrains
[ InputIndex ] = ReadIndividualConstrains( text,InputIndex );

%% Kinematic constrains
[ InputIndex ] = ReadKinematicConstrains( text,InputIndex );
end

