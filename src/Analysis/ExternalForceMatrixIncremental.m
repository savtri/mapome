function [ P ] = ExternalForceMatrixIncremental( inc,t,Fem,Mp,InputIndex )
%% External Force Matrix
P=zeros(InputIndex.DegreeOfFreedom,1); %Define External Force Matrix

%% Assign Individual Loads
[ P ] = IndividualLoadsAssign( inc,P,t,Fem,Mp,InputIndex );
end
