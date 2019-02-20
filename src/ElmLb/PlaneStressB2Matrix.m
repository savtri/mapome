function [ B2 ] = PlaneStressB2Matrix( naturalDerivatives )
B2=zeros(4,2*size(naturalDerivatives,2));
for k=1:size(naturalDerivatives,2)
    B2(1,2*k-1)=naturalDerivatives(1,k);
    B2(2,2*k-1)=naturalDerivatives(2,k);
    B2(3,2*k)=naturalDerivatives(1,k);
    B2(4,2*k)=naturalDerivatives(2,k);
    k=k+1;
end
end

