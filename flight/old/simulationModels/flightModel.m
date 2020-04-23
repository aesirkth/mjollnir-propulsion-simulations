% The simulation system
function [dXdt,regressionRate,ccPressureVariation,oxidizerMassFlow,fuelMassFlow,thrustFactor,ccTemperature] = flightModel(t, X, opts)
    % X is of the form [positionX, positionY, velocityX, velocityY, oxidizerMass, fuelMass, ccPressure]
    r = X(1:2);
    v = X(3:4);
    oxidizerMass = X(5);
    fuelMass = X(6);
    propellantMass = oxidizerMass + fuelMass;
    portRadius = X(7);
    ccPressure = X(8);
    mass = massModel(t, opts.DryMass, propellantMass);
    
    % Recovering main body vector
    vMag = norm(v);
    vN = [cos(opts.LaunchAngle / 180 * pi) sin(opts.LaunchAngle / 180 * pi)]';
    if norm(r) > 12
        vN = v / vMag;
    end
    
    % Atmosphere data
    [ambientDensity, ambientPressure, speedOfSound] = atmosphereModel(r(2));
    
    % Combustion model
    [regressionRate,ccPressureVariation,oxidizerMassFlow,fuelMassFlow,cStar,ccTemperature] = combustionModel(t,portRadius,ccPressure,oxidizerMass,opts);
    
    % Computed mass flow
    massFlow = oxidizerMassFlow + fuelMassFlow;
    
    % Drag force
    Cd = dragCoefficientModel(vMag, speedOfSound);
    dragFactor = dragModel(vMag, ambientDensity, opts.Radius, Cd);
    drag = -vN * dragFactor;
    
    % Thrust Force
    thrustFactor = thrustModel(t, massFlow, ccPressure, ambientPressure, cStar, opts);
    gravityFactor = gravityModel(r(2)) * mass;
    thrust = vN * thrustFactor;
    
    % Weight
    gravity = [0;-1] * gravityFactor;
    
    % Newton's second law
    acceleration = (drag + thrust + gravity) / mass;
    
    % Returning differential vector
    dXdt = [v;acceleration;-oxidizerMassFlow;-fuelMassFlow;regressionRate;ccPressureVariation];
end

