function [ nkc,Cl,G ] = KinemConstrMatrices( Fem,Mp,InputIndex )
%% Define the Kinematic Constrains Matrices
%Define Number of Kinematic Constrains
nkc=InputIndex.Constrains.NumberOfKinemConst;
%Degree of freedom 
dof=InputIndex.DegreeOfFreedom;
%Define the imposed displacement matrix
G=zeros(nkc,1);
%Define the coefficient matrix of contrained degree of freedom
Cl=zeros(nkc,dof);
for h=1:nkc %Loop for all kinematic constrains
    KinemConstIndex=InputIndex.Constrains.KinemConstIndex{h,1};
    nsize=size(KinemConstIndex,2);
    for k=2:4:nsize-3 %Loop for all include variables
        Ceof=KinemConstIndex(1,k);
        NodeMp=KinemConstIndex(1,k+1);
        dofDir=KinemConstIndex(1,k+2);
        iNodeMp=KinemConstIndex(1,k+3);
        if iNodeMp==1 %case Node
            if dofDir==1 %case x-direction
                dofGlob=2*NodeMp-1;
            elseif dofDir==2 %case y-direction
                dofGlob=2*NodeMp;
            end
            Cl(h,dofGlob)=Cl(h,dofGlob)+Ceof;
        elseif iNodeMp==2 %case Material Point
            % Kinematic contrain Matrix
            [ ML ] = MpKinemConstrMatrices( NodeMp,dofDir,nkc,dof,Fem,Mp,InputIndex );
            Cl(h,:)=Cl(h,:)+Ceof*ML;
        end
        ImposedDisp=KinemConstIndex(1,nsize);
        G(h,1)=G(h,1)+ImposedDisp;
    end
end
end

