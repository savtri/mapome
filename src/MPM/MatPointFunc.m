function [ Fem,Mp,InputIndex ] = MatPointFunc( Fem,Mp,InputIndex )
%% Assign Material Point Method
%Initialize Integration Point Coords (only for Finite Element Method
for i=1:InputIndex.NumberOfElements %Loop for all elements
    mps=Fem.MPs{i,:}; %Material Points in that Finite Element
    InputIndex.NumberOfIntegPoints=size(mps,1);  %Number of material points in that Finite Element 
    %Assign x,y coords of element
    XYZ(1,:)=InputIndex.IndexXYNodes(Fem.NodeIndex(i,:),2); %x ccords
    XYZ(2,:)=InputIndex.IndexXYNodes(Fem.NodeIndex(i,:),3); %y coords
    %XYZ(3,i)=InputIndex.IndexXYNodes(Fem.NodeIndex(i,:),4); %z coords
    for j=1:InputIndex.NumberOfIntegPoints
        %Assign Integration Point Weights and Locations
        [ IntPoinWeights,IntPointLocations ] = IntegrPointsWeightsLocations( i,mps(j,1),Fem,Mp,InputIndex );   
        IntPoint=IntPointLocations(j,:);                                                                 
        %Coords in Isoparametric Space
        xi=IntPoint(1);
        eta=IntPoint(2);
        %shape functions and derivatives
        [ N,naturalDerivatives ]=shapeFunction(xi,eta,InputIndex);
        %Coords in Physical Space
        Mp.coords(mps(j,1),:)=N'*XYZ';
        %Assign the Integration Point Volume
        thickness=InputIndex.thickness(Mp.GroupType(mps(j,1),1)); %Assign Thickness
        %Jacobian matrix, inverse of Jacobian
        [Jacob,invJacobian,XYderivatives]=Jacobian(XYZ,naturalDerivatives);
        %B1 Matrix (Jacobian terms)
        [ B1 ] = PlaneStressB1Matrix( Jacob );
        %B2 Matrix (Derivative terms xi,eta)
        [ B2 ] = PlaneStressB2Matrix( naturalDerivatives );
        %B matrix (Derivative terms x,y) 
        [ B ] = B1*B2;
        dRdx=(invJacobian*naturalDerivatives);
        Mp.N{mps(j,1),1}=N;
        Mp.dRdx{mps(j,1),1}=dRdx;
        Mp.B{mps(j,1),1}=B;
        Mp.vol(mps(j,1),1)=det(Jacob)*IntPoinWeights(j,1)*thickness;
        Mp.rho(mps(j,1),1)=InputIndex.rho(Mp.GroupType(mps(j,1),1)); %Assign Mass density
        Mp.mass(mps(j,1),1)=Mp.rho(mps(j,1),1)*Mp.vol(mps(j,1),1); %Assign Mass 
    end
end
nInP=InputIndex.NumberTotOfIntegPoints; %Assign Total Number Of Integration Points
Mp.Pext(1:nInP,1:2)=0; %Assign External Forces in Material Point equal to zero
Mp.vel(1:nInP,1:2)=0; %Assign initial velocities of Material Points
Mp.acc(1:nInP,1:2)=0; %Assign initial accelerations of Material Points
end

