function opts = computeDerivedFlightOpts(opts)
    ofRatio = 4;
    
    tankPressure = 5e6;
    combustionPressure = 4.5e6;
    
    opts.OxidizerMass = opts.PropellantMass * ofRatio / (ofRatio + 1);
    opts.FuelMass = opts.PropellantMass * (1) / (ofRatio + 1);
    
    opts.OxidizerVolume = opts.OxidizerMass / 770;
    opts.FuelVolume = opts.FuelMass / 900;
    
    [oxTankMass, oxTankLength] = capsuleTank(opts.OxidizerVolume, 0.075, tankPressure, 1.35e-5);
    [ccMass, ccLength] = capsuleTank(opts.FuelVolume, 0.075, combustionPressure, 1.35e-5);
    
    opts.OxidizerTankLength = oxTankLength;
    opts.FuelGrainLength = ccLength;
    
    engineMass = 6;
    dryMass = opts.PayloadMass + oxTankMass + ccMass + engineMass;
    wetMass = opts.PropellantMass + dryMass;
    
    opts.OxidizerTankMass = oxTankMass;
    opts.CombustionChamberMassIsh = ccMass;
    opts.EngineMass = engineMass;
    
    opts.WetMass = wetMass;
    opts.DryMass = dryMass;
    
    % opts.PropellantMass = opts.WetMass - opts.DryMass;
    opts.BurnTime = opts.PropellantMass / opts.MassFlow;
    opts.ExhaustArea = (opts.ExhaustDiameter / 2)^2*pi;
    opts.Thrust = 9.80665 * opts.Isp * opts.MassFlow;
end
