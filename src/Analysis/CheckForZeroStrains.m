function [ e11,e22,e12 ] = CheckForZeroStrains( e11,e22,e12 )
%% Check for zero strains for replace with 0.1e-14 because there is not derivate of Abs in zero
if e11==0
    e11=0.1e-14;
end
if e22==0
    e22=0.1e-14;
end
if e12==0
    e12=0.1e-14;
end
end

