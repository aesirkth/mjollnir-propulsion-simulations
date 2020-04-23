% This file is run in physicalDesignSimulation.m
% Do not run this file as it is.
%
% This file contains assumptions for the physical design simulation of the Eyjafjallajökull hybrid rocket engine.

opts.RocketExternalDiameterInCm = 15;

[density, sigma] = oxidizerTankMaterialProperties()

opts.ExtraVolumeFactor = 0.1; % Factor of "extra" volume added to the oxidizer tank
opts.OxidizerTankDiameterInCm = opts.RocketExternalDiameterInCm;
opts.OxidizerTankDensity  = density;
opts.OxidizerTankSigma  = sigma;

[density, sigma] = combustionChamberMaterialProperties()

opts.ccDensity  = density;
opts.ccSigma  = sigma;