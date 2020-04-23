function flightState = flightSimulation(opts, nozzleState, combustionState, physicalDesignState)
  addpath('./flight/models');
  addpath('./flight/system');
  
  opts.input = struct( ...
    "nozzleState", nozzleState, ...
    "combustionState", combustionState, ...
    "physicalDesignState", physicalDesignState ...
  );

  run("./flight/derivedProperties");

  model = @(t, y) flightOdeSystem(t, y, opts);
  r0 = [0 0]; 
  V0 = [0 0];

  initialState = [r0 V0];
  odeOpts = odeset('Events', @flightOdeSystemEvents, 'RelTol', 1e-8, 'AbsTol', 1e-8);
  [t, state, te, ye, ie] = ode45(model, [0 500], initialState, odeOpts);

  flightState = struct();
  flightState.opts = opts;

  N = length(t);
  thrustFactor = zeros(N,1);
  pressureThrustFactor = zeros(N,1);
  massFlowThrustFactor = zeros(N,1);
  mass = zeros(N,1);
  acceleration = zeros(N,2);
  dragFactor = zeros(N,1);
  for i = 1:N
    [dXdt, thrustFactor(i), dragFactor(i), massFlowThrustFactor(i), pressureThrustFactor(i), mass(i)] = flightOdeSystem(t(i), state(i,:)', opts);
    acceleration(i,:) = dXdt(3:4);
  end

  massFlow = abs(movmean(gradient(mass, t), 5));

  exhaustVelocity = zeros(N,1);
  for i = 1:N
    if massFlow(i) < max(massFlow)/6
      continue;
    end
    exhaustVelocity(i) = thrustFactor(i) / massFlow(i);
  end
  exhaustVelocity;
  specificImpulse = exhaustVelocity ./ 9.8066;

  exhaustVelocity = movmean(exhaustVelocity, 5);
  specificImpulse = movmean(specificImpulse, 5);

  flightState.time = t;
  flightState.position = state(:, 1:2);
  flightState.downrangeDistance = state(:, 1);
  flightState.altitude = state(:, 2);
  [ambientDensity,ambientPressure,speedOfSound] = atmosphereModel(flightState.altitude);
  flightState.velocity = state(:, 3:4);
  flightState.velocityNorm = vecnorm(state(:, 3:4)')';
  flightState.speedOfSound = speedOfSound;
  flightState.ambientDensity = ambientDensity;
  flightState.ambientPressure = ambientPressure;
  flightState.acceleration = acceleration;
  flightState.accelerationNorm = vecnorm(acceleration')';
  flightState.mach = flightState.velocityNorm ./ speedOfSound';
  flightState.thrust = thrustFactor;
  flightState.drag = dragFactor;
  flightState.pressureThrust = pressureThrustFactor;
  flightState.mass = mass;
  flightState.ballisticFlightTime = te(1);
  flightState.maximumAltitudeInKm = max(flightState.altitude) / 1e3;
  flightState.maximumVelocity = max(flightState.velocityNorm);
  flightState.maximumAcceleration = max(flightState.accelerationNorm);
  flightState.maximumMach = max(flightState.mach);
  flightState.massFlow = massFlow;
  flightState.exhaustVelocity = exhaustVelocity;
  flightState.specificImpulse = specificImpulse;
  flightState.dryMass = opts.dryMass;
  flightState.wetMass = opts.wetMass;
  flightState.propellantMass = mass - opts.dryMass;
end