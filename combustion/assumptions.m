[oxidizerDensity, oxidizerVaporPressure, fuelDensity, carbonAdditiveDensity] = propellantProperties();

opts.OxidizerDensity = oxidizerDensity;
opts.OxidizerTankPressure = oxidizerVaporPressure; % Initial tank pressure
opts.OxidizerTankPressureDrop = 0.15; % Factor to drop oxidizer tank pressure linearly
opts.CarbonAdditiveFraction = 0.01; % Fraction of carbon in the fuel grain
opts.DesignOFRatio = 8; % The OF ratio used to size the oxidizer tank

opts.ccCombustionPressure = 4.5e6;  % Estimation of combustion chamber pressure - used as design pressure
opts.ccInitialPressure = 101325;

opts.FuelDensity = fuelDensity;
opts.CarbonDensity = carbonAdditiveDensity;

opts.CombustionChamberDiameterInCm = 15; % External diameter
opts.CombustionChamberWallThicknessInMm = 3;
opts.FuelGrainContainerWallThicknessInMm = 2;

opts.FuelGrainLengthInCm = 30;
opts.FuelGrainInitialPortRadiusInCm = 3.2;

opts.UnusableFuelMarginThicknessInCm = 0.5;

[gamma, productsMolecularWeight] = combustionProperties()
opts.Gamma = gamma;
opts.ProductsMolecularWeight = productsMolecularWeight;

[dischargeCoefficient, holeDiameterMm] = injectorProperties();
opts.InjectorsCd = dischargeCoefficient;
opts.InjectorsDiameter = holeDiameterMm / 1e3;
opts.NumberOfInjectors = 20;