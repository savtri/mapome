function [ Kc,Mp,InputIndex ] = CalculatePhaseFieldTangMatrix( inc,iter,Kc,Fem,Mp,InputIndex )
%% Evaluate Global Phase Field matrix
tic %Start Time for Global Phase Field matrix
for i=1:InputIndex.NumberOfElements %Loop for all elements
    mps=Fem.MPs{i,:}; %Material Points in that Finite Element
    InputIndex.NumberOfIntegPoints=size(mps,1);  %Number of material points in that Finite Element
    kc=zeros(size(Fem.NodeIndex(i,:),2),size(Fem.NodeIndex(i,:),2)); %Define Phase Field matrix of element
    for j=1:InputIndex.NumberOfIntegPoints %Loop for all integration points
        lo=InputIndex.lo(Mp.GroupType(mps(j,1),1)); %length scale parameter (Phase-Field)
        Gc=InputIndex.Gc(Mp.GroupType(mps(j,1),1)); %critical energy rate (Phase-Field)  
        k=InputIndex.k(Mp.GroupType(mps(j,1),1)); %k parameter (Phase-Field)
        dVolume=Mp.vol(mps(j,1),1);
        %Define the Shape Function for Phase-Field
        N=Mp.N{mps(j,1),1}; 
        %Define the derivate matrix for Phase-Field
        Bc=Mp.dRdx{mps(j,1),1}; 
        A1=N*((4*lo*(1-k)*Mp.H(1,mps(j,1))/Gc)+1)*N';
        A2=Bc'*(4*(lo^2))*Bc;
        %Assign stiffness matrix due to Gauss point j
        kc=kc+(A1+A2)*dVolume;
    end
    %Add to Global Phase Feild matrix
    [ Kc ] = PhaseFieldMatrixFEM( i,Kc,kc,Fem,InputIndex );
end
X=sprintf('Global Phase Field matrix: ok'); %Assign
disp(X); %Display 
toc %End Time for Global Phase Field matrix
end