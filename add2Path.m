dir{1}=[pwd '/src/Analysis'];
dir{2}=[pwd '/src/ElmLb'];
dir{3}=[pwd '/src/IO'];
dir{4}=[pwd '/src/MPM'];
dir{5}=[pwd '/src/MtlLb'];
dir{6}=[pwd '/src/post'];
dir{7}=[pwd '/src/Utilities'];

numPaths=length(dir);

for ipath=1:numPaths
    addpath(dir{ipath})
end