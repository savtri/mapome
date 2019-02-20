function [ H ] = HardeningInterpolationFunction( ep,NumberOfHardeningPoints,HardeningPoints )
for i=1:NumberOfHardeningPoints
    if ep>=HardeningPoints(1,i)
        
    else
        if i==1
            H=0;
            break;
        else
            H=(HardeningPoints(2,i)-HardeningPoints(2,i-1))/(HardeningPoints(1,i)-HardeningPoints(1,i-1));
            break;
        end
    end
end
end

