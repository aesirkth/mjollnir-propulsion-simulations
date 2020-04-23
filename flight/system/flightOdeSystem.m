function [dXdt, thrustFactor, dragFactor, pressureThrustFactor, mass] = flightOdeSystem(t, X, opts)
  r = X(1:2);
  v = X(3:4);


  vMag = norm(v);
  % Simple model of the launch rail. If position is closer than the launch rail length, we assume to be on it with respect to direction.
  if norm(r) < opts.launchRailLength
    vN = [cos(opts.LaunchAngle / 180 * pi) sin(opts.LaunchAngle / 180 * pi)]';
  else
    vN = v / vMag;
  end

  % Atmosphere and physics data
  altitude = r(2);
  [ambientDensity, ambientPressure, speedOfSound] = atmosphereModel(altitude);
  Cd = dragCoefficientModel(vMag, speedOfSound);
  gravityAcceleration = gravityModel(altitude);

  % Current state of the rocket
  dryMass = opts.dryMass;
  propellantMass = opts.input.combustionState.propellantMass(end);

  thrustFactor = 0;
  pressureThrustFactor = 0;
  if t <= max(opts.input.combustionState.time)
    thrustFactor = interp1(opts.input.combustionState.time, opts.input.combustionState.thrust, t);
    propellantMass = interp1(opts.input.combustionState.time, opts.input.combustionState.propellantMass, t);

    pressureThrustFactor = opts.input.nozzleState.NozzleExhaustArea * (opts.input.nozzleState.NozzleExpansionPressure - ambientPressure);
  end

  mass = dryMass + propellantMass;
  
  dragFactor = dragModel(vMag, ambientDensity, opts.externalRadius, Cd);
  dragForce = -vN * dragFactor;

  gravityForce = [0;-1] * gravityAcceleration * mass;

  thrustForce = vN * (thrustFactor + pressureThrustFactor);
  
  acceleration = (dragForce + thrustForce + gravityForce) / mass;

  dXdt = [v; acceleration];
end