% This file is where one can run single simulation that plots in greater detail


setup();
run assumptions


flightOpts = computeDerivedFlightOpts(struct( ...
    'PayloadMass', payloadMass, ...
    'PropellantMass', propellantMass, ...
    'Radius', (rocketDiameterInCentimeters/100)/2, ...
    'ExhaustDiameter', diameterOfNozzleExhaustInCentimeters / 100, ...
    'LaunchAngle', launchAngle ...
))

%%
model = @(t, y) flightModel(t, y, flightOpts);
r0 = [0 0]; V0 = [0 0];
initialState = [r0 V0 flightOpts.OxidizerMass flightOpts.FuelMass flightOpts.initialPortRadius,flightOpts.ccInitialPressure];
odeOpts = odeset('Events', @flightModelEvents, 'RelTol', 1e-8, 'AbsTol', 1e-8);
disp('Computing ...')
Start = cputime();
[t, State,te,ye,ie] = ode45(model, [0 500], initialState, odeOpts);
End = cputime();
Duration = End - Start;
disp(['Computation done ! Duration : ' num2str(Duration) ' s'])
disp('Plotting results ...')
plotSingleSimulation(flightOpts, t, State,te);
