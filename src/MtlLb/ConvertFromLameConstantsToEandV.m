function [ E,v ]=ConvertFromLameConstantsToEandV( Lambda,mu )
%% Convert Lame Constants to Young's Modulus E and Poisson Ratio v
E=mu*(3*Lambda+2*mu)/(Lambda+mu);
v=Lambda/(2*(Lambda+mu));
end