--- Install CoolProp for Matlab ---

This instruction breaks down what can be find here: http://www.coolprop.org/coolprop/wrappers/MATLAB/

1. Install Python

	There are multiple ways to do this:
	a) Download python directly: https://www.python.org/downloads/
	b) Use anaconda: https://www.anaconda.com/products/individual#Downloads

2. Check whether Matlab finds your python installation with the following command entered into the command line:

	>> pyversion

3. If thats the case, you can install CoolProp from your command line in Python by copying and exectuing the following command in Matlab:

	>> [v,e] = pyversion; system([e,' -m pip install --user -U CoolProp'])

--- Examples ---

Examples for usage in Matlab can be found here: http://www.coolprop.org/coolprop/HighLevelAPI.html#propssi-function
Especially, on the bottom of the page, you can find how to get multiple state variables.

E.g.:

Get temperature ('T') for pressure ('P' = 101325) and saturated liquid ('Q' = 0), works as well with other state variables

>> py.CoolProp.CoolProp.PropsSI('T','P',101325,'Q',0,'N2O')

ans =

  184.6839

Get phase: single phase or two-phase

>> py.CoolProp.CoolProp.PropsSI('Phase','P',6000000,'T',293,'N2O')