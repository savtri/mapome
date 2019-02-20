function [ ML ] = MpKinemConstrMatrices( Mp1,dof1,nkc,dof,Fem,Mp,InputIndex )
%% Kinematic contrains matrices for Material Point Constrains (Cl=-ML+MR)
for i=1:InputIndex.NumberOfElements %Loop for all elements
    A=Fem.MPs{i,:};
    iid=Mp1;
    [row,col]=find(A == iid); %Find where Loaded MP belogs to
    if isempty(row)==0 && isempty(col)==0
        elIndex=i; %Assign the element index that Loaded MP belong to
        NodeIndex=Fem.NodeIndex(elIndex,:);
        %shape functions
        N=Mp.N{iid,1};
        ML=zeros(1,dof); %Define the kinematic contrains matrix
        if dof1==1 %x direction
            ML(1,2*NodeIndex(1,:)-1)=N';
        elseif dof1==2 %y-direction
            ML(1,2*NodeIndex(1,:))=N';
        end
        break;
    end
end
end