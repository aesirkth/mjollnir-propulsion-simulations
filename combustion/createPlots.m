
% oxidizerMass = state(:,1);
% fuelMass = state(:,2);
% propellantMass = oxidizerMass + fuelMass;
% portRadius = state(:,3);
% ccPressure = state(:,4);
% 
% %% State derivative derived values
% dStatedt = 0*state;
% 
% Thrust = dStatedt(:,1);
% oxidizerMassFlow = dStatedt(:,1);
% fuelMassFlow = dStatedt(:,1);
% regressionRate = dStatedt(:,1);
% ccTemperature = dStatedt(:,1);
% dStatedt = dStatedt';
% for i=1:length(t)
%     [dStatedt(:,i),regressionRate(i),~,oxidizerMassFlow(i),fuelMassFlow(i),Thrust(i),ccTemperature(i)] = model(t(i),state(i,:)');
% end
% dStatedt = dStatedt';
% regressionRate = dStatedt(:,3);

t = combustionState.time;

%% Events indexes
burnOutIndex = find(t-combustionState.burnTime>0);
if isempty(burnOutIndex)
    burnOutIndex = length(t);
end
burnOutIndex = burnOutIndex(1);

setupSubplots(3,3)
nextPlot('regressionRate')
plot(t,combustionState.regressionRate*1000)
xlim([0 t(burnOutIndex)]);
xlabel('Time [s]')
ylabel('Regression Rate [mm/s]')
title('Regression Rate over time')
grid('on')

nextPlot('portRadius')
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

nextPlot('combustionPressure')
plot(t,combustionState.ccPressure/1e6', 'HandleVisibility','off')
hold on
plot([t(1) t(end)], [combustionState.opts.ccCombustionPressure, combustionState.opts.ccCombustionPressure]/1e6, '--', 'DisplayName', 'Chamber design pressure')
xlim([0 t(burnOutIndex)]);
xlabel('Time [s]')
ylabel('CC Pressure [MPa]')
title('Combustion Chamber pressure over time')
legend('show', 'Location', 'best');
scaleLims(0.1);
grid('on')

nextPlot('ofRatio')
OF = combustionState.oxidizerMassFlow ./ combustionState.fuelMassFlow;
plot(t,OF)
xlim([0 t(burnOutIndex)]);
ylim([0 max(OF)]);
xlabel('Time [s]')
ylabel('O/F ratio [MPa]')
title('O/F ratio over time')
grid('on')

nextPlot('thrust')
plot(t,combustionState.thrust/1000)
xlim([0 t(burnOutIndex)]);
xlabel('Time [s]')
ylabel('Thrust [kN]')
title('Thrust over time')
grid('on')

nextPlot('combustionTemperature')
plot(t,combustionState.ccTemperature)
xlim([0 t(burnOutIndex)]);
xlabel('Time [s]')
ylabel('CC Temperature [K]')
title('Combustion Chamber Temperature over time')
grid('on')

nextPlot('oxidizerMass')
plot(t,combustionState.oxidizerMass)
xlim([0 t(burnOutIndex)]);
xlabel('Time [s]')
ylabel('Oxidizer mass [kg]')
title('Oxidizer mass over time')
grid('on')

nextPlot('fuelMass')
plot(t,combustionState.fuelMass)
xlim([0 t(burnOutIndex)]);
xlabel('Time [s]')
ylabel('Fuel mass [kg]')
title('Fuel mass over time')
grid('on')

nextPlot('massFlow')
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