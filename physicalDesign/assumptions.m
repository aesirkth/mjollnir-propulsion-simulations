[density, sigma, safetyMargin] = oxidizerTankMaterialProperties()

opts.OxidizerTankDiameter = 0.075;
opts.OxidizerTankDensity  = density;
opts.OxidizerTankSigma  = sigma;
opts.OxidizerTankSafetyMargin = safetyMargin

[density, sigma, safetyMargin] = combustionChamberMaterialProperties()

opts.ccDensity  = density;
opts.ccSigma  = sigma;
opts.ccSafetyMargin = safetyMargin;
opts.ccInitialPressure = 101325;