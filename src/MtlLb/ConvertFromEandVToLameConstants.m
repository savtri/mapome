function [ Lambda,mu ]=ConvertFromEandVToLameConstants( E,v )
%% Convert Young's Modulus E and Poisson Ratio v to Lame Constants
Lambda=v*E/((1+v)*(1-2*v));
mu=E/(2*(1+v));
end