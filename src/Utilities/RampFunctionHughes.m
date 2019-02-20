function [ x_decop ] = RampFunctionHughes( x )
%% 2012 Borden et al A phase ield decription of dynamic brittle fracture (page 79)
if x>0
    x_decop=x;
else
    x_decop=0;
end
end