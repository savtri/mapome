function [ P ] = IndividualLoadsAssign( inc,P,t,Fem,Mp,InputIndex )
%% Assign Nodal Loads
for h=1:InputIndex.Loads.NumberOfIndividualLoads %Loop for all Individual Loads
    LoadMatrix=InputIndex.Loads.IndividualLoadIndex(h,:);
    nsize=size(LoadMatrix,2);
    if LoadMatrix(1,nsize)==1 %case Individual Load in Node
        %Assign Load x-Direction
        P(2*LoadMatrix(1,1)-1,1)=LoadMatrix(1,2);
        %Assign Load y-Direction
        P(2*LoadMatrix(1,1),1)=LoadMatrix(1,3);
    elseif LoadMatrix(1,nsize)==2 %case Individual Load in Material Point
        for i=1:InputIndex.NumberOfElements %Loop for all elements
            A=Fem.MPs{i,:};
            iid=LoadMatrix(1,1);
            [row,col]=find(A == iid); %Find where Loaded MP belogs to
            if isempty(row)==0 && isempty(col)==0
                elIndex=i; %Assign the element index that Loaded MP belong to
                NodeIndex=Fem.NodeIndex(elIndex,:);
                %shape functions and derivatives
                N=Mp.N{iid,1};
                %Assign Load x-Direction
                P(2*NodeIndex-1,1)=P(2*NodeIndex-1,1)+N*LoadMatrix(1,2);
                %Assign Load y-Direction
                P(2*NodeIndex,1)=P(2*NodeIndex,1)+N*LoadMatrix(1,3);
                break;
            end
        end
    end
end
end

