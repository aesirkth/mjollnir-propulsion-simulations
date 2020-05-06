t = combustionState.time;

%% Events indexes
burnOutIndex = find(t-combustionState.burnTime>0);
if isempty(burnOutIndex)
    burnOutIndex = length(t);
end
burnOutIndex = burnOutIndex(1);

if tankModel ~= 2

setupSubplots(4,3)
nextPlot('');

plot(t,combustionState.regressionRate*1000)
xlim([0 t(burnOutIndex)]);
xlabel('Time [s]')
ylabel('Regression Rate [mm/s]')
title('Regression Rate over time')
grid('on')
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
xlim([0 t(burnOutIndex)]);
ylim([0, y3*1e3])
xlabel('Time [s]')
ylabel('Port Radius [mm]')
title('Port Radius over time')
legend('show', 'Location', 'best');
scaleLims(0.1);
grid('on')
nextPlot([filepath filesep 'portRadius'])

plot(t,combustionState.thrustCoefficient')
hold 
xlim([0 t(burnOutIndex)]);
xlabel('Time [s]')
ylabel('thrustCoefficient')
title('thrustCoefficient over time')
legend('show', 'Location', 'best');
scaleLims(0.1);
grid('on')
nextPlot([filepath filesep 'allPressure'])

plot(t,combustionState.tankPressure/1e6', 'DisplayName', 'Tank pressure')
hold on;
plot(t,combustionState.ccPressure/1e6', 'DisplayName', 'CC pressure')
plot(t,combustionState.exhaustPressure/1e6', 'DisplayName', 'Exhaust pressure')
hold 
xlim([0 t(burnOutIndex)]);
xlabel('Time [s]')
ylabel('Pressure [MPa]')
title('Pressure over time')
legend('show', 'Location', 'best');
scaleLims(0.1);
grid('on')
nextPlot([filepath filesep 'allPressure'])

plot(t,combustionState.exhaustMach', 'DisplayName', 'Exhaust mach')
hold 
xlim([0 t(burnOutIndex)]);
xlabel('Time [s]')
ylabel('Mach [1]')
title('Mach over time')
legend('show', 'Location', 'best');
scaleLims(0.1);
grid('on')
nextPlot([filepath filesep 'mach'])

plot(t,combustionState.ccPressure/1e6', 'HandleVisibility','off')
hold on
plot([t(1) t(end)], [combustionState.opts.ccCombustionPressure, combustionState.opts.ccCombustionPressure]/1e6, '--', 'LineWidth', 2, 'DisplayName', 'Design pressure')
plot([t(1) t(end)], [combustionState.opts.ccCombustionPressure, combustionState.opts.ccCombustionPressure]*combustionState.opts.ccCombustionPressureSafetyMargin/1e6, '--', 'LineWidth', 2, 'DisplayName', 'Design pressure (incl. safety)')
xlim([0 t(burnOutIndex)]);
xlabel('Time [s]')
ylabel('CC Pressure [MPa]')
title('Combustion Chamber pressure over time')
legend('show', 'Location', 'best');
scaleLims(0.1);
grid('on')
nextPlot([filepath filesep 'combustionPressure'])

OF = combustionState.oxidizerMassFlow ./ combustionState.fuelMassFlow;
plot(t,OF)
xlim([0 t(burnOutIndex)]);
ylim([0 max(OF)]);
xlabel('Time [s]')
ylabel('O/F ratio [MPa]')
title('O/F ratio over time')
grid('on')
nextPlot([filepath filesep 'ofRatio'])

plot(t,combustionState.thrust/1000, 'DisplayName', 'Real thrust (incl. efficiency)')
hold on
plot(t,combustionState.idealThrust/1000, 'DisplayName', 'Ideal thrust')
xlim([0 t(burnOutIndex)]);
xlabel('Time [s]')
ylabel('Thrust [kN]')
title('Thrust over time')
legend('show', 'Location', 'best');
grid('on')
nextPlot([filepath filesep 'thrust'])

plot(t,combustionState.ccTemperature)
xlim([0 t(burnOutIndex)]);
xlabel('Time [s]')
ylabel('CC Temperature [K]')
title('Combustion Chamber Temperature over time')
grid('on')
nextPlot([filepath filesep 'combustionTemperature'])

plot(t,combustionState.fuelMass, 'LineWidth', 2, 'DisplayName', 'Fuel')
hold on
plot(t,combustionState.oxidizerMass, 'LineWidth', 2, 'DisplayName', 'Oxidizer')
plot(t,combustionState.fuelMass + combustionState.oxidizerMass, 'LineWidth', 2, 'DisplayName', 'Total')
xlim([0 t(burnOutIndex)]);
xlabel('Time [s]')
ylabel('Mass [kg]')
title('Propellant mass over time')
legend('show', 'Location', 'best');
grid('on')
nextPlot([filepath filesep 'mass'])

plot(t,combustionState.fuelMassFlow, 'LineWidth', 2, 'DisplayName', 'Fuel')
hold on
plot(t,combustionState.oxidizerMassFlow, 'LineWidth', 2, 'DisplayName', 'Oxidizer')
plot(t,combustionState.fuelMassFlow + combustionState.oxidizerMassFlow, 'LineWidth', 2, 'DisplayName', 'Total')
xlim([0 t(burnOutIndex)]);
xlabel('Time [s]')
ylabel('Mass flow [kg/s]')
title('Mass flow over time')
legend('show', 'Location', 'best');
grid('on')
nextPlot([filepath filesep 'combustion'])

end

plot(t,combustionState.tankPressure/1e6, 'HandleVisibility','off')
hold on;
plot([t(1) t(end)], [combustionState.opts.OxidizerPressure, combustionState.opts.OxidizerPressure]/1e6, '--', 'LineWidth', 2, 'DisplayName', 'Design pressure')
plot([t(1) t(end)], [combustionState.opts.OxidizerPressure, combustionState.opts.OxidizerPressure]*combustionState.opts.OxidizerTankSafetyMargin/1e6, '--', 'LineWidth', 2, 'DisplayName', 'Design pressure (incl. safety)')
xlim([0 t(burnOutIndex)]);
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
    xlim([0 t(burnOutIndex)]);
    xlabel('Time [s]')
    ylabel('Temperature temperature [T]')
    title('Oxidizer temperature over time')
    legend('show', 'Location', 'best');
    scaleLims(0.1);
    grid('on')
    nextPlot([filepath filesep 'oxidzerTemperature'])
end