function [ InputIndex ] = ReadPlasticProperties( text,InputIndex )
%% Read the plastic properties of the element
if InputIndex.AnalIndex.MaterialNLIndex(1,1)==1 %case Material Nonlinearity
    NumberOfHardeningPoints=zeros(InputIndex.NumberOfDifferentSections,1);
    LinePlasticIdentify=zeros(InputIndex.NumberOfDifferentSections+1,1);
    %Find the lines in text where -$ exists
    idx = find(~cellfun('isempty',strfind(text,'$PLASTIC_ISO_HARDENING')));
    
    if ~isempty(idx)
    
        LWm = cellfun(@(x) textscan(x,'%c'),text(idx),'un',0);
        LWm = cell2mat([LWm{:}]).';
        [LWm] = strsplit(LWm,{','});
        h1=1;
        h2=1;
        while (strcmp(LWm,'$$')==0)
            idx = find(~cellfun('isempty',strfind(text,'$PLASTIC')))+h1;
            LWm = cellfun(@(x) textscan(x,'%c'),text(idx),'un',0);
            LWm = cell2mat([LWm{:}]).';
            [LWm] = strsplit(LWm,{','});
            if (strcmp(LWm,'-$')==1)
                LinePlasticIdentify(h2,1)=idx;
                h2=h2+1;
            end
            h1=h1+1;
        end
        %Find the Hardening Points for each material
        for i=1:InputIndex.NumberOfDifferentSections
            NumberOfHardeningPoints(i,1)=LinePlasticIdentify(i+1)-LinePlasticIdentify(i)-2;
        end
        %Read Hardening Points
        for i=1:InputIndex.NumberOfDifferentSections
            for j=1:NumberOfHardeningPoints(i,1)
                LWm = cellfun(@(x) textscan(x,'%f'),text(LinePlasticIdentify(i,1)+j+1),'un',0);
                LWm = cell2mat([LWm{:}]).';
                HardeningPoints{i,1}(j,:) = LWm;
            end
        end
        InputIndex.NumberOfHardeningPoints=NumberOfHardeningPoints;
        InputIndex.HardeningPoints=HardeningPoints;
    end
end
end

