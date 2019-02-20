function [ InputIndex ] = ReadElasticProperties( text,InputIndex )
%% Read the elastic properties of the element
for i=1:InputIndex.NumberOfDifferentSections    
    idx = find(~cellfun('isempty',strfind(text,'$ELASTIC'))) + i;
    
    if ~isempty(idx)
    
        LWm = cellfun(@(x) textscan(x,'%f'),text(idx),'un',0);
        LWm = cell2mat([LWm{:}]).';
        MaterialProperties = LWm;
        if MaterialProperties(1,size(MaterialProperties,2))==1 %case E,v as Input
            E(i,1)=MaterialProperties(1,2); %Young's Modulus
            v(i,1)=MaterialProperties(1,3); %Poisson Ratio
            %Convert E,v to Lame Constants 
            [ Lambda(i,1),mu(i,1) ]=ConvertFromEandVToLameConstants( E(i,1),v(i,1) );
        elseif MaterialProperties(1,size(MaterialProperties,2))==2 %case Lame constants as Input
            Lambda(i,1)=MaterialProperties(1,2); %Lambda (Lame Constant)
            mu(i,1)=MaterialProperties(1,3); %mu (Lame Constant)
            %Convert Lame Constants to E,v 
            [ E(i,1),v(i,1) ]=ConvertFromLameConstantsToEandV( Lambda,mu );
        end
    else
       error('$ELASTIC key must exist'); 
    end
end
InputIndex.E=E; %Assign the Young's Modulus
InputIndex.v=v; %Assign the Poisson Ratio
InputIndex.Lambda=Lambda; %Assign the Lambda (Lame Constant)
InputIndex.mu=mu; %Assign the mu (Lame Constant)
end

