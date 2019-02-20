function [JacobianMatrix,invJacobian,XYDerivatives] = Jacobian(XY,naturalDerivatives)
    % JacobianMatrix    : Jacobian matrix
    % invJacobian : inverse of Jacobian Matrix
    % XYDerivatives  : derivatives w.r.t. x and y
    % naturalDerivatives  : derivatives w.r.t. xi and eta
    % nodeCoordinates  : nodal coordinates at element level
    JacobianMatrix=naturalDerivatives*XY';                   
    invJacobian=inv(JacobianMatrix);
    XYDerivatives=0;
end % end function Jacobian