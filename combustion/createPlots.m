t = combustionState.time;

%% Events indexes
burnOutIndex = find(t-combustionState.burnTime>0);
if isempty(burnOutIndex)
    burnOutIndex = length(t);
end
burnOutIndex = burnOutIndex(1);

TSTART = 0.1;
TEND = t(burnOutIndex - 2);

if tankModel ~= 2

setupSubplots(5,3)
nextPlot('');

plot(t,combustionState.regressionRate*1000, 'LineWidth', 2)
xlim([TSTART TEND]);
xlabel('Time [s]')
ylabel('Regression Rate [mm/s]')
title('Regression Rate over time')
grid('on')
scaleLims(0.1);
nextPlot([filepath filesep 'regressionRate'])

plot(t,combustionState.portRadius*1000, 'HandleVisibility','off')
hold on
plot([t(1) t(end)], [combustionState.opts.FuelGrainInitialPortRadius, combustionState.opts.FuelGrainInitialPortRadius]*1e3, '--', 'LineWidth', 2, 'DisplayName', 'Initial port radius')
plot([t(1) t(end)], [combustionState.opts.UsableFuelGrainRadius, combustionState.opts.UsableFuelGrainRadius]*1e3, '--', 'LineWidth', 2,  'DisplayName', 'Usable fuel radius')
plot([t(1) t(end)], [combustionState.opts.TotalFuelGrainRadius, combustionState.opts.TotalFuelGrainRadius]*1e3, '--', 'LineWidth', 2,  'DisplayName', 'Total fuel radius, incl. margin')

y1 = combustionState.opts.TotalFuelGrainRadius; % Inner casing radius
y2 = combustionState.opts.TotalFuelGrainRadius + combustionState.opts.FuelGrainContainerWallThickness; % Outer radius
y3 = combustionState.opts.CombustionChamberRadius; % Wall outer radius
fill([t(1) t(end) t(end) t(1)], [y1 y1 y2 y2]*1e3, '-', 'LineWidth', 2,  'DisplayName', 'Fuel grain casing')
fill([t(1) t(end) t(end) t(1)], [y2 y2 y3 y3]*1e3, '-', 'LineWidth', 2,  'DisplayName', 'Combustion chamber')
xlim([TSTART TEND]);
ylim([0, y3*1e3])
xlabel('Time [s]')
ylabel('Port Radius [mm]')
title('Port Radius over time')
legend('show', 'Location', 'best');
scaleLims(0.1);
grid('on')
nextPlot([filepath filesep 'portRadius'])
% 
% plot(t,combustionState.thrustCoefficient')
% hold 
% xlim([0 t(burnOutIndex)]);
% xlabel('Time [s]')
% ylabel('thrustCoefficient')
% title('thrustCoefficient over time')
% legend('show', 'Location', 'best');
% scaleLims(0.1);
% grid('on')
% nextPlot([filepath filesep 'allPressure'])

%
semilogy(t,combustionState.tankPressure./combustionState.ccPressure, 'LineWidth', 2, 'DisplayName', 'CC/exhaust pressure')
hold on;
xlim([TSTART TEND]);
xlabel('Time [s]')
ylabel('Pressure ratio [1]')
title('Pressure ratio over time')
legend('show', 'Location', 'best');
scaleLims(0.1);
grid('on')
nextPlot([filepath filesep 'pressureRatio'])

plot(t,(combustionState.tankPressure - combustionState.ccPressure)/1e6, 'LineWidth', 2, 'DisplayName', 'Pressure diff - tank vs cc')
hold on;
xlim([TSTART TEND]);
xlabel('Time [s]')
ylabel('Pressure difference [MPa]')
title('Pressure difference over time')
legend('show', 'Location', 'best');
scaleLims(0.1);
grid('on')
nextPlot([filepath filesep 'pressureDiff'])

plot(t,combustionState.exhaustPressure/1e5', 'LineWidth', 2, 'DisplayName', 'Exhaust pressure')
hold on;
xlim([TSTART TEND]);
xlabel('Time [s]')
ylabel('Pressure [bar]')
title('Exhaust pressure over time')
legend('show', 'Location', 'best');
scaleLims(0.1);
grid('on')
nextPlot([filepath filesep 'exhaustPressure'])

plot(t,combustionState.tankPressure/1e6', 'LineWidth', 2, 'DisplayName', 'Tank pressure')
hold on;
plot(t,combustionState.ccPressure/1e6', 'LineWidth', 2, 'DisplayName', 'CC pressure')
plot(t,combustionState.exhaustPressure/1e6', 'LineWidth', 2, 'DisplayName', 'Exhaust pressure')
hold on;
xlim([TSTART TEND]);
xlabel('Time [s]')
ylabel('Pressure [MPa]')
title('Pressure over time')
legend('show', 'Location', 'best');
scaleLims(0.1);
grid('on')
nextPlot([filepath filesep 'allPressure'])

plot(t,combustionState.exhaustMach', 'LineWidth', 2, 'DisplayName', 'Exhaust mach')
hold on;
xlim([TSTART TEND]);
xlabel('Time [s]')
ylabel('Mach [1]')
title('Mach over time')
legend('show', 'Location', 'best');
scaleLims(0.1);
grid('on')
nextPlot([filepath filesep 'mach'])

plot(t,combustionState.ccPressure/1e6', 'LineWidth', 2, 'HandleVisibility','off')
hold on
plot([t(1) t(end)], [combustionState.opts.ccCombustionPressure, combustionState.opts.ccCombustionPressure]/1e6, '--', 'LineWidth', 2, 'DisplayName', 'Design pressure')
plot([t(1) t(end)], [combustionState.opts.ccCombustionPressure, combustionState.opts.ccCombustionPressure]*combustionState.opts.ccCombustionPressureSafetyMargin/1e6, '--', 'LineWidth', 2, 'DisplayName', 'Burst pressure')
xlim([TSTART TEND]);
xlabel('Time [s]')
ylabel('CC Pressure [MPa]')
title('Combustion Chamber pressure over time')
legend('show', 'Location', 'best');
scaleLims(0.1);
grid('on')
nextPlot([filepath filesep 'combustionPressure'])

OF = combustionState.oxidizerMassFlow ./ combustionState.fuelMassFlow;
plot(t,OF, 'LineWidth', 2)
xlim([TSTART TEND]);
xlabel('Time [s]')
ylabel('O/F ratio [MPa]')
title('O/F ratio over time')
grid('on')
scaleLims(0.1);
nextPlot([filepath filesep 'ofRatio'])

plot(t,combustionState.thrust/1000, 'DisplayName', 'Real thrust', 'LineWidth', 2)
hold on
plot(t,combustionState.idealThrust/1000, 'DisplayName', 'Ideal thrust', 'LineWidth', 2)
xlim([TSTART TEND]);
xlabel('Time [s]')
ylabel('Thrust [kN]')
title('Thrust over time')
legend('show', 'Location', 'best');
grid('on')
scaleLims(0.1);
nextPlot([filepath filesep 'thrust'])

plot(t,combustionState.ccTemperature, 'LineWidth', 2)
xlim([TSTART TEND]);
xlabel('Time [s]')
ylabel('CC Temperature [K]')
title('Combustion Chamber Temperature over time')
grid('on')
scaleLims(0.1);
nextPlot([filepath filesep 'combustionTemperature'])

plot(t,combustionState.fuelMass, 'LineWidth', 2, 'DisplayName', 'Fuel')
hold on
plot(t,combustionState.oxidizerMass, 'LineWidth', 2, 'DisplayName', 'Oxidizer')
plot(t,combustionState.fuelMass + combustionState.oxidizerMass, 'LineWidth', 2, 'DisplayName', 'Total')
xlim([TSTART TEND]);
xlabel('Time [s]')
ylabel('Mass [kg]')
title('Propellant mass over time')
legend('show', 'Location', 'best');
grid('on')
scaleLims(0.1);
nextPlot([filepath filesep 'mass'])

plot(t,combustionState.fuelMassFlow, 'LineWidth', 2, 'DisplayName', 'Fuel')
hold on
plot(t,combustionState.oxidizerMassFlow, 'LineWidth', 2, 'DisplayName', 'Oxidizer')
plot(t,combustionState.fuelMassFlow + combustionState.oxidizerMassFlow, 'LineWidth', 2, 'DisplayName', 'Total')
xlim([TSTART TEND]);
xlabel('Time [s]')
ylabel('Mass flow [kg/s]')
title('Mass flow over time')
legend('show', 'Location', 'best');
grid('on')
scaleLims(0.1);
nextPlot([filepath filesep 'combustion'])

end

plot(t,combustionState.tankPressure/1e6, 'LineWidth', 2, 'HandleVisibility','off')
hold on;
plot([t(1) t(end)], [combustionState.opts.OxidizerTankPressure, combustionState.opts.OxidizerTankPressure]/1e6, '--', 'LineWidth', 2, 'DisplayName', 'Design pressure')
plot([t(1) t(end)], [combustionState.opts.OxidizerTankPressure, combustionState.opts.OxidizerTankPressure]*combustionState.opts.OxidizerTankSafetyMargin/1e6, '--', 'LineWidth', 2, 'DisplayName', 'Burst pressure')
xlim([TSTART TEND]);
xlabel('Time [s]')
ylabel('Oxidizer tank pressure [MPa]')
title('Oxidizer tank pressure over time')
legend('show', 'Location', 'best');
scaleLims(0.1);
grid('on')
nextPlot([filepath filesep 'tankPressure'])

if tankModel ~= 0
    plot(t,combustionState.oxidizerTemperature, 'LineWidth', 2, 'DisplayName', 'Oxidizer temperature')
    hold on;
    plot([t(1) t(end)], [combustionState.opts.AmbientTemperature, combustionState.opts.AmbientTemperature], '--', 'LineWidth', 2, 'DisplayName', 'Ambient temperature')
    plot(t,combustionState.wallTemperatureGNode, '--', 'LineWidth', 2, 'DisplayName','Wall temperature of gas node')
    plot(t,combustionState.wallTemperatureLNode, '--', 'LineWidth', 2, 'DisplayName','Wall temperature of liquid node')
    xlim([TSTART TEND]);
    xlabel('Time [s]')
    ylabel('Temperature temperature [T]')
    title('Oxidizer temperature over time')
    legend('show', 'Location', 'best');
    scaleLims(0.1);
    grid('on')
    nextPlot([filepath filesep 'oxidzerTemperature'])
end