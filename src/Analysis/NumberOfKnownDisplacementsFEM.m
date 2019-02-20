function [ KnownDis ] = NumberOfKnownDisplacementsFEM( Constrains,DegreeOfFreedom )
KnownDis=0;
for i=1:DegreeOfFreedom
    if (Constrains(i)==0)
        KnownDis=KnownDis+1;
    end
end
end

