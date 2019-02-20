function [ InputIndex ] = ReadMaterials( text,InputIndex )
%% Read the elastic properties of the element
[ InputIndex ] = ReadElasticProperties( text,InputIndex );

%% Read the plastic properties of the element
[ InputIndex ] = ReadPlasticProperties( text,InputIndex );

%% Read Fracture Parameters
[ InputIndex ] = ReadFractureProperties( text,InputIndex );

%% Read Mass Density
[ InputIndex ] = ReadMassDensity( text,InputIndex );
end

