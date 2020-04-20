addpath('./models');
addpath('./properties');
addpath('./system');
addpath('../plotting');


opts = struct()
run("./assumptions");
run("./derivedProperties");
run("../nozzle/assumptions");
run("../nozzle/derivedProperties");


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
for i = 1:N
  [~,regressionRate(i),ccPressureVariation(i),oxidizerMassFlow(i),fuelMassFlow(i),thrust(i),ccTemperature(i)] = model(t(i),state(i,:)');
end

%%
combustionState = struct(...
    'time', t, ...
    'opts', opts, ...
    'burnTime', burnTime, ...
    'residualFuelMass', fuelMass(end), ...
    'residualOxidizerMass', oxidizerMass(end), ...
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

%setPlotMode("save");
setPlotMode("show");
run("./createPlots");

combustionState