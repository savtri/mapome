function [ Fem,Mp,InputIndex ] = InitializeFEMProps( Fem,Mp,InputIndex )
%% Initialize Fem Properties
if InputIndex.AnalIndex.MPMIndex==0 %case no Material Point Method
    %Initialize Integration Point Locations in Fem Elemens (only for Finite Element Method
    iid=1; %Assign the first Integration Point
    for i=1:InputIndex.NumberOfElements %Loop for all elements
       for j=1:InputIndex.NumberOfIntegPoints %Loop for all Integration Points
           Fem.MPs{i,1}(j,1)=iid; %Assign Material Point Indices
           iid=iid+1; %Assign the next Integration Point
       end
    end
end
end

