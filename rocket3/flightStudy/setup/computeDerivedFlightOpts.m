function opts = computeDerivedFlightOpts(opts)
    ofRatio = 4;
    
    % Material properties from: https://www.nedal.com/wp-content/uploads/2016/11/Nedal-alloy-Datasheet-EN-AW-6082.pdf
    opts.OxidizerTankPressure = 5e6;
    opts.OxidizerTankDiameter = 0.075;
    opts.OxidizerTankDensity  = 2700;
    opts.OxidizerTankSigma  = 290*10e6/2;   % allowable stress: half of transile strength (assumption)
    opts.OxidizerTankSafetyMargin = 1.5;
    opts.ccCombustionPressure = 4.5e6;
    opts.ccDiameter = 0.075;
    opts.ccDensity  = 2700;
    opts.ccSigma  = 290*10e6/2;             % allowable stress: half of transile strength (assumption)
    opts.ccSafetyMargin = 1.5;
    
    opts.OxidizerMass = opts.PropellantMass * ofRatio / (ofRatio + 1);
    opts.FuelMass = opts.PropellantMass * (1) / (ofRatio + 1);
    
    opts.OxidizerVolume = opts.OxidizerMass / 770;
    opts.FuelVolume = opts.FuelMass / 900;
    
    % Define capsuleTank: capsuleTank(Volume, Diameter, Pressure, Sigma, rho, safety margin);
    [oxTankMass, oxTankLength, oxTankWallThickness, oxTankMassCheck, oxTankWallThicknessCheck] = capsuleTank(opts.OxidizerVolume, opts.OxidizerTankDiameter, opts.OxidizerTankPressure, opts.OxidizerTankSigma, opts.OxidizerTankDensity, opts.OxidizerTankSafetyMargin);
    [ccMass, ccLength, ccWallThickness, ccMassCheck, ccWallThicknessCheck] = capsuleTank(opts.FuelVolume, opts.ccDiameter, opts.ccCombustionPressure, opts.ccSigma, opts.ccDensity, opts.ccSafetyMargin);
    
    opts.OxidizerTankMass = oxTankMass;
    opts.OxidizerTankMassCheck = oxTankMassCheck;
    opts.OxidizerTankLength = oxTankLength;    
    opts.OxidizerTankWallThickness = oxTankWallThickness;
    opts.OxidizerTankWallThicknessCheck = oxTankWallThicknessCheck;
    opts.FuelGrainLength = ccLength;
    opts.ccWallThickness = ccWallThickness;
    opts.ccWallThicknessCheck = ccWallThicknessCheck;    
   
    engineMass = 6;
    dryMass = opts.PayloadMass + oxTankMass + ccMass + engineMass;
    wetMass = opts.PropellantMass + dryMass;
    
    
    opts.CombustionChamberMassIsh = ccMass;
    opts.CombustionChamberMassIshCheck = ccMassCheck;
    opts.EngineMass = engineMass;
    
    opts.WetMass = wetMass;
    opts.DryMass = dryMass;
    
    % opts.PropellantMass = opts.WetMass - opts.DryMass;
    opts.BurnTime = opts.PropellantMass / opts.MassFlow;
    opts.ExhaustArea = (opts.ExhaustDiameter / 2)^2*pi;
    opts.Thrust = 9.80665 * opts.Isp * opts.MassFlow;
end
