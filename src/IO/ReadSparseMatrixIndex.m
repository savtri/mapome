function [ InputIndex ] = ReadSparseMatrixIndex( text,InputIndex )
%% Read Sparse Matrix Index
idx = find(~cellfun('isempty',strfind(text,'$$SPARSE_MATRIX'))) + 1;
LWm = cellfun(@(x) textscan(x,'%f'),text(idx),'un',0);
LWm = cell2mat([LWm{:}]).';
SparseIndex(1,:)=LWm;
InputIndex.SparseIndex=SparseIndex;
end
