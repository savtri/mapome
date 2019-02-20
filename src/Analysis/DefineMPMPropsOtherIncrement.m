function  [ u,U,c,C,pres,pext,Pext,KnownDis,UnKnownDis,V,Fem,Mp,InputIndex ] = DefineMPMPropsOtherIncrement( Fem,Mp,InputIndex )
%% Redefine Material Point Properties in each increment (only for Material Point Method)
%Initialize Material Point Properties (only for Material Point Method)
[ Fem,Mp,InputIndex ] = InitializeMPMProps( Fem,Mp,InputIndex );
%Define Displacement Matrix
u=zeros(InputIndex.DegreeOfFreedom,1);
%Total Displacement Matrix
U=zeros(InputIndex.DegreeOfFreedom,1);
%Define Phase Field Matrix
if InputIndex.AnalIndex.CrackPropagationIndex(1,1)==0 %case no Crack Propagation
    c=[]; %Define incremental Phase-Field
    C=[]; %Define total Phase-Field
elseif InputIndex.AnalIndex.CrackPropagationIndex(1,1)==1 %case Crack Propagation
    c=ones(InputIndex.NumberOfNodes,1); %Define incremental Phase-Field
    C=ones(InputIndex.NumberOfNodes,1); %Define total Phase-Field
end
%Define Residual Forces
pres=zeros(InputIndex.DegreeOfFreedom,1);
%Define incremental External Forces
pext=zeros(InputIndex.DegreeOfFreedom,1);
%Define total External Forces
Pext=zeros(InputIndex.DegreeOfFreedom,1);
%Constrains Matrix
[ Constrains ] = ConstrainsMatrix( Fem,Mp,InputIndex );
%Known Displacements
[ KnownDis ] = NumberOfKnownDisplacementsFEM( Constrains,InputIndex.DegreeOfFreedom );
%Unknown Displacements
UnKnownDis=InputIndex.DegreeOfFreedom-KnownDis;
%Rearrange Matrix
[ V ] = VRearrangeFunction( Constrains,InputIndex.DegreeOfFreedom,KnownDis );
end

