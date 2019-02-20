function [ InputIndex ] = DeleteVariables1( InputIndex )
%% Delete Elements
field = 'Elements';
InputIndex = rmfield(InputIndex,field);
%% Delete Dollar
field = 'Dollar';
InputIndex = rmfield(InputIndex,field);
%% Delete Dollar2
field = 'Dollar2';
InputIndex = rmfield(InputIndex,field);
end

