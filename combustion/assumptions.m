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

% b) tank properties
opts.tankInititalWallTemperature = opts.AmbientTemperature;

% tank material properties (check if to define here or somewhere else!!!)

opts.tankLength = 2 - 0.3216 - 0.0078953;
opts.tankDiameter = 0.15;
opts.tankThickness = 0.003;
opts.tankDensity = 2700;
opts.tankThermalConductivity = 195; % average value from datasheet (170-220) 
opts.tankSpecificHeat = 896 ; % https://www.leichtmetall.eu/site/assets/files/datenblatt/6082_Produktdatenblatt_A4-en_us.pdf

%% Combustion assumptions

% [oxidizerDensity, oxidizerVaporPressure, fuelDensity, carbonAdditiveDensity] = propellantProperties();
[fuelDensity, carbonAdditiveDensity] = fuelProperties();

% Alex: density became a derived property and tank pressure is output of
% coolprop (see above)
% opts.OxidizerDensity = oxidizerDensity; 
% opts.OxidizerTankPressure = oxidizerVaporPressure; % Initial tank pressure
opts.OxidizerTankSafetyMargin = 1.5;
opts.OxidizerTankPressureDrop = 0.15; % Factor to drop oxidizer tank pressure linearly
opts.CarbonAdditiveFraction = 0.01; % Fraction of carbon in the fuel grain
opts.DesignOFRatio = 8; % The OF ratio used to size the oxidizer tank


opts.ccCombustionPressure = 4.5e6;  % Estimation of combustion chamber pressure - used as design pressure
opts.ccCombustionPressureSafetyMargin = 1.5;
opts.ccInitialPressure = 101325;

opts.FuelDensity = fuelDensity;
opts.CarbonDensity = carbonAdditiveDensity;

opts.CombustionChamberDiameterInCm = 15; % External diameter
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

