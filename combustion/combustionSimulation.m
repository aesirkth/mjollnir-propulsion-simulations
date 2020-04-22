function combustionState = combustionSimulation(opts, nozzleState)
  addpath('./combustion/models');
  addpath('./combustion/properties');
  addpath('./combustion/system');

  opts.input = struct( ...
    "nozzleState", nozzleState ...
  );

  run("./combustion/derivedProperties");

  model = @(t, y) odeSystem(t, y, opts);
  initialState = [opts.OxidizerMass, opts.FuelMass, opts.FuelGrainInitialPortRadius, opts.ccInitialPressure];
  odeOpts = odeset('Events', @odeSystemEvents, 'RelTol', 1e-8, 'AbsTol', 1e-8);
  [t, state,te,ye,ie] = ode45(model, [0 50], initialState, odeOpts);

  if isempty(te)
      burnTime = t;
  else
      burnTime = te(1);
  end
  oxidizerMass = state(:, 1);
  fuelMass = state(:, 2);
  portRadius = state(:, 3);
  ccPressure = state(:, 4);

  propellantMass = oxidizerMass + fuelMass;

  N = length(t);
  regressionRate = zeros(N,1);
  ccPressureVariation = zeros(N,1);
  oxidizerMassFlow = zeros(N,1);
  fuelMassFlow = zeros(N,1);
  thrust = zeros(N,1);
  ccTemperature = zeros(N,1);
  tankPressure = zeros(N,1);
  for i = 1:N
    [~,regressionRate(i),ccPressureVariation(i),oxidizerMassFlow(i),fuelMassFlow(i),thrust(i),ccTemperature(i),tankPressure(i)] = model(t(i),state(i,:)');
  end

  %%
  combustionState = struct();
  combustionState.time = t;
  combustionState.opts = opts;
  combustionState.burnTime = burnTime;
  combustionState.residualFuelMass = fuelMass(end);
  combustionState.residualOxidizerMass = oxidizerMass(end);
  combustionState.oxidizerMass = oxidizerMass;
  combustionState.fuelMass = fuelMass;
  combustionState.propellantMass = propellantMass;
  combustionState.portRadius = portRadius;
  combustionState.ccPressure = ccPressure;
  combustionState.regressionRate = regressionRate;
  combustionState.ccPressureVariation = ccPressureVariation;
  combustionState.oxidizerMassFlow = oxidizerMassFlow;
  combustionState.fuelMassFlow = fuelMassFlow;
  combustionState.thrust = thrust;
  combustionState.ccTemperature = ccTemperature;
  combustionState.tankPressure = tankPressure;
end