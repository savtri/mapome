function [ Dmatx ] = ComputeElastoplasticConsistentTangent( j,i,iid,De,E,v,NumberOfHardeningPoints,HardeningPoints,Fem,Mp,InputIndex )
%% Compute the Elastoplastic Consistent Tangent Matrix
ElementsType=InputIndex.ElementsType; %Define the elements type
if ElementsType==8 || ElementsType==10 %case Plain Strain
    [ Dmatx ] = ComElasplasConsTangRetMapPlStrAxisProc ( j,i,iid,Fem,Mp,De,E,v,NumberOfHardeningPoints,HardeningPoints );
elseif ElementsType==9 || ElementsType==11 %case Plane Stress
    [ Dmatx ] = ComElasplasConsTangRetMapStrProjProc( j,i,iid,Fem,Mp,De,E,v,NumberOfHardeningPoints,HardeningPoints );
else %case Error in Elasto-Plastic Tensor
    disp('Error in Elasto-Plastic Tensor');
end
end

