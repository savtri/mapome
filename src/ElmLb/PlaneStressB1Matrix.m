function [ B1 ] = PlaneStressB1Matrix( Jacob )
B1=zeros(3,4);
detJacob=det(Jacob);
B1(1,1)=Jacob(2,2)/detJacob;
B1(1,2)=-Jacob(1,2)/detJacob;
B1(2,3)=-Jacob(2,1)/detJacob;
B1(2,4)=Jacob(1,1)/detJacob;
B1(3,1)=-Jacob(2,1)/detJacob;
B1(3,2)=Jacob(1,1)/detJacob;
B1(3,3)=Jacob(2,2)/detJacob;
B1(3,4)=-Jacob(1,2)/detJacob;
end

