function F = ParametricCoords( x,xyzMp,xyzFem,i,InputIndex )
%% Find the coords of Material Point in Parametric Space
xi=x(1,1);
eta=x(1,2);
%shape functions and derivatives
[ N,naturalDerivatives,JIsogeometric ]=shapeFunctionFEM(i,xi,eta,InputIndex);
F=xyzMp-N'*xyzFem';
end

