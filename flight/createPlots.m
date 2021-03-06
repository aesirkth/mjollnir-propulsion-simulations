setupSubplots(4,3)
nextPlot('');

r = flightState.position;
t = flightState.time;
altitude = flightState.altitude;
vMag = flightState.velocityNorm;
mach = flightState.mach;
acceleration = flightState.accelerationNorm;
drag = flightState.drag;
propellantMass = flightState.propellantMass;
massFlow = flightState.massFlow;
thrust = flightState.thrust;
pressureThrust = flightState.pressureThrust;
specificImpulse = flightState.specificImpulse;

burnoutTime = flightState.opts.input.combustionState.burnTime;
burnOutIndex = find(t-burnoutTime>0);
burnOutIndex = burnOutIndex(1);
[~, apogeeIndex] = max(altitude);


hold on
lims = [min(r(:,1)/1e3) max(r(:,1)/1e3)];
xlim(lims);
plot(lims, [1 1] * flightState.opts.goalAltitude, '-m', 'LineWidth', 2, 'DisplayName', sprintf("%.0f km", flightState.opts.goalAltitude))
plot(lims, [1 1] * flightState.opts.excessiveGoalAltitude, '--r', 'LineWidth', 2, 'DisplayName', sprintf("%.0f km", flightState.opts.excessiveGoalAltitude))

plot(r(:,1)/1e3, r(:,2)/1e3, '-', 'LineWidth', 2, 'HandleVisibility','off')
plot(r(1,1)/1e3, r(1,2)/1e3, '*', 'DisplayName', 'Initial')
plot(r(apogeeIndex,1)/1e3, r(apogeeIndex,2)/1e3, 'b*', 'DisplayName', 'Apogee')
plot(r(burnOutIndex,1)/1e3, r(burnOutIndex,2)/1e3, 'ro', 'DisplayName', 'Burnout')

xlabel("Downrange [km]");
ylabel("Altitude [km]");
title("2D trajectory");
legend('show', 'Location', 'best');
grid on
scaleLims(0.1);
nextPlot([filepath filesep "trajectory"]);

hold on
lims = [min(t) max(t)];
xlim(lims);
plot(lims, [1 1] * flightState.opts.goalAltitude, '-m', 'LineWidth', 2, 'DisplayName', sprintf("%.0f km", flightState.opts.goalAltitude))
plot(lims, [1 1] * flightState.opts.excessiveGoalAltitude, '--r', 'LineWidth', 2, 'DisplayName', sprintf("%.0f km", flightState.opts.excessiveGoalAltitude))

plot(t, altitude/1e3, 'LineWidth', 2, 'HandleVisibility','off');
plot(t(apogeeIndex), altitude(apogeeIndex)/1e3, 'b*', 'DisplayName', 'Apogee')
plot(t(burnOutIndex), altitude(burnOutIndex)/1e3, 'ro', 'DisplayName', 'Burnout')

xlabel("Time [s]");
ylabel("Altitude [km]");
title("Altitude over time");
legend('show', 'Location', 'best');
grid on
scaleLims(0.1);
nextPlot([filepath filesep "altitudeOverTime"]);

plot(t, vMag, 'LineWidth', 2, 'HandleVisibility','off');
hold on
plot(t(apogeeIndex), vMag(apogeeIndex), 'b*', 'DisplayName', 'Apogee')
plot(t(burnOutIndex), vMag(burnOutIndex), 'ro', 'DisplayName', 'Burnout')
xlabel("Time [s]");
ylabel("Velocity [m/s]");
title("Velocity over time");
legend('show', 'Location', 'best');
grid on
scaleLims(0.1);
nextPlot([filepath filesep "vMagOverTime"]);

plot(t, mach, 'LineWidth', 2, 'HandleVisibility','off');
hold on
plot(t(apogeeIndex), mach(apogeeIndex), 'b*', 'DisplayName', 'Apogee')
plot(t(burnOutIndex), mach(burnOutIndex), 'ro', 'DisplayName', 'Burnout')
xlabel("Time [s]");
ylabel("Mach");
title("Mach over time");
legend('show', 'Location', 'best');
grid on
scaleLims(0.1);
nextPlot([filepath filesep "machOverTime"]);

plot(altitude / 1000, mach, 'LineWidth', 2, 'HandleVisibility','off');
hold on
plot(altitude(apogeeIndex) / 1000, mach(apogeeIndex), 'b*', 'DisplayName', 'Apogee')
plot(altitude(burnOutIndex) / 1000, mach(burnOutIndex), 'ro', 'DisplayName', 'Burnout')
xlabel("Altitude [km]");
ylabel("Mach");
title("Mach over altitude");
legend('show', 'Location', 'best');
grid on
scaleLims(0.1);
nextPlot([filepath filesep "machOverAltitude"]);

plot(altitude / 1000, vMag, 'LineWidth', 2, 'HandleVisibility','off')
hold on
plot(altitude(1) / 1000, vMag(1), '*', 'DisplayName', 'Initial')
plot(altitude(apogeeIndex) / 1000, vMag(apogeeIndex), 'b*', 'DisplayName', 'Apogee')
plot(altitude(burnOutIndex) / 1000, vMag(burnOutIndex), 'ro', 'DisplayName', 'Burnout')
xlabel("Altitude [km]");
ylabel("Velocity [m/s]");
title("Velocity as function of altitude");
legend('show', 'Location', 'best');
grid on
scaleLims(0.1);
nextPlot([filepath filesep "velocityOverAltitude"]);


plot(t, abs(acceleration)/9.8066, 'LineWidth', 2, 'HandleVisibility','off');
hold on
plot(t(apogeeIndex), abs(acceleration(apogeeIndex))/9.8066, 'b*', 'DisplayName', 'Apogee')
plot(t(burnOutIndex), abs(acceleration(burnOutIndex))/9.8066, 'ro', 'DisplayName', 'Burnout')
xlabel("Time [s]");
ylabel("Acceleration [g]");
title("Acceleration over time");
legend('show', 'Location', 'best');
grid on
scaleLims(0.1);
nextPlot([filepath filesep "accelerationOverTime"]);

% mass = massModel(t, flightOpts.DryMass, propellantMass);
plot(t, drag, 'LineWidth', 2, 'HandleVisibility','off');
hold on
plot(t(apogeeIndex), drag(apogeeIndex), 'b*', 'DisplayName', 'Apogee')
plot(t(burnOutIndex), drag(burnOutIndex), 'ro', 'DisplayName', 'Burnout')
xlabel("Time [s]");
ylabel("Drag [N]");
title("Drag over time");
legend('show', 'Location', 'best');
grid on
scaleLims(0.1);
nextPlot([filepath filesep "dragOverTime"]);

plot(altitude / 1000, drag, 'LineWidth', 2, 'HandleVisibility','off')
hold on
plot(altitude(1) / 1000, drag(1), '*', 'DisplayName', 'Initial')
plot(altitude(apogeeIndex) / 1000, drag(apogeeIndex), 'b*', 'DisplayName', 'Apogee')
plot(altitude(burnOutIndex) / 1000, drag(burnOutIndex), 'ro', 'DisplayName', 'Burnout')
xlabel("Altitude [km]");
ylabel("Drag [N]");
title("Drag as function of altitude");
legend('show', 'Location', 'best');
grid on
scaleLims(0.1);
nextPlot([filepath filesep "dragOverAltitude"]);

plot(t, propellantMass, 'LineWidth', 2, 'HandleVisibility','off')
hold on
plot(t(apogeeIndex), propellantMass(apogeeIndex), 'b*', 'DisplayName', 'Apogee')
plot(t(burnOutIndex), propellantMass(burnOutIndex), 'ro', 'DisplayName', 'Burnout')
xlabel("Time [s]");
ylabel("Propellant mass [kg]");
title("Propellant mass over time");
legend('show', 'Location', 'best');
xlim([-1 t(apogeeIndex)+1]);
xticks([0 t(burnOutIndex) t(apogeeIndex)]);
grid on
scaleLims(0.1);
nextPlot([filepath filesep "propellantMassOverTime"]);

% plot(t, massFlow, 'LineWidth', 2, 'HandleVisibility','off')
% hold on
% plot(t(apogeeIndex), massFlow(apogeeIndex), 'b*', 'DisplayName', 'Apogee')
% plot(t(burnOutIndex), massFlow(burnOutIndex), 'ro', 'DisplayName', 'Burnout')
% xlabel("time [s]");
% xlim([-1 t(apogeeIndex)+1]);
% xticks([0 t(burnOutIndex) t(apogeeIndex)]);
% ylabel("propellant mass flow [kg/s]");
% title("Propellant mass flow over time");
% legend('show', 'Location', 'best');
% grid on
% scaleLims(0.1);
% nextPlot([filepath filesep "massFlowOverTime"]);

plot(t, thrust / 1e3, 'LineWidth', 2, 'HandleVisibility','off')
hold on
plot(t, pressureThrust / 1e3, '--', 'LineWidth', 2, 'DisplayName', 'Pressure component')
hold on
plot(t(apogeeIndex), thrust(apogeeIndex) / 1e3, 'b*', 'DisplayName', 'Apogee')
plot(t(burnOutIndex), thrust(burnOutIndex) / 1e3, 'ro', 'DisplayName', 'Burnout')
xlabel("Time [s]");
xlim([-1 t(apogeeIndex)+1]);
xticks([0 t(burnOutIndex) t(apogeeIndex)]);
ylabel("Thrust [kN]");
title("Thrust over time");
legend('show', 'Location', 'best');
grid on
scaleLims(0.1);
nextPlot([filepath filesep "thrustOverTime"]);

plot(t, specificImpulse, 'LineWidth', 2, 'HandleVisibility','off')
hold on
plot(t(apogeeIndex), specificImpulse(apogeeIndex), 'b*', 'DisplayName', 'Apogee')
plot(t(burnOutIndex), specificImpulse(burnOutIndex), 'ro', 'DisplayName', 'Burnout')
xlabel("Time [s]");
xlim([-1 t(apogeeIndex)+1]);
xticks([0 t(burnOutIndex) t(apogeeIndex)]);
ylabel("Specific impulse [s]");
title("Specific impulse over time");
legend('show', 'Location', 'best');
grid on
scaleLims(0.1);
nextPlot([filepath filesep "specificImpulseOverTime"]);