function [ InputIndex ] = Find2Dollar( text,InputIndex )
%% Find the '$' symbols in text 
IndexC=strfind(text, '$');
InputIndex.Dollar=find(not(cellfun('isempty', IndexC)));

%% Find the '$$' symbols in text 
IndexC=strfind(text, '$$');
InputIndex.Dollar2=find(not(cellfun('isempty', IndexC)));
end

