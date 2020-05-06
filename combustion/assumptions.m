% This file is run in combustionSimulationAssumptions.m
% Do not run this file as it is.
%
% This file contains assumptions for the combustion simulation of the Eyjafjallaj??kull hybrid rocket engine.

%% Tank assumptions

% ambient conditions (define somewhere else?)
opts.AmbientPressure = 101325;
opts.AmbientTemperature = 293.15;

% initital conditions: CHECK TEMPERATURE!!! tankInititalOxidizerTemperature
% a) fluid properties

opts.OxidizerTemperature = 293.15;

run("../physicalDesign/assumptions.m"); % lol
opts.tankDiameterInCm = opts.OxidizerTankDiameterInCm

% b) tank properties
opts.tankInititalWallTemperature = opts.AmbientTemperature;

% tank material properties (check if to define here or somewhere else!!!)

%% Combustion assumptions

% [oxidizerDensity, oxidizerVaporPressure, fuelDensity, carbonAdditiveDensity] = propellantProperties();
[fuelDensity, carbonAdditiveDensity] = fuelProperties();

% Alex: density became a derived property and tank pressure is output of
% coolprop (see above)
% opts.OxidizerDensity = oxidizerDensity; 
% opts.OxidizerTankPressure = oxidizerVaporPressure; % Initial tank pressure
opts.OxidizerTankSafetyMargin = 1.5;
opts.OxidizerTankPressureDrop = 0.4; % Factor to drop oxidizer tank pressure linearly
opts.CarbonAdditiveFraction = 0.01; % Fraction of carbon in the fuel grain
opts.DesignOFRatio = 8; % The OF ratio used to size the oxidizer tank


opts.ccCombustionPressure = 4.5e6;  % Estimation of combustion chamber pressure - used as design pressure
opts.ccCombustionPressureSafetyMargin = 1.5;
opts.ccInitialPressure = 101325;

opts.FuelDensity = fuelDensity;
opts.CarbonDensity = carbonAdditiveDensity;

opts.CombustionChamberDiameterInCm = 15; % External diameter
opts.CombustionChamberSinusShapeAmplitude = 1/10;   % Proportion of initial port radius
opts.CombustionChamberWallThicknessInMm = 3;
opts.FuelGrainContainerWallThicknessInMm = 2;
opts.FuelGrainContainerDensity = 500;

opts.FuelGrainLengthInCm = 30;
opts.FuelGrainInitialPortRadiusInCm = 2.5;

opts.UnusableFuelMarginThicknessInCm = 0.5;

[gamma, productsMolecularWeight] = combustionProperties();
opts.Gamma = gamma;
opts.ProductsMolecularWeight = productsMolecularWeight;

[dischargeCoefficient, holeDiameterMm] = injectorProperties();
opts.InjectorsCd = dischargeCoefficient;
opts.InjectorsDiameter = holeDiameterMm / 1e3;
opts.NumberOfInjectors = 20;

opts.CombustionEfficiency = 0.9;

