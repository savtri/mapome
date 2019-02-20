function [ Fem,Mp,InputIndex ] = AssignFractureParameters(inc,iter,c,Fem,Mp,InputIndex)
%% Assign Fracture Parameters
for i=1:InputIndex.NumberOfElements %Loop for all elements
     mps=Fem.MPs{i,:}; %Material Points in that Finite Element
     InputIndex.NumberOfIntegPoints=size(mps,1);  %Number of material points in that Finite Element
     %Define Fracture Parameters
     %Find the local Phase Field
     [ clocal ] = PhaseFieldLocalFunctionFEM( i,Fem,c );
     for j=1:InputIndex.NumberOfIntegPoints %Loop for all integration points
         k=InputIndex.k(Mp.GroupType(mps(j,1),1)); %k parameter (Phase-Field) 
         N=Mp.N{mps(j,1),1};
         dRdx=Mp.dRdx{mps(j,1),1};
         %Define Phase-Field in gauss point
         Mp.c(1,mps(j,1))=N'*clocal;
         %Define derivate of Phase-Field in gauss point
         Mp.dc(1:2,mps(j,1))=dRdx*clocal;
         %Define Degratation Function
         Mp.g(1,mps(j,1))=(1-k)*(Mp.c(1,mps(j,1))^2)+k;
         %Material Point Group Type
         GroupType=Mp.GroupType(mps(j,1),1);
         lo=InputIndex.lo(GroupType,1);
         Gc=InputIndex.Gc(GroupType,1);
         [ Mp ] = Get_CrackSurfDensFunc( lo,Mp,mps(j,1),InputIndex );
         [ Mp ] = Get_DissipatedEnergy(Gc,Mp,mps(j,1));
     end
end
end