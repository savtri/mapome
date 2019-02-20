function [ Dmatx,InputIndex ] = ComputeDamageElasticConsistentTangent( inc,j,i,iid,l,mu,E,v,kPF,Fem,Mp,InputIndex )
%% Compute Damage Elastic Tangent
if InputIndex.ElementsType==8 || InputIndex.ElementsType==10 %case Plane Strain
    [ Dmatx ] = DamagePlaneStrain( j,i,iid,l,mu,E,v,kPF,Mp,InputIndex );
elseif InputIndex.ElementsType==9 || InputIndex.ElementsType==11 %case Plane Stress
    [ Dmatx ] = DamagePlaneStress( j,i,iid,l,mu,E,v,kPF,Mp,InputIndex );
end 
end