dir{1}=[pwd '/src'];

numPaths=length(dir);

for ipath=1:numPaths
    addpath(genpath(dir{ipath}))
end