function [ t ] = timeParameterIncremental( inc,InputIndex )
%% Define the current time
dt=InputIndex.AnalIndex.TimeIndex(1,3);
t=inc*dt;
end

