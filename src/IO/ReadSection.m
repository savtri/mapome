function [ InputIndex ] = ReadSection( text,InputIndex )
%% Read Sections
for i=1:InputIndex.NumberOfDifferentSections %Loop for all Different Section
    idx=find(~cellfun('isempty',strfind(text,'$$SECTION'))) + i;
    
    if ~isempty(idx)
        LWm=cellfun(@(x) textscan(x,'%f'),text(idx),'un',0);
        LWm=cell2mat([LWm{:}]).';
        thickness(i,1)=LWm(1,2);
        nBoucWen(i,1)=LWm(1,3);
        betaBoucWen(i,1)=LWm(1,4);
        gammaBoucWen(i,1)=LWm(1,5);
    else
        error('$$SECTION key must exist');
    end
end

InputIndex.thickness=thickness; %Assign thickness
InputIndex.nBoucWen=nBoucWen; %Assign n Bouc-Wen Parameter
InputIndex.betaBoucWen=betaBoucWen; %Assign beta Bouc-Wen Parameter
InputIndex.gammaBoucWen=gammaBoucWen; %Assign gamma Bouc-Wen Parameter


end

