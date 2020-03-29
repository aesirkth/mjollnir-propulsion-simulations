% opts is an object of the shape:
% (
%     'OxidizerFuelRatio', [1]
%     'ParachuteMass', [kg]
%     'ElectronicsMass', [kg]
%     'BodyTubeMass', [kg]
%     'PayloadMass', [kg]
%     'PropellantMass', [kg]
%     'TankPressure', [Pa] // Pressure in oxidizer tank
%     'CombustionPressure', [Pa] // Combustion pressure
%     'Radius', [m] // Radius of rocket
%     'FuelGrainRadius', [m] // Radius of fuel grain
%     'ExpansionPressure', [Pa] // Pressure which nozzle expands to
%     'ExhaustDiameter', [m] // Diameter at nozzle exit
%     'Isp', [s] // Isp of engine 
%     'MassFlow', [kg/s] // Total mass flow
%     'LaunchAngle', [degrees] // Launch angle
% )

function opts = computeDerivedFlightOpts(opts)
    opts.NonEngineDryMass = opts.ParachuteMass + opts.ElectronicsMass + opts.BodyTubeMass + opts.PayloadMass;

    [oxidizerDensity, oxidizerVaporPressure, fuelDensity] = propellantProperties();
    

    % Set propellant parameters
    opts.OxidizerDensity = oxidizerDensity;
    opts.FuelDensity = fuelDensity;
    
    opts.OxidizerMass = opts.PropellantMass * opts.OxidizerFuelRatio / (opts.OxidizerFuelRatio + 1);
    opts.FuelMass = opts.PropellantMass * (1) / (opts.OxidizerFuelRatio + 1);
    
    opts.OxidizerVolume = opts.OxidizerMass / opts.OxidizerDensity;
    opts.FuelVolume = opts.FuelMass / opts.FuelDensity;
    
    if opts.TankPressure < oxidizerVaporPressure
        error("opts.TankPressure < oxidizerVaporPressure");
    end
    
    opts.CombustionPressure = 4.5e6;
    
    % Oxidizer tank parameters
    [otDensity, otSigma, otSafetyMargin] = oxidizerTankMaterialProperties();
    opts.OxidizerTankPressure = oxidizerVaporPressure;
    opts.OxidizerTankRadius = opts.Radius;
    opts.OxidizerTankDiameter = opts.Radius*2;
    opts.OxidizerTankDensity  = otDensity;
    opts.OxidizerTankSigma  = otSigma;
    opts.OxidizerTankSafetyMargin = otSafetyMargin;
    
    % Combustion chamber parameters
    [ccDensity, ccSigma, ccSafetyMargin] = combustionChamberMaterialProperties();
    opts.CombustionChamberPressure = opts.CombustionPressure;
    opts.CombustionChamberRadius = opts.FuelGrainRadius;
    opts.CombustionChamberDiameter = opts.FuelGrainRadius*2;
    opts.CombustionChamberDensity  = ccDensity;
    opts.CombustionChamberSigma  = ccSigma;
    opts.CombustionChamberSafetyMargin = ccSafetyMargin;
    
    % Model the oxidizer tank
    [oxTankMass, oxTankLength, oxTankWallThickness, oxTankMassCheck, oxTankWallThicknessCheck] = ...
        capsuleTank(opts.OxidizerVolume, opts.OxidizerTankRadius, opts.OxidizerTankPressure, opts.OxidizerTankSigma, opts.OxidizerTankDensity, opts.OxidizerTankSafetyMargin);
    opts.OxidizerTankMass = oxTankMass;
    opts.OxidizerTankMassCheck = oxTankMassCheck;
    opts.OxidizerTankLength = oxTankLength;    
    opts.OxidizerTankWallThickness = oxTankWallThickness;
    opts.OxidizerTankWallThicknessCheck = oxTankWallThicknessCheck;
    
    % Model the combustion chamber
     [ccMass, ccLength, ccWallThickness, ccMassCheck, ccWallThicknessCheck] = ...
        capsuleTank(opts.FuelVolume, opts.CombustionChamberRadius, opts.CombustionChamberPressure, opts.CombustionChamberSigma, opts.CombustionChamberDensity, opts.CombustionChamberSafetyMargin);
    
    opts.FuelGrainLength = ccLength;
    opts.CombustionChamberLength = ccLength;
    opts.CombustionChamberMass = ccMass;
    opts.CombustionChamberMassCheck = ccMassCheck;
    opts.CombustionChamberWallThickness = ccWallThickness;
    opts.CombustionChamberWallThicknessCheck = ccWallThicknessCheck;    
   
    % Compute mass properties
    opts.FixedEngineMass = 7;
    engineMass = opts.FixedEngineMass + ccMass;
    dryMass = opts.NonEngineDryMass + oxTankMass + ccMass + engineMass;
    wetMass = opts.PropellantMass + dryMass;
    
    opts.EngineMass = engineMass;
    opts.WetMass = wetMass;
    opts.DryMass = dryMass;
    
    % opts.PropellantMass = opts.WetMass - opts.DryMass;
    opts.BurnTime = opts.PropellantMass / opts.MassFlow;
    opts.ExhaustArea = (opts.ExhaustDiameter / 2)^2*pi;
    opts.Thrust = 9.80665 * opts.Isp * opts.MassFlow;
end
