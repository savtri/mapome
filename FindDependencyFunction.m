function [fList,pList] = FindDependencyFunction ( mainStr )
[fList,pList] = matlab.codetools.requiredFilesAndProducts( mainStr );

mkdir_if_not_exist('Dependencies');
for i=1:size(fList,2)
    fid=char(fList{1,i});
    copyfile(fid,'Dependencies','f');
end
stop
end

