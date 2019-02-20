function [ pres,pext ] = DefineIncrementalExternalForces( inc,pres,P,InputIndex )
%% Define incremental external load
if InputIndex.SolAlg.CaseIndex==1 %case set Index
    %Define the incremental External Force Matrix
    pext=P*InputIndex.SolAlg.SolAlgParam(1,1);
    %Define Residual External Forces
    pres=pres+P*(InputIndex.SolAlg.SolAlgParam(1,1));
elseif InputIndex.SolAlg.CaseIndex==2 %case history Index
    %Define the incremental External Force Matrix
    pext=P*(InputIndex.SolAlg.SolAlgParam(inc,1)-InputIndex.SolAlg.SolAlgParam(inc-1,1));
    %Define Residual External Forces
    pres=pres+P*(InputIndex.SolAlg.SolAlgParam(inc,1)-InputIndex.SolAlg.SolAlgParam(inc-1,1));
end
end

