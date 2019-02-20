function [ InputIndex ] = ReadSolAlgoIndexes( text,InputIndex )
%% Read case of Solution Algorithm
[ InputIndex ] = ReadCaseOfSolAlg( text,InputIndex );

%% Read parameters of Solution Algorithm
[ InputIndex ] = ReadSolAlgParam( text,InputIndex );
end

