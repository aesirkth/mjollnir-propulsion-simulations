[oxidizerDensity, oxidizerVaporPressure, fuelDensity, carbonAdditiveDensity] = propellantProperties();

opts.OxidizerTankPressure = 5e6;        % Initial tank pressure

opts.ParafinDensity = fuelDensity;
opts.CarbonDensity = carbonAdditiveDensity;

opts.carbonAdditiveFraction = 0.01; % Fraction of carbon in the fuel grain
opts.ccDiameter = 0.075;
opts.PortLength = 0.3;                  % Port length
opts.initialPortRadius = 0.032;          % Initial port radius

opts.ccCombustionPressure = 4.5e6;  % Estimation of combustion chamber pressure
opts.Gamma = 1.4;
opts.ProductsMolecularWeight = 29e-3;

[dischargeCoefficient, holeDiameterMm] = injectorProperties()

opts.InjectorsCd = dischargeCoefficient;
opts.InjectorsDiameter = holeDiameterMm / 1e3;
opts.NumberOfInjectors = 20;
opts.InjectorsArea = pi*opts.InjectorsDiameter^2/4*opts.NumberOfInjectors;