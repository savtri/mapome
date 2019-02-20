function [ Fem,Mp,InputIndex ] = EvolutionOfFractureFEM( inc,i,j,iid,E,v,l,mu,k,Fem,Mp,InputIndex )
%% Define Degratation Function
c=Mp.c(1,iid);
g=(1-k)*c^2+k; %Degradation function
%% Convert strain vector to strain tensor

if InputIndex.ElementsType==8 || InputIndex.ElementsType==10 %Plain Strain
    e=[Mp.e(1,iid),Mp.e(3,iid)/2;Mp.e(3,iid)/2,Mp.e(2,iid)];
    %Define the Identity Matrix
    I=eye(2);
elseif InputIndex.ElementsType==9 ||InputIndex.ElementsType==11 %Plain Stress
    Mp.e(4,iid)=-(v/(1-v))*(Mp.e(1,iid)+Mp.e(2,iid));
    e=[Mp.e(1,iid),Mp.e(3,iid)/2,0;Mp.e(3,iid)/2,Mp.e(2,iid),0;0,0,Mp.e(4,iid)];
    %Define the Identity Matrix
    I=eye(3);
end 


%% Evaluate the eigenvectors P and eigenvalues Lamda of strain tensor
[P,Lamda] = eigenshuffle(e);
%[P,Lamda]=eig(e);
Lamda=diag(Lamda);
Mp.EigVec{iid,1}=P;
Mp.EigVal{iid,1}=Lamda;

%% Evaluate the <Lamda> based on Hughes (2012)
for h=1:size(Lamda,1)
    [ Lamda_1(h,1) ] = RampFunctionHughes( Lamda(h,h) );
end
%% Evaluate Positive Part of Lamda  
for h=1:size(Lamda,1)
    Lamda_plus(h,h)=Lamda_1(h,1);
end
%% Evaluate Negative Part of Lamda  
Lamda_minus=Lamda-Lamda_plus; 
%% Evaluate the Positive / Negative Part of strain tensor
e_plus=P*Lamda_plus*P'; %positive part
e_minus=P*Lamda_minus*P'; %negative part
%% Evaluate the sum of Positive and Negative Strain tensor
e_decop=e_plus+e_minus;
%% Evaluate <trace(e)> Positive / Negative based on Hughes
[ trace_e ] = RampFunctionHughes( trace(e) );
%% Evaluate Positive / Negative free energy function
psi_plus=0.50*l*((trace_e)^2)+mu*trace(e_plus^2); %positive part of free energy
psi_minus=0.50*l*(trace(e)-trace_e)^2+mu*trace((e-e_plus)^2); %negative part of free energy
%% Evaluate Positive / Negative free energy function 2
[ trace_e_plus ] = RampFunction( trace(e),1 ); %<trace(e)>+
[ trace_e_minus ] = RampFunction( trace(e),2 ); %<trace(e)>-
psi_plus_Miehe=l*trace_e_plus*trace_e_plus*0.50+mu*trace(e_plus*e_plus);
psi_minus_Miehe=l*trace_e_minus*trace_e_minus*0.50+mu*trace(e_minus*e_minus);
psi_undamage_Miehe=psi_plus_Miehe+psi_minus_Miehe;
%% Evaluate the sum of Positive and Negative Part of free energy function
psi_decop=psi_plus+psi_minus;
psi_undamage=l*trace(e)*trace(e)*0.50+mu*trace(e*e);
%% Evaluate <trace(e)> Positive / Negative based on Miehe
[ trace_e_plus ] = RampFunction( trace(e),1 ); %<trace(e)>+
[ trace_e_minus ] = RampFunction( trace(e),2 ); %<trace(e)>-
%% Evaluate the stress tensor 
s_decop=g*(l*trace_e_plus*I+2*mu*e_plus)+(l*trace_e_minus*I+2*mu*e_minus);
s_2=l*trace(e)*I+2*mu*e;
%% Vectorize stress tensor 
Mp.s(1:3,iid)=[s_decop(1,1),s_decop(2,2),s_decop(1,2)];
%% Evaluate the out of plane stress
if InputIndex.ElementsType==8 || InputIndex.ElementsType==10 %Plain Strain
    G=E/(2*(1+v)); 
    K1=E/(3*(1-2*v));
    eev=Mp.e(1,iid)+Mp.e(2,iid)+Mp.e(4,iid); %Volumetric strain
    P=K1*eev;
    eet=-eev/3;
    Mp.s(4,iid)=2*G*eet+P; %out of plane stress
end
%% Define the strain-history field
Mp.psi_plus(1,iid)=psi_plus;
%% Define the elastic strain energy density 
Mp.psi(1,iid)=g*psi_plus+psi_minus;
%% Define the energetic force
%Miehe at el (2010)  eq. (24)
Mp.f(1,iid)=2*Mp.c(1,iid)*psi_plus;
end

