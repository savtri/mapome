function [ InputIndex ] = DrawFunction1 ( Fem,Mp,InputIndex )
if InputIndex.DrawIndex.DrawInitialStructureIndex(1,1)==1 || InputIndex.DrawIndex.DrawInitialStructureIndex(1,2)==1 || InputIndex.DrawIndex.DrawInitialStructureIndex(1,3)==1 || InputIndex.DrawIndex.DrawInitialStructureIndex(1,4)==1 
    %% Draw Initial Structure
    if InputIndex.DrawIndex.DrawInitialStructureIndex(1,1)==1 || InputIndex.DrawIndex.DrawInitialStructureIndex(1,2)==1
        path=[InputIndex.JobIndex filesep 'Draw' filesep 'InitalStructure.png']; %Assign the Path
        fid=path;
        InputIndex.fID=InputIndex.fID+1; %Update Figure ID
        figureID=InputIndex.fID; %Assign Figure ID
        DrawInitialStructure( Fem,InputIndex,fid,figureID );
    end
    %% Draw Initial Sections of Structure
    if InputIndex.DrawIndex.DrawInitialStructureIndex(1,3)==1 || InputIndex.DrawIndex.DrawInitialStructureIndex(1,4)==1
        path=[InputIndex.JobIndex filesep 'Draw' filesep 'InitalStructureSections.png']; %Assign the Path
        fid=path;
        InputIndex.fID=InputIndex.fID+1; %Update Figure ID
        figureID=InputIndex.fID; %Assign Figure ID
        DrawInitialStructureSections( Fem,Mp,InputIndex,fid,figureID );
    end
end
end

