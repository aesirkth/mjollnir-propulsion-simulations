addpath('./models');
addpath('./properties');
addpath('./system');
addpath('../plotting');

setPlotMode("show");
% setPlotMode("store");

opts = struct()
run("./assumptions");
run("./derivedProperties");
run("../nozzle/assumptions");
run("../nozzle/derivedProperties");

model = @(t, y) odeSystem(t, y, opts);
initialState = [opts.OxidizerMass, opts.FuelMass, opts.initialPortRadius, opts.ccInitialPressure];
odeOpts = odeset('Events', @odeSystemEvents, 'RelTol', 1e-8, 'AbsTol', 1e-8);
[t, state,te,ye,ie] = ode45(model, [0 50], initialState, odeOpts);

burnTime = te(1);
oxidizerMass = state(:, 1);
fuelMass = state(:, 2);
portRadius = state(:, 3);
ccPressure = state(:, 4);

propellantMass = oxidizerMass + fuelMass;

N = length(t);
regressionRate = zeros(1, N);
ccPressureVariation = zeros(1, N);
oxidizerMassFlow = zeros(1, N);
fuelMassFlow = zeros(1, N);
thrust = zeros(1, N);
ccTemperature = zeros(1, N);
for i = 1:N
  [~,regressionRate(i),ccPressureVariation(i),oxidizerMassFlow(i),fuelMassFlow(i),thrust(i),ccTemperature(i)] = model(t(i),state(i,:)');
end

combustionState = struct(...
    'time', t, ...
    'burnTime', burnTime, ...
    'oxidizerMass', oxidizerMass, ...
    'fuelMass', fuelMass, ...
    'propellantMass', propellantMass, ...
    'portRadius', portRadius, ...
    'ccPressure', ccPressure, ...
    'regressionRate', regressionRate, ...
    'ccPressureVariation', ccPressureVariation, ...
    'oxidizerMassFlow', oxidizerMassFlow, ...
    'fuelMassFlow', fuelMassFlow, ...
    'thrust', thrust, ...
    'ccTemperature', ccTemperature ...
);

clearvars -except combustionState
%%
figure(1);
run("./createPlots");