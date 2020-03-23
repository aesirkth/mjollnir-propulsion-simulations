function opts = computeDerivedFlightOpts(opts)
    
    % Get input parameters
    run 'capsuleTank_data_input.m'
    
    opts.OxidizerMass = opts.PropellantMass * ofRatio / (ofRatio + 1);
    opts.FuelMass = opts.PropellantMass * (1) / (ofRatio + 1);
    
    opts.OxidizerVolume = opts.OxidizerMass / opts.OxidizerDensity;
    opts.FuelVolume = opts.FuelMass / opts.FuelDensity;
    
    % Define capsuleTank: capsuleTank(Volume, Diameter, Pressure, Sigma (allowable stress), rho, safety margin);
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
