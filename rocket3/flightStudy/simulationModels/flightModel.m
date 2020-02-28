% The simulation system
function dXdt = flightModel(t, X, opts)
    % X is of the form [positionX, positionY, velocityX, velocityY, propellantMass]
    
    r = X(1:2);
    v = X(3:4);
    propellantMass = X(5);
    
    vMag = norm(v);
    vN = [cos(opts.LaunchAngle / 180 * pi); sin(opts.LaunchAngle / 180 * pi)];
    if norm(r) > 12
        vN = v / vMag;
    end
        
    [ambientDensity, ambientPressure, speedOfSound] = atmosphereModel(r(2));
    Cd = dragCoefficientModel(vMag, speedOfSound);
    
    mass = massModel(t, opts.DryMass, propellantMass);
    massFlow = massFlowModel(t, opts.BurnTime, opts.MassFlow, propellantMass);
    
    dragFactor = dragModel(vMag, ambientDensity, opts.Radius, Cd);
    thrustFactor = thrustModel(t, massFlow, ambientPressure, opts);
    gravityFactor = gravityModel(r(2)) * mass;
    
    drag = -vN * dragFactor;
    thrust = vN * thrustFactor;
    gravity = [0; -1] * gravityFactor;
    
    force = drag + thrust + gravity;
    acceleration = force / mass;
    
    dXdt = [v; acceleration; -massFlow];
end

