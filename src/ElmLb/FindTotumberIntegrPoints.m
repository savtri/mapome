function [ InputIndex ] = FindTotumberIntegrPoints( Mp,InputIndex )
%% Assign the total number of integration points
if InputIndex.AnalIndex.MPMIndex(1,1)==0 %case no Material Point
   InputIndex.NumberTotOfIntegPoints=InputIndex.NumberOfIntegPoints*InputIndex.NumberOfElements; %Assign the Number Of Material Points 
elseif InputIndex.AnalIndex.MPMIndex(1,1)==1 %case no Material Point
   InputIndex.NumberTotOfIntegPoints=size(Mp.GroupType,1);
end
end

