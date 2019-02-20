function [ x_decop ] = RampFunction( x,index )
%% 2010 Miehe et al A phase field for rate-independent crack propagation: Robust algorithmic implementation.... (page 2768)
if index==1
    x_decop=(x+abs(x))/2;
elseif index==2
    x_decop=(x-abs(x))/2;
end
end