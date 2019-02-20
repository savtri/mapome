function [ u,lagrMulti,Cl,Cff,G,InputIndex ] = FindDisplacementsStaticDispControl( inc,iter,K,P,pres,V,UnKnownDis,KnownDis,u,lagrMulti,Fem,Mp,InputIndex )
%% Assign Displacement Control Parameters
IncIndex=InputIndex.SolAlg.Inc; %Assign the history index
LoadFact=InputIndex.SolAlg.LoadFact; %Total Load Factor
DLoadFact=InputIndex.SolAlg.DLoadFact; %Total Incremental Load Factor 
DDLoadFact=InputIndex.SolAlg.DDLoadFact; %Total Iterational Load Factor
Dupq=InputIndex.SolAlg.SolAlgParam(IncIndex,8); %Incremental Target Displacement of Node
%% Displacement Control Procedures
KV=transpose(V)*K*V; %rearrange global stiffness matrix
Kff=KV(1:UnKnownDis,1:UnKnownDis); %stiffness matrix assosiaced with unknown stiffness matrix
us=zeros(KnownDis,1); %external force matrix assosiaced with known stiffness matrix
PV=transpose(V)*P; %rearrange global external force matrix 
pf=PV(1:UnKnownDis,:); %external force matrix assosiaced with unknown stiffness matrix
%Imposition of kinematic constrains
[ Kff,pf,Cl,Cff,G ] = KinemConstrAlg( UnKnownDis,pf,Kff,V,Fem,Mp,InputIndex );
ufk=Kff\pf; %solve system
uk=transpose(V)\[ufk(1:UnKnownDis,1);us]; %Displacement Field in Incremenet
%Find Value of Controlled Node
[ ukq ] = FindValueControlledNode( uk,IncIndex,Fem,Mp,InputIndex );
if iter==1 %case first iteration
    DLoadFact=Dupq/ukq; %Total Incremental Load Factor
    LoadFact=LoadFact+DLoadFact; %Total Load Factor
    dpf=DLoadFact*pf; %Assign new incremental external force matrix with new incremental load factor
    duf=Kff\dpf; %Assign new incremental displacement field with new load factor
    u=transpose(V)\[duf(1:UnKnownDis,1);us];  
    uIter1=u; %Assign displacement field in first iteration
    %Assign Displacement Control Parameters
    InputIndex.SolAlg.LoadFact=LoadFact; %Total Load Factor
    InputIndex.SolAlg.DLoadFact=DLoadFact; %Total Incremental Load Factor
    InputIndex.SolAlg.uIter1=uIter1; %Displacement field in first iteration
    if InputIndex.ImposKinemConstAlgIndex(1,1)==1 %case Lagrange Multiplier Method
        lagrMulti(:,1)=duf(UnKnownDis+1:size(duf,1),1); %current Lagrange Multipliers in increment
        lagrMulti1=lagrMulti(:,1); %Assign Lagrange Multiplier vector at first iteration in each increment
        InputIndex.SolAlg.lagrMulti1=lagrMulti1;
    end
else %case other iterations
    PresV=transpose(V)*pres; %rearrange residual force matrix 
    presf=PresV(1:UnKnownDis,:); %residual force matrix assosiaced with unknown stiffness matrix
    if InputIndex.ImposKinemConstAlgIndex(1,1)==1 %case Lagrange Multiplier Method
        presf=[presf;G]; %Generalized residual force matrix (with kinematic constrains) 
    elseif InputIndex.ImposKinemConstAlgIndex(1,1)==2 %case Penalty Method
        a=InputIndex.ImposKinemConstAlgIndex(1,2); %Parameter of Penalty Method
        presf=presf+a*(Cff)*G; %Generalized residual force matrix (with kinematic constrains)
    end
    ufb=Kff\presf; %solve system
    ub=transpose(V)\[ufb(1:UnKnownDis,1);us]; %Displacement field assosiaced with residual force matrix
    %Find Value of Controlled Node
    [ ubq ] = FindValueControlledNode( ub,IncIndex,Fem,Mp,InputIndex );
    DLoadFact=DLoadFact-ubq/ukq; %Total Incremental Load Factor
    DDLoadFact=ubq/ukq; %Total Iterational Load Factor
    LoadFact=LoadFact-DDLoadFact; %Total Load Factor
    delta_uf=InputIndex.SolAlg.delta_uf; %Total Iterational Displacement Field
    uIter1=InputIndex.SolAlg.uIter1; %Displacement field in first iteration
    delta_uf=delta_uf+Kff\(presf-(ubq/ukq)*pf); %Total Iterational Displacement Field
    u=transpose(V)\[delta_uf(1:UnKnownDis,1);us]+uIter1; %Total Incremental Displacement Field
    %Assign Displacement Control Parameters
    InputIndex.SolAlg.LoadFact=LoadFact; %Assign Total Load Factor
    InputIndex.SolAlg.DLoadFact=DLoadFact; %Assign Total Incremental Load Factor
    InputIndex.SolAlg.DDLoadFact=DDLoadFact; %Assign Total Iterational Load Factor
    InputIndex.SolAlg.delta_uf=delta_uf; %Total Iterational Displacement Field
    if InputIndex.ImposKinemConstAlgIndex(1,1)==1 %case Lagrange Multiplier Method
        lagrMulti1=InputIndex.SolAlg.lagrMulti1; %Assign Lagrange Multiplier vector at first iteration in each increment
        lagrMulti(:,1)=delta_uf(UnKnownDis+1:size(delta_uf,1),1)+lagrMulti1(:,1); %current Lagrange Multipliers in increment
    end
end
end