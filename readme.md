# Material point phase field methods

This repository contains matlab source code for material point methods with the option of performing elastic, elasto-plastic or brittle fracture analysis via the phase field method.

If you find MaPoMe helpful for your research, we kindly ask that you consider citing the paper:

Kakouris, E.G. and Triantafyllou, S.P., 2017. Phase‐field material point method for brittle fracture. International Journal for Numerical Methods in Engineering, 112(12), pp.1750-1776.

## Authors

Emmanouil K. Kakouris and Savvas P. Triantafyllou (The University of Nottingham)

## Instructions

A template input file is provided in the folder Input. The path to the input file name to be run should be provided in the file InputAddressFile.inp. The coordinates of the material points have to be provided in a separate file "MatPoints.dat". 

### Remark

To use the code as a standard FE solver, switch the first variable under the $MATERIAL_POINT_METHOD key to 0, i.e., 0 1 60 0.02 0.02 0.00 0.00. In this case, the MatPoints.dat input file becomes irrelevant. 

## License

MaPoMe is a free software: you can redistribute it and/or modify it under the
terms of the GNU Lesser General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option) any
later version.

MapoMe is distributed freely but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License along
with MaPoMe. If not, see <http://www.gnu.org/licenses/>.
