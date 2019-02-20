function [ V ] = VRearrangeFunction( Constrains,DegreeOfFreedom,KnownDis )
%% Define Rearrange Matrix
V=zeros(DegreeOfFreedom);
%% Create Rearrange Matrix
j=DegreeOfFreedom-KnownDis+1;
k=1;
for i=1:DegreeOfFreedom
    if (Constrains(i)==0)
        V(i,j)=1;
    j=j+1;
    elseif (Constrains(i)==1)
        V(i,k)=1;
        k=k+1;
    end
end
end