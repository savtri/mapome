function [ ukq ] = FindValueControlledNode( uk,IncIndex,Fem,Mp,InputIndex )
%% Find Value of Controlled Node
if InputIndex.SolAlg.SolAlgParam(IncIndex,10)==1 %case Displacement Control in Node
    dofGlob=InputIndex.SolAlg.SolAlgParam(IncIndex,9); %Assign the Degree of Freedom of Node
    ukq=uk(dofGlob,1); %Displacement of the controlled degree of freedom
elseif InputIndex.SolAlg.SolAlgParam(IncIndex,10)==2 %case Displacement Control in Material Point
    for i=1:InputIndex.NumberOfElements %Loop for all elements
        A=Fem.MPs{i,:};
        iid=InputIndex.SolAlg.SolAlgParam(IncIndex,6);
        [row,col]=find(A == iid); %Find where Constrained MP belogs to
        if isempty(row)==0 && isempty(col)==0
            elIndex=i; %Assign the element index that Loaded MP belong to
            %Define the coords of element
            XYZ(1,:)=InputIndex.IndexXYNodes(Fem.NodeIndex(elIndex,:),2); %x ccords
            XYZ(2,:)=InputIndex.IndexXYNodes(Fem.NodeIndex(elIndex,:),3); %y coords
            %XYZ(3,i)=InputIndex.IndexXYNodes(Fem.NodeIndex(elIndex,:),4); %z coords of element
            %Find the local displacements
            [ ulocal ] = DisplacementsLocal( elIndex,Fem,uk );
            %shape functions and derivatives
            N=Mp.N{iid,1};            
            %Convert Shape Functions to Matrix Form
            [ Nm ] = ShapeFunctionMatrix( i,N,Fem );
            dofDirection=InputIndex.SolAlg.SolAlgParam(IncIndex,7); %Assign the direction of controlled degree of freedom
            ukqt=Nm*ulocal;
            ukq=ukqt(dofDirection,1);
            break;
        end
    end
end
end