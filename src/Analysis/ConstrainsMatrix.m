function [ Constrains ] = ConstrainsMatrix( Fem,Mp,InputIndex )
%% Constrains Matrix
Constrains=ones(InputIndex.DegreeOfFreedom,1);
for h=1:InputIndex.Constrains.NumberOfIndividualConstrains %Loop for all Individual Constrains
    ConstrainMatrix=InputIndex.Constrains.IndividualConstrainsIndex(h,:);
    nsize=size(ConstrainMatrix,2);
    if ConstrainMatrix(1,nsize)==1 %case Individual Constrains in Nodes
        Constrains(2*ConstrainMatrix(1,1)-1,1)=ConstrainMatrix(1,2);
        Constrains(2*ConstrainMatrix(1,1),1)=ConstrainMatrix(1,3);
    elseif ConstrainMatrix(1,nsize)==2 %case Individual Constrains in Material Point
        for i=1:InputIndex.NumberOfElements %Loop for all elements
            A=Fem.MPs{i,:};
            iid=ConstrainMatrix(1,1);
            [row,col]=find(A == iid); %Find where Constrained MP belogs to
            if isempty(row)==0 && isempty(col)==0
                elIndex=i; %Assign the element index that Loaded MP belong to
                NodeIndex=Fem.NodeIndex(elIndex,:);
                Constrains(2*NodeIndex-1,1)=ConstrainMatrix(1,2);
                Constrains(2*NodeIndex,1)=ConstrainMatrix(1,3);
                break;
            end
        end
    end
end
end

