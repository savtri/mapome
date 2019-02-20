function [ sy ] = SyInterpolationFunction( ep,NumberOfHardeningPoints,HardeningPoints )
for i=1:NumberOfHardeningPoints
    if ep>=HardeningPoints(1,i)

    else
        if i==1
            sy=HardeningPoints(1,1);
            break;
        else
            c1=HardeningPoints(2,i-1);
            c2=HardeningPoints(1,i-1);
            c3=HardeningPoints(2,i)-HardeningPoints(2,i-1);
            c4=HardeningPoints(1,i)-HardeningPoints(1,i-1);
            sy=c1+(ep-c2)*c3/c4;
            break;
        end
    end
end
end

