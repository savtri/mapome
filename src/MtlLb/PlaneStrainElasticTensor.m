function [ De ] = PlaneStrainElasticTensor( E,v )
De=zeros(3,3);
Coef=E/((1+v)*(1-2*v));
De(1,1)=Coef*(1-v);
De(1,2)=Coef*v;
De(1,3)=0;
De(2,1)=Coef*v;
De(2,2)=Coef*(1-v);
De(2,3)=0;
De(3,1)=0;
De(3,2)=0;
De(3,3)=Coef*((1-2*v)/2);
end

