function [ InputIndex ] = ReadJacobianFreeNewtonKrylovMethodIndexes( text,InputIndex )
%% Read the Jacobian Free Newton Krylov Method Index
idx = find(~cellfun('isempty',strfind(text,'$$JACOBIAN_FREE_NEWTON_KRYLOV'))) + 1;

if ~isempty(idx)
    LWm = cellfun(@(x) textscan(x,'%f'),text(idx),'un',0);
    LWm = cell2mat([LWm{:}]).';
    JacobFreeNewtonKrylovIndex(1,:)=LWm; %If JacobFreeNewtonKrylovIndex(1,1)=1 then GMRES
    InputIndex.JacobFreeNewtonKrylovIndex=JacobFreeNewtonKrylovIndex;
else
   InputIndex.JacobFreeNewtonKrylovIndex=0; 
end

end

