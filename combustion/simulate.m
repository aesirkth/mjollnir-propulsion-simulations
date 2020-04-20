clear
path(pathdef);

addpath('./models');
addpath('./properties');
addpath('./system');
addpath('../plotting');

setPlotMode("show");
% setPlotMode("store");

opts = struct()
run("./assumptions");
run("../nozzle/assumptions");

model = @(t, y) odeSystem(t, y, opts);
initialState = [opts.OxidizerMass, opts.FuelMass, opts.initialPortRadius, opts.ccInitialPressure];
odeOpts = odeset('Events', @odeSystemEvents, 'RelTol', 1e-8, 'AbsTol', 1e-8);
[t, state,te,ye,ie] = ode45(model, [0 50], initialState, odeOpts);

burnTime = te(1);

oxidizerMass = state(:, 1);
fuelMass = state(:, 2);
portRadius = state(:, 3);
ccPressure = state(:, 4);

%% 
run("./createPlots");