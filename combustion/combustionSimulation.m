function combustionState = combustionSimulation(opts, nozzleState, tankModel)
addpath('./combustion/models');
addpath('./combustion/properties');
addpath('./combustion/system');
addpath('./physicalDesign/models');
run("./combustion/derivedProperties");

opts.input = struct( ...
    "nozzleState", nozzleState ...
    );

tol = 1e-4;
T = 50;

opts.extraOutput = 0;
model = @(t, y) tank_combustionOdeSystem(t, y, tankModel, opts);

if tankModel ~= 2
% set up combustion simulation
initialState = [...
opts.FuelMass,...
opts.FuelGrainInitialPortRadius,...
opts.ccInitialPressure];
if tankModel == 1
    % add tank simulation
    initialState = [initialState,...
        opts.tankInititalWallTemperature,...
        opts.tankInititalWallTemperature,...
        opts.OxidizerInternalEnergy];
end
initialState = [initialState, opts.OxidizerMass];
odeOpts = odeset('Events', @tank_combustionOdeSystemEvents, 'Stats', 'on', 'RelTol', tol, 'AbsTol', tol);
sol = ode45(model, [0 T], initialState, odeOpts);

else
    % tank draining simulation
    initialState_tank = [...
        opts.tankInititalWallTemperature,...
        opts.tankInititalWallTemperature,...
        opts.OxidizerInternalEnergy,...
        opts.OxidizerMass];
    odeOpts = odeset('Events', @tankOdeSystemEvents, 'Stats', 'on', 'RelTol', tol, 'AbsTol', tol);
    sol = ode45(model, [0 T], initialState_tank, odeOpts);
end

t = sol.x;
te = sol.xe;

fprintf("ODE solving done. reducing results\n");
opts.extraOutput = 1;
model = @(t, y) tank_combustionOdeSystem(t, y, tankModel, opts); % need to set this to get thrust...

if isempty(te)
    burnTime = max(t);
else
    burnTime = te(1);
end

t = linspace(0, burnTime, 1000);
state = deval(sol, t)';

oxidizerMass = state(:, end);
fuelMass = state(:, 1);
portRadius = state(:, 2);
ccPressure = state(:, 3);

propellantMass = oxidizerMass + fuelMass;

N = length(t);
fuelMassFlow = zeros(N,1);
regressionRate = zeros(N,1);
tankWallTemperatureGradientLNode = zeros(N,1);
tankWallTemperatureGradientGNode = zeros(N,1);
tankInternalEnergyGradient = zeros(N,1);
ccPressureVariation = zeros(N,1);
oxidizerMassFlow = zeros(N,1);
thrust = zeros(N,1);
exhaustMach = zeros(N,1);
exhaustPressure = zeros(N,1);
thrustCoefficient = zeros(N,1);
ccTemperature = zeros(N,1);
tankPressure = zeros(N,1);
oxidizerTemperature = zeros(N,1);
wallTemperatureLNode = zeros(N,1);
wallTemperatureGNode = zeros(N,1);
global tankTemperature
tankTemperature = opts.OxidizerTemperature;
for i = 1:N
    [~, fuelMassFlow(i),regressionRate(i),ccPressureVariation(i),tankWallTemperatureGradientLNode(i),tankWallTemperatureGradientGNode(i),tankInternalEnergyGradient(i),oxidizerMassFlow(i),thrust(i), exhaustMach(i), exhaustPressure(i), thrustCoefficient(i), ccTemperature(i),tankPressure(i),oxidizerTemperature(i),wallTemperatureLNode(i),wallTemperatureGNode(i)] = model(t(i),state(i, :)');
end
%%
combustionState = struct();
combustionState.opts = opts;
combustionState.time = t;
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
combustionState.idealThrust = thrust;
combustionState.thrust = thrust * opts.ThrustEfficiency;
combustionState.exhaustMach = exhaustMach;
combustionState.exhaustPressure = exhaustPressure;
combustionState.thrustCoefficient = thrustCoefficient;
combustionState.ccTemperature = ccTemperature;
combustionState.tankPressure = tankPressure;
combustionState.oxidizerTemperature = oxidizerTemperature;
combustionState.wallTemperatureLNode = wallTemperatureLNode;
combustionState.wallTemperatureGNode = wallTemperatureGNode;
end