function [ Fem,Mp,InputIndex ] = ReadInputData( fid,textAddress )
%% Open the Input Data file
fid2=fid;
fid  = fopen(fid2,'r');
%% Read Input
[ InputIndex ] = MakeJobFile( fid );
fid  = fopen(fid2,'r'); %case MyInput
[ Fem,Mp,InputIndex ] = ReadMyInput( fid,fid2,textAddress,InputIndex );
InputIndex.InputAdressIndex=fid2;
end

