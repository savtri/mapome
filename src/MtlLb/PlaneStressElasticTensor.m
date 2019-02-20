function [ De ] = PlaneStressElasticTensor( E,v )
De=zeros(3,3);
De(1,1)=E/(1-v^2);
De(1,2)=v*E/(1-v^2);
De(1,3)=0;
De(2,1)=De(1,2);
De(2,2)=De(1,1);
De(2,3)=0;
De(3,1)=0;
De(3,2)=0;
De(3,3)=E/(2*(1+v));
end

