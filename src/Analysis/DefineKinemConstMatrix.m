function [ lagrMulti ] = DefineKinemConstMatrix( InputIndex )
%% Define Imposed Kinematic Constrain Matrix (Lagrange Multipliers)
%Define Number of Kinematic Constrains
nkc=InputIndex.Constrains.NumberOfKinemConst;
if nkc==0 %case no kinematic constrains
    lagrMulti=[];
else %case at least one kinematic constrains
    lagrMulti=zeros(nkc,1); %Define Lagrange Multiplier vector
end
end