
% Carbon additive impacts on fuel density
opts.FuelGrainDensity = opts.FuelDensity * (1 - opts.CarbonAdditiveFraction) + opts.CarbonDensity * opts.CarbonAdditiveFraction;

opts.FuelVolume = (opts.ccDiameter/2)^2 * pi - opts.initialPortRadius^2 * pi * opts.PortLength;
opts.FuelMass = opts.FuelVolume * opts.FuelGrainDensity;

opts.PropellantMass = opts.FuelMass * (1 + opts.DesignOFRatio);
opts.OxidizerMass = opts.PropellantMass * opts.DesignOFRatio / (opts.DesignOFRatio + 1);
opts.OxidizerVolume = opts.OxidizerMass / opts.OxidizerDensity;

opts.InjectorsArea = pi*(opts.InjectorsDiameter/2)^2 * opts.NumberOfInjectors;