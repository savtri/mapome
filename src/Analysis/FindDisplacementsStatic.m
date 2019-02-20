function [ u,lagrMulti,Cl,Cff,G,Fem,Mp,InputIndex ] = FindDisplacementsStatic( inc,iter,K,P,pres,pext,V,UnKnownDis,KnownDis,u,c,lagrMulti,Fem,Mp,InputIndex )
tic %Start Time for Solve system
%% Find Displacement Field
if InputIndex.JacobFreeNewtonKrylovIndex(1,1)==0 %case with stiffness matrix
    if InputIndex.SolAlg.SolAlgIndex==1 %case Load Control 
       [ u,lagrMulti,Cl,Cff,G,InputIndex ] = FindDisplacementsStaticLoadControl( inc,iter,K,pres,V,UnKnownDis,KnownDis,u,lagrMulti,Fem,Mp,InputIndex );
    elseif InputIndex.SolAlg.SolAlgIndex==2 %case Displacement Control 
       [ u,lagrMulti,Cl,Cff,G,InputIndex ] = FindDisplacementsStaticDispControl( inc,iter,K,P,pres,V,UnKnownDis,KnownDis,u,lagrMulti,Fem,Mp,InputIndex );
    end
elseif InputIndex.JacobFreeNewtonKrylovIndex(1,1)==1 %case without stiffness matrix    
    if InputIndex.SolAlg.SolAlgIndex==1 %case Load Control 
        [ u,InputIndex ] = FindDisFieldJacobFreeStaticLoadControl( inc,iter,pext,V,UnKnownDis,KnownDis,Fem,Mp,InputIndex );
    end 
end
X=sprintf('Solve System: ok'); %Assign
disp(X); %Display 
toc %End Time for Solve System
end

