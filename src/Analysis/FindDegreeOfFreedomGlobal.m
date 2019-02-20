function [ dof ] = FindDegreeOfFreedomGlobal( Node,dof,nsize,dofT )
%% Find global degree of freedom for draw graphs 
if nsize==dofT %case equal degree of freedom
    if dof==1 %case first direction (x)
        dof=2*Node-1;
    elseif dof==2 %case second direction (y)
        dof=2*Node;
    else %case error
        Disp('Problem with degree of freedom: Accepted values 1 or 2')
        stop
    end
else %case not equal degree of freedom (scalar variable)
    if dof==1 %case first direction (scalar variable)
        dof=Node;
    else %case error
        Disp('Problem with degree of freedom: Accepted values 1')
        stop
    end
end
end