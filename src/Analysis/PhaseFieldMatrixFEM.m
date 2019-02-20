function [ Kc ] = PhaseFieldMatrixFEM( i,Kc,kc,Fem,InputIndex )
%% Find Global Degree of Freedom in i element
sctrB=[];
for j=1:size(Fem.NodeIndex(i,:),2)
    sctrB=[sctrB Fem.NodeIndex(i,j)];
end
%% Assign to Global Stiffness Matrix
if InputIndex.SparseIndex(1,1)==0 %case no sparse 
    Kc(sctrB,sctrB) = Kc(sctrB,sctrB)+kc;
elseif InputIndex.SparseIndex(1,1)==1 %case sparse
    for e1=1:size(sctrB,2)
        for e2=1:size(sctrB,2)
            Node1=sctrB(1,e1);
            Node2=sctrB(1,e2);
            try %case previous elements in Kc(Node1,Node2)
                Kc(Node1,Node2)=Kc(Node1,Node2)+kc(e1,e2);
            catch %case no previous elements in Kc(Node1,Node2)
                Kc(Node1,Node2)=kc(e1,e2);
            end
        end
    end
end
end