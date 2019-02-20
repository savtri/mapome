function [ pres,pext,convrg,diverg,Ratold,Remold,Ratio ] = CheckForConverageStatic( inc,iter,tolerance,P,V,UnKnownDis,KnownDis,Ratold,Remold,pext,pint,lagrMulti,u,Cl,Cff,G,InputIndex )
%% Check Ratio
%% Assign Parameters
diverg=0; %Define divergence equal to false
convrg=0; %Define congergence equal to false
nkc=InputIndex.Constrains.NumberOfKinemConst; %Define Number of Kinematic Constrains
%% Correct External Forces with new load factor
DLoadFact=InputIndex.SolAlg.DLoadFact; %Total Current Increment Load Factor 
pext=DLoadFact*P; %Incremental External Forces with load factor
%% Check for congergence
if nkc==0 %case no kinematic constrains
    pres=pext-pint; %Assign Residual of forces
else %case at least one kinematic constrains
    if InputIndex.ImposKinemConstAlgIndex(1,1)==1 %case Lagrange Multiplier Method
        pres=[pext;G]-[pint;Cl*u]-[(Cl')*lagrMulti;zeros(nkc,1)]; %Assign Residual of forces
        pres=pres(1:InputIndex.DegreeOfFreedom,1); %Continue without Degree of freedom due to lagrange multipliers
    elseif InputIndex.ImposKinemConstAlgIndex(1,1)==2 %case Penalty Method
        a=InputIndex.ImposKinemConstAlgIndex(1,2); %Parameter of Penalty Method
        pres=(pext+a*(Cl')*G)-(pint+a*(Cl')*Cl*u); %Assign Residual of forces   
    end
end
PVres=transpose(V)*pres; %rearrange global external force matrix 
Ratio_Dis=sqrt(sum(PVres(1:UnKnownDis).^2,1)); %Evaluate Ratio (norm of residual forces)
Ratio=Ratio_Dis; %Assign the Ratio as the Ratio of Displacement field
X=sprintf('Ratio: %d',Ratio); %Define ratio for display
disp(X); %Display current increment / iteration
if (Ratio<=tolerance) %case conrergence
    convrg=true; %Assign congergence equal to true
end
end