clc;
clearvars;
close all;
%add folders to path
add2Path;

%% Read Input Address File
[ fid,textAddress ] = ReadInputAddressFile( );

%% Read Input Data File
[ Fem,Mp,InputIndex ] = ReadInputData( fid,textAddress );

%% Material Point Method Procedures
[ Fem,Mp,InputIndex ]=FiniteElementProcedures( Fem,Mp,InputIndex );