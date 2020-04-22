% This file is run in physicalDesignSimulation.m
% Do not run this file as it is.
%
% This file contains assumptions for the physical design simulation of the Eyjafjallajökull hybrid rocket engine.


[density, sigma] = oxidizerTankMaterialProperties()

opts.OxidizerTankDiameter = 0.075;
opts.OxidizerTankDensity  = density;
opts.OxidizerTankSigma  = sigma;
opts.OxidizerTankSafetyMargin = combustionState.opts.OxidizerTankSafetyMargin;

[density, sigma] = combustionChamberMaterialProperties()

opts.ccDensity  = density;
opts.ccSigma  = sigma;
opts.ccSafetyMargin = combustionState.opts.ccCombustionPressureSafetyMargin;