function [ InputIndex ] = ReadFractureProperties( text,InputIndex )
%% Read Fracture Parameters
if InputIndex.AnalIndex.CrackPropagationIndex(1,1)==1 %case Crack Propagation
    for i=1:InputIndex.NumberOfDifferentSections %Loop for all Different Section
        idx = find(~cellfun('isempty',strfind(text,'$FRACTURE'))) + i;
        LWm = cellfun(@(x) textscan(x,'%f'),text(idx),'un',0);
        LWm = cell2mat([LWm{:}]).';
        lo(i,1)=LWm(1,2); %lo Length Scale parameter
        Gc(i,1)=LWm(1,3); %Gc Critical Energy Release Rate 
        k(i,1)=LWm(1,4);  %k parameter (for stiffness degratation). Typical values k=0
    end
    InputIndex.lo=lo; %Assign Length Scale parameter
    InputIndex.Gc=Gc; %Assign Critical Energy Release Rate 
    InputIndex.k=k; %Assign k parameter
end
end



