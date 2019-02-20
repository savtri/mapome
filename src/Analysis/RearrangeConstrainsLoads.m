function [ InputIndex ] = RearrangeConstrainsLoads( InputIndex )
%% Rearrange Contrains/Loads
%Rearrange Contrains According to Active Nodes
for i=1:InputIndex.Constrains.NumberOfIndividualConstrains %Loop for all Individual Contrains
    nsize=size(InputIndex.Constrains.IndividualConstrainsIndex(i,:),2);
    if InputIndex.Constrains.IndividualConstrainsIndex(i,nsize)==1 %case Individual Constrains in Nodes
        nIndex=InputIndex.Constrains.IndividualConstrainsIndex(i,1);
        LocNode=find(InputIndex.MpProps.ActiveNodesTot(:,1)==nIndex);
        InputIndex.Constrains.IndividualConstrainsIndex(i,1)=InputIndex.MpProps.ActiveNodesTot(LocNode,2);
    end
end

%% Rearrange Loads According to Active Nodes
%Individual Loads
for i=1:InputIndex.Loads.NumberOfIndividualLoads
    nsize=size(InputIndex.Loads.IndividualLoadIndex(i,:),2);
    if InputIndex.Loads.IndividualLoadIndex(i,nsize)==1 %case Individual Loads in Nodes
        nIndex=InputIndex.Loads.IndividualLoadIndex(i,1);
        LocNode=find(InputIndex.MpProps.ActiveNodesTot(:,1)==nIndex);
        InputIndex.Loads.IndividualLoadIndex(i,1)=InputIndex.MpProps.ActiveNodesTot(LocNode,2);
    end
end

%% Rearrange Solution Algorithm Loads
if InputIndex.SolAlg.SolAlgIndex(1,1)==1 %case Load Control
   
elseif InputIndex.SolAlg.SolAlgIndex(1,1)==2 %case Displacement Control
    if InputIndex.SolAlg.CaseIndex(1,1)==1 %case set
        if InputIndex.SolAlg.SolAlgParam(1,10)==1 %case Displacement Control in Node (else Displacement Control in Material Point)
            nIndex=InputIndex.SolAlg.SolAlgParam(1,6);
            LocNode=find(InputIndex.MpProps.ActiveNodesTot(:,1)==nIndex);
            InputIndex.SolAlg.SolAlgParam(1,6)=InputIndex.MpProps.ActiveNodesTot(LocNode,2);
        end
    elseif InputIndex.SolAlg.CaseIndex(1,1)==2 %case history
        IncIndex=InputIndex.SolAlg.Inc; %Assign the history index
        if InputIndex.SolAlg.SolAlgParam(IncIndex,10)==1 %case Displacement Control in Node (else Displacement Control in Material Point)
            nIndex=InputIndex.SolAlg.SolAlgParam(IncIndex,6);
            LocNode=find(InputIndex.MpProps.ActiveNodesTot(:,1)==nIndex);
            InputIndex.SolAlg.SolAlgParam(IncIndex,6)=InputIndex.MpProps.ActiveNodesTot(LocNode,2);
        end
    end
end
end

