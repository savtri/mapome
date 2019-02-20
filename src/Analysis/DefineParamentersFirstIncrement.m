function [ pext,pint,Fc,pres,Ratold,Remold,Fem,Mp,InputIndex ] = DefineParamentersFirstIncrement( inc,P,UnKnownDis,Fem,Mp,InputIndex )
%% Define parameters
nInP=InputIndex.NumberTotOfIntegPoints; %Assign Total Number Of Integration Points
dof=InputIndex.DegreeOfFreedom; %Assign total number of degree of Freedom
%% Define displacement, strain (eogp), stresses, plastic multiplier (dg), plastic strains(Z)
Mp.u=zeros(nInP,2); %Assign displacement in GPs
Mp.eo=zeros(5,nInP); %Assign strains in the beginning of each increment in GPs
Mp.e=zeros(5,nInP); %Assign strains (current) in GPs
Mp.so=zeros(4,nInP); %Assign stresses in the beginning of each increment in GPs
Mp.s=zeros(4,nInP); %Assign stresses in GPs
Mp.dg=zeros(1,nInP); %Assign Plastic Multiplier in GPs
Mp.Z=zeros(3,nInP); %Assign Plastic Strains in GPs
Mp.epnEquil=zeros(nInP,1); %Assign Equivalent Plastic Strain in GPs
Mp.smax=zeros(1,nInP); %Assign max principal stresses in GPs
Mp.smin=zeros(1,nInP); %Assign min proncipal stresses in GPs
Mp.seff=zeros(1,nInP); %Assign effective stress in GPs
%% Define Phase Field Parameters
if InputIndex.AnalIndex.CrackPropagationIndex(1,1)==1 %case Crack Propagation
    Mp.c=ones(1,nInP); %Assign Phase-Field (current) in GPs
    Mp.dc=zeros(2,nInP); %Assign first derivate of Phase-Field in GPs
    Mp.CrackSurfDensFunc=zeros(1,nInP); %Assign Functional in GPs
    Mp.psi=zeros(1,nInP); %Assign free energy density in GPs
    Mp.psi_plus=zeros(1,nInP); %Assign free energy density plus in GPs
    Mp.H=zeros(1,nInP); %Assign History Field (current) in GPs
    Mp.Hmax=zeros(1,nInP); %Assign max History Field (current) in GPs
    Mp.f=zeros(1,nInP); %Assign energetic force in GPs
    Mp.Ec=zeros(1,nInP); %Assign dissipated energy in GPs
end
%% Define convergence parameters 
Ratold=0;
Remold=0;
%% Define Field Parameters
%Define the incremental Internal Forces Matrix
pint=zeros(dof,1);
%Define the incremental External Force Matrix (with load factor)
pext=P*InputIndex.SolAlg.SolAlgParam(1,1);
%Define the Residual Force Matrix (with load factor)
pres=pext;

%% Define Phase field Forcing term
if InputIndex.AnalIndex.CrackPropagationIndex(1,1)==0 %case no Crack Propagation
    %Define the Phase Field Residual Matrix
    Fc=[];
elseif InputIndex.AnalIndex.CrackPropagationIndex(1,1)==1 %case Crack Propagation
    %Define the Phase Field Residual Matrix
    [ Fc ] = PhaseFieldForceMatrix( Fem,Mp,InputIndex );
end

%% Define Load Factor Paramters
if InputIndex.SolAlg.SolAlgIndex==1 %case Load Control
    InputIndex.SolAlg.Inc=1; %Define increment (only in history case)
    InputIndex.SolAlg.LoadFact=InputIndex.SolAlg.SolAlgParam(1,1); %Total Load Factor 
    InputIndex.SolAlg.DLoadFact=InputIndex.SolAlg.SolAlgParam(1,1); %Total Incremental of Load Factor
elseif InputIndex.SolAlg.SolAlgIndex==2 %case Displacement Control
    InputIndex.SolAlg.Inc=1; %Define increment (only in history case)
    InputIndex.SolAlg.LoadFact=0; %Total Load Factor 
    InputIndex.SolAlg.DLoadFact=0; %Total Incremental of Load Factor
    InputIndex.SolAlg.DDLoadFact=0; %Total Iterational of Load Factor
    InputIndex.SolAlg.uIter1=zeros(dof,1); %Total incremental Displacement field at first iteration in each increment
    NodeIndex=InputIndex.SolAlg.SolAlgParam(InputIndex.SolAlg.Inc,6); %Assign the Node Index
    dofGlob=InputIndex.SolAlg.SolAlgParam(InputIndex.SolAlg.Inc,7); %Assign the Degree of Freedom of Node
    [ dofGlob ] = FindDegreeOfFreedomGlobal( NodeIndex,dofGlob,dof,dof ); %Find global degree of freedom
    InputIndex.SolAlg.SolAlgParam(InputIndex.SolAlg.Inc,9)=dofGlob; %Assign the Degree of Freedom of Node
    if InputIndex.ImposKinemConstAlgIndex(1,1)==1 %case Lagrange Multiplier Method
        InputIndex.SolAlg.delta_uf=zeros(UnKnownDis+nkc,1); %Delta displacement field in each iteration
        InputIndex.SolAlg.lagrMulti1=zeros(nkc,1); %Define Lagrange Multiplier vector at first iteration in each increment
    elseif InputIndex.ImposKinemConstAlgIndex(1,1)==2 %case Penalty Method
        InputIndex.SolAlg.delta_uf=zeros(UnKnownDis,1); %Delta displacement field in each iteration
    end
end
end

