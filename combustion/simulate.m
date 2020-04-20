addpath('./models');
addpath('./properties');
addpath('./system');

opts = struct()
run("./assumptions");
run("../nozzle/assumptions");

model = @(t, y) odeSystem(t, y, opts);
initialState = [opts.OxidizerMass, opts.FuelMass, opts.initialPortRadius, opts.ccInitialPressure];
odeOpts = odeset('Events', @odeSystemEvents, 'RelTol', 1e-8, 'AbsTol', 1e-8);
[t, state,te,ye,ie] = ode45(model, [0 500], initialState, odeOpts);

oxidizerBurnoutTime = te(1)
fuelBurnoutTime = te(2)

oxidizerMass = state(:, 1);
fuelMass = state(:, 2);
portRadius = state(:, 3);
ccPressure = state(:, 4);

subplot(3,1,1);
plot(t, oxidizerMass)
hold on
plot(t, fuelMass)
xlim([0, burnTime*1.2])

subplot(3,1,2);
plot(t, portRadius)
xlim([0, burnTime*1.2])

subplot(3,1,3);
plot(t, ccPressure)
xlim([0, burnTime*1.2])