% This file is run in nozzleSimulationAssumptions.m
% Do not run this file as it is.
%
% This file contains assumptions for the nozzle simulation of the Eyjafjallaj??kull hybrid rocket engine.

%% oh no

[gamma, nozzleGamma, productsMolecularWeight, nozzleProductsMolecularWeight] = combustionProperties();

opts.NozzleDesignGamma = nozzleGamma;
opts.NozzleDesignMassFlow = 2.6;
opts.NozzleDesignCStar = 1600;

opts.NozzleDesignCombustionPressureInMpa = 3.5;
opts.NozzleExpansionPressureInAtmospheres = 1;

opts.NozzleEfficiency = 0.9; % multiplies thrust at the end...