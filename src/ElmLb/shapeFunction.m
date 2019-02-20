function [shape,naturalDerivatives]=shapeFunction(xi,eta,InputIndex)
%% shape functions and derivatives
ElementType=InputIndex.ElementsType; %Assign the element type
if ElementType==8 || ElementType==9 %case Tri Plane Strain / Plane Stress
    shape=[1-xi-eta;xi;eta];
    naturalDerivatives=[-1,1,0;
                        -1,0,1];
elseif ElementType==10 || ElementType==11 %case Quad Plane Strain / Plane Stress
    shape=1/4*[ (1-xi)*(1-eta);(1+xi)*(1-eta);
               (1+xi)*(1+eta);(1-xi)*(1+eta)];
    naturalDerivatives=1/4*[-(1-eta),1-eta,1+eta,-(1+eta);-(1-xi),-(1+xi),1+xi,1-xi];
end
naturalDerivatives2=[];
%Jacobian of Isogeometric
JIsogeometric=1;
end

