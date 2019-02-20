function [ U,C,Pext,Fem,Mp,InputIndex ] = ConvergenceTrueStatic( inc,u,U,c,C,pext,Pext,Fem,Mp,InputIndex )
%% Evaluate the total Displacement / Phase field 
if inc==1 %First Increment  
    U(:,1)=u; %total displacement field
    C(:,1)=c; %total phase field
    Pext=pext; %total external force field
else %Other Increments
    U(:,1)=U(:,1)+u; %total displacement field
    C(:,1)=c; %total phase field
    Pext(:,1)=Pext(:,1)+pext; %total external force field
end
%% Allocate Plastic Strain of Last iteration
Mp.epnEquil(:,1)=Mp.e(5,:);
end

