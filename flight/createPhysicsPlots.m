
setupSubplots(2, 3)

nextPlot("flight/physics/coefficientOfDrag");

mach = linspace(0, 20, 100);
Cd = dragCoefficientModel(mach*340, 340);

plot(mach, Cd);
xlim([0, 5])
xlabel("Mach number");
ylabel("Coefficient of drag");

altitude = linspace(0, 25, 100) * 1e3;
[density, pressure, speedOfSound] = atmosphereModel(altitude)
gravity = gravityModel(altitude)

nextPlot("flight/physics/airDensity");
plot(altitude/1e3, density);
xlabel("Altitude [km]");
ylabel("Air density (kg/m^3)");

nextPlot("flight/physics/airPressure");
plot(altitude/1e3, pressure/1000);
xlabel("Altitude [km]");
ylabel("Air pressure (kPa)");

nextPlot("flight/physics/speedOfSound");
plot(altitude/1e3, speedOfSound);
xlabel("Altitude [km]");
ylabel("Speed of sound (m/s)");

nextPlot("flight/physics/gravity");
plot(altitude/1e3, gravity);
xlabel("Altitude [km]");
ylabel("Gravity (m/s^2)");
