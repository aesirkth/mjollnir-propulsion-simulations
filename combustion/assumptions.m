[oxidizerDensity, oxidizerVaporPressure, fuelDensity, carbonAdditiveDensity] = propellantProperties();

opts.OxidizerDensity = oxidizerDensity;
opts.OxidizerTankPressure = oxidizerVaporPressure; % Initial tank pressure
opts.OxidizerTankPressureDrop = 0.2; % Factor to drop oxidizer tank pressure linearly
opts.carbonAdditiveFraction = 0.01; % Fraction of carbon in the fuel grain
opts.DesignOFRatio = 8; % The OF ratio used to size the oxidizer tank

opts.ccCombustionPressure = 4.5e6;  % Estimation of combustion chamber pressure - used as design pressure
opts.ccInitialPressure = 101325;

opts.ParafinDensity = fuelDensity;
opts.CarbonDensity = carbonAdditiveDensity;

% Carbon additive impacts on fuel density
opts.FuelDensity = opts.ParafinDensity * (1 - opts.carbonAdditiveFraction) + opts.CarbonDensity * opts.carbonAdditiveFraction;

opts.ccDiameter = 0.075;
opts.PortLength = 0.3;                  % Port length
opts.initialPortRadius = 0.032;          % Initial port radius

opts.FuelVolume = (opts.ccDiameter/2)^2 * pi - opts.initialPortRadius^2 * pi * opts.PortLength;
opts.FuelMass = opts.FuelVolume * opts.FuelDensity;

opts.PropellantMass = opts.FuelMass * (1 + opts.DesignOFRatio);
opts.OxidizerMass = opts.PropellantMass * opts.DesignOFRatio / (opts.DesignOFRatio + 1);
opts.OxidizerVolume = opts.OxidizerMass / opts.OxidizerDensity;

[gamma, productsMolecularWeight] = combustionProperties()
opts.Gamma = gamma;
opts.ProductsMolecularWeight = productsMolecularWeight;

[dischargeCoefficient, holeDiameterMm, numberOfHoles] = injectorProperties()
opts.InjectorsCd = dischargeCoefficient;
opts.InjectorsDiameter = holeDiameterMm / 1e3;
opts.NumberOfInjectors = numberOfHoles;
opts.InjectorsArea = pi*(opts.InjectorsDiameter/2)^2 * opts.NumberOfInjectors;

