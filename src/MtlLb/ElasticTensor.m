function [ De ] = ElasticTensor( E,v,InputIndex )
ElementsType=InputIndex.ElementsType; %Assign Element Type
if ElementsType==8 || ElementsType==10 %case Plain Strain
    [ De ] = PlaneStrainElasticTensor( E,v );
elseif ElementsType==9 || ElementsType==11 %case Plane Stress
    [ De ] = PlaneStressElasticTensor( E,v);
else %case no correct element type
    disp('Error in Elastic Tensor')
end
end

