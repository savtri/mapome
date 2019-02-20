function [ InputIndex ] = ReadSolAlgParam( text,InputIndex )
%% Read Solution Algorithm Parameters and Case Index
if InputIndex.SolAlg.SolAlgIndex(1,1)==1 %case load control
    SolutionIndex='$LOAD_CONTROL';
elseif InputIndex.SolAlg.SolAlgIndex==2 %case displacement control
    SolutionIndex='$DISPLACEMENT_CONTROL';
end
idx = find(~cellfun('isempty',strfind(text,SolutionIndex))) + 1;

if ~isempty(idx)
    idx = find(~cellfun('isempty',strfind(text,SolutionIndex))) + 1;
    LWm = cellfun(@(x) textscan(x,'%c'),text(idx),'un',0);
    CaseIndex = cell2mat([LWm{:}]).'; %Assign Case Index
    if strcmp(CaseIndex,'set') %case set factor
        LWm2 = cellfun(@(x) textscan(x,'%f'),text(idx+1),'un',0);
        LWm2 = cell2mat([LWm2{:}]).';
        MaxLoadFactor=LWm2(1,1); %Max Load Factor (Load Control)
        NumberOfIncrements=LWm2(1,4); %Number Of Increments
        LoadFactorIncrement=MaxLoadFactor/NumberOfIncrements; %Increment of Load Factor (Load Factor) or Increment of Displacement (Displacement Control)
        tolerance=LWm2(1,2); %Tolerance of Newton-Raphson
        Iter=LWm2(1,3); %Number of Iteration in each increment
        if InputIndex.SolAlg.SolAlgIndex(1,1)==1 %case Load Control
            InputIndex.SolAlg.SolAlgParam(1,:)=[LoadFactorIncrement,tolerance,Iter,NumberOfIncrements,MaxLoadFactor]; %Assign Solution Algorithm Parameters 
        elseif InputIndex.SolAlg.SolAlgIndex(1,1)==2 %case Displacement Control
            %Displacement Control additional parameters
            MaxLoadFactor=0; %Assign Load Factor equal to 0
            LoadFactorIncrement=0; %Assign Load Factor Increment equal to 0 
            NodeIndex=LWm2(1,5); %Node Index for displacement control
            dofIndex=LWm2(1,6); %Degree of Freedom Index
            MaxDisplacement=LWm2(1,7); %Max Displacement of Node Index 
            DispIncrement=MaxDisplacement/NumberOfIncrements; %Increment of Displacement
            NodeMPIndex=LWm2(1,8); %Node/Material Point Index
            InputIndex.SolAlg.SolAlgParam(1,:)=[LoadFactorIncrement,tolerance,Iter,NumberOfIncrements,MaxLoadFactor,NodeIndex,dofIndex,DispIncrement,MaxDisplacement,NodeMPIndex]; %Assign Solution Algorithm Parameters 
        end
        InputIndex.SolAlg.NumberOfIncrements=NumberOfIncrements; %Assign total number of increments
        InputIndex.SolAlg.CaseIndex=1; %Assign Case Index
    elseif strcmp(CaseIndex,'history') %case load factor history
        [ InputIndex ] = ReadIncrementHistoryParamters( text,InputIndex );
        InputIndex.SolAlg.Inc=1; %Assign history increment equal to one
        InputIndex.SolAlg.CaseIndex=2; %Assign Case Index
    end
end
end

