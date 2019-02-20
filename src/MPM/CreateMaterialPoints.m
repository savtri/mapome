function [ Mp,InputIndex ] = CreateMaterialPoints( InputIndex )
%% Create Material Points
if InputIndex.AnalIndex.MPMIndex(1,1)==0 %case no Material Point Method
    InputIndex.NumberOfIntegPoints=4;
    nNodes=size(InputIndex.Elements(1,:),2)-1;
    iid=1; %Assign the first Integration Point
    for i=1:InputIndex.NumberOfElements %Loop for all Finite Elements
        for j=1:InputIndex.NumberOfIntegPoints %Loop for all Integration Points
            Mp.GroupType(iid,1)=InputIndex.Elements(i,nNodes+1); %Assign GroupType
            iid=iid+1; %Asssign the next Integration Point
        end
    end
elseif InputIndex.AnalIndex.MPMIndex(1,1)==1 %case Material Point Method
   %% Read Input Data file of Material Points
   [ nMp,MpProp ] = ReadInputDataMaterialPoints( InputIndex ); 
   Mp.coords(1:nMp,:)=MpProp(:,2:3); %Assign Coords of Material Points
   Mp.vol(1:nMp,:)=MpProp(:,5); %Assign control volume of Material Points
   Mp.vel(1:nMp,:)=MpProp(:,6:7); %Assign initial velocities of Material Points
   Mp.Pext(1:nMp,1:2)=0; %Assign External Forces in Material Point equal to zero
   Mp.GroupType(1:nMp,:)=MpProp(:,8); %Assign GroupType of Material Points
end
end

