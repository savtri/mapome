function [ checkMaxIter ]=CheckForMaxIterations( h,maxIter )
if h==maxIter
    X=sprintf('Algorithm in Plasticity can not Converge for this specific plastic tolerance: Change Plastic Tolerance');
    disp(X);
    checkMaxIter=1;
    stop
else
    checkMaxIter=0;
end
end

