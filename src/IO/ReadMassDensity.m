function [ InputIndex ] = ReadMassDensity( text,InputIndex )
%% Read mass density
for i=1:InputIndex.NumberOfDifferentSections %Loop for all Different Section
    idx = find(~cellfun('isempty',strfind(text,'$MASS_DENSITY'))) + i;
    
    if ~isempty(idx)
        LWm = cellfun(@(x) textscan(x,'%f'),text(idx),'un',0);
        LWm = cell2mat([LWm{:}]).';
        MassDensity(i,1) = LWm(1,2);
    else
        MassDensity(i,1)=0;
    end
    
end
InputIndex.rho=MassDensity; %Assign Mass Density
end

