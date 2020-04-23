
setupSubplots(3, 3)

nextPlot("flight/physics/coefficientOfDrag");

mach = linspace(0, 20, 100);
Cd = dragCoefficientModel(mach*340, 340);

plot(mach, Cd, 'LineWidth', 2);
xlim([0, 5])
xlabel("Mach number");
ylabel("Coefficient of drag");
title("Coefficient of drag");

altitude = linspace(0, 25, 100) * 1e3;
[density, pressure, speedOfSound] = atmosphereModel(altitude);
gravity = gravityModel(altitude);

nextPlot("flight/physics/airDensity");
plot(altitude/1e3, density, 'LineWidth', 2);
xlabel("Altitude [km]");
ylabel("Air density (kg/m^3)");
title("Air density as function of altitude");

nextPlot("flight/physics/airPressure");
plot(altitude/1e3, pressure/1000, 'LineWidth', 2);
xlabel("Altitude [km]");
ylabel("Air pressure (kPa)");
title("Air pressure as function of altitude");

nextPlot("flight/physics/speedOfSound");
plot(altitude/1e3, speedOfSound, 'LineWidth', 2);
xlabel("Altitude [km]");
ylabel("Speed of sound (m/s)");
title("Speed of sound as function of altitude");

nextPlot("flight/physics/gravity");
plot(altitude/1e3, gravity, 'LineWidth', 2);
xlabel("Altitude [km]");
ylabel("Gravity (m/s^2)");
title("Gravity as function of altitude");

nextPlot();

t = flightState.time;
altitude = flightState.altitude;
burnoutTime = flightState.opts.input.combustionState.burnTime;
burnOutIndex = find(t-burnoutTime>0);
burnOutIndex = burnOutIndex(1);
[~, apogeeIndex] = max(altitude);

ambientPressure = flightState.ambientPressure;
ambientDensity = flightState.ambientDensity;
speedOfSound = flightState.speedOfSound;

nextPlot("flight/physics/ambientPressureOverAltitude");
plot(t, ambientPressure/1e3, 'LineWidth', 2, 'HandleVisibility','off');
hold on
plot(t(apogeeIndex), ambientPressure(apogeeIndex)/1e3, 'b*', 'DisplayName', 'Apogee')
plot(t(burnOutIndex), ambientPressure(burnOutIndex)/1e3, 'ro', 'DisplayName', 'Burnout')
xlabel("time [s]");
ylabel("Ambient pressure [kPa]");
title("Atmosphere pressure during flight");
legend('show', 'Location', 'best');
grid on
scaleLims(0.1);

nextPlot("flight/physics/ambientDensityOverAltitude");
plot(t, ambientDensity, 'LineWidth', 2, 'HandleVisibility','off');
hold on
plot(t(apogeeIndex), ambientDensity(apogeeIndex), 'b*', 'DisplayName', 'Apogee')
plot(t(burnOutIndex), ambientDensity(burnOutIndex), 'ro', 'DisplayName', 'Burnout')
xlabel("time [s]");
ylabel("Ambient density [kg/m^3]");
title("Atmosphere density during flight");
legend('show', 'Location', 'best');
grid on
scaleLims(0.1);


nextPlot("flight/physics/speedOfSoundOverAltitude");
plot(t, speedOfSound, 'LineWidth', 2, 'HandleVisibility','off');
hold on
plot(t(apogeeIndex), speedOfSound(apogeeIndex), 'b*', 'DisplayName', 'Apogee')
plot(t(burnOutIndex), speedOfSound(burnOutIndex), 'ro', 'DisplayName', 'Burnout')
xlabel("time [s]");
ylabel("Sound of speed [m/s]");
title("Sound of speed during flight");
legend('show', 'Location', 'best');
grid on
scaleLims(0.1);