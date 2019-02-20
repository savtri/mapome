function [ Fem,InputIndex ] = StoreLoadInitialGrid( Fem,InputIndex )
%% Store or Load Initial Grid
if InputIndex.MpProps.InitialGrid==1 %case Store Initial Grid
    %Store Initial Grid
    save 'InputIndex.mat';
    InputIndex.MpProps.InitialGrid=0; 
elseif InputIndex.MpProps.InitialGrid==0 %case Load Initial Grid
    %Load Initial Grid
    [ Fem,LoadParameters ] = LoadInitialGrid( );
    InputIndex.IndexXYNodes=LoadParameters.IndexXYNodes;
    InputIndex.Constrains.IndividualConstrainsIndex=LoadParameters.Constrains.IndividualConstrainsIndex;
    InputIndex.Loads.IndividualLoadIndex=LoadParameters.Loads.IndividualLoadIndex;
    InputIndex.NumberOfElements=LoadParameters.NumberOfElements;
    InputIndex.NumberOfNodes=LoadParameters.NumberOfNodes;
    if InputIndex.SolAlg.SolAlgIndex==2 %case Displacement Control
        if InputIndex.SolAlg.CaseIndex(1,1)==1 %case set
            IncIndex=InputIndex.SolAlg.Inc; 
        elseif InputIndex.SolAlg.CaseIndex(1,1)==2 %case history
            InputIndex.SolAlg.Inc=InputIndex.SolAlg.Inc+1;
            IncIndex=InputIndex.SolAlg.Inc;
        end
        InputIndex.SolAlg.SolAlgParam(IncIndex,6)=LoadParameters.SolAlg.SolAlgParam(IncIndex,6);
    end
    InputIndex.SolAlg.LoadFact=0; %Assign Total Load Factor equal to zero
    InputIndex.SolAlg.DLoadFact=0; %Assign incremental Load Factor equal to zero
end
end

