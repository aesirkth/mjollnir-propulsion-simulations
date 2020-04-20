
oxidizerMass = state(:,1);
fuelMass = state(:,2);
propellantMass = oxidizerMass + fuelMass;
portRadius = state(:,3);
ccPressure = state(:,4);

%% State derivative derived values
dStatedt = 0*state;

Thrust = dStatedt(:,1);
oxidizerMassFlow = dStatedt(:,1);
fuelMassFlow = dStatedt(:,1);
regressionRate = dStatedt(:,1);
ccTemperature = dStatedt(:,1);
dStatedt = dStatedt';
for i=1:length(t)
    [dStatedt(:,i),regressionRate(i),~,oxidizerMassFlow(i),fuelMassFlow(i),Thrust(i),ccTemperature(i)] = model(t(i),state(i,:)');
end
dStatedt = dStatedt';
regressionRate = dStatedt(:,3);

%% Events indexes
burnOutIndex = find(t-burnTime>0);
if isempty(burnOutIndex)
    burnOutIndex = length(t);
end
burnOutIndex = burnOutIndex(1);

setupSubplots(3,2)
nextPlot('')
plot(t,regressionRate*1000)
xlim([0 t(burnOutIndex)]);
xlabel('Time [s]')
ylabel('Regression Rate [mm/s]')
title('Regression Rate over time')
grid('on')

nextPlot('')
plot(t,portRadius*1000)
xlim([0 t(burnOutIndex)]);
xlabel('Time [s]')
ylabel('Port Radius [mm]')
title('Port Radius over time')
grid('on')

nextPlot('')
plot(t,ccPressure/1e6)
xlim([0 t(burnOutIndex)]);
xlabel('Time [s]')
ylabel('CC Pressure [MPa]')
title('Combustion Chamber pressure over time')
grid('on')

nextPlot('')
OF = oxidizerMassFlow ./ fuelMassFlow;
plot(t,OF)
xlim([0 t(burnOutIndex)]);
ylim([0 max(OF)]);
xlabel('Time [s]')
ylabel('O/F ratio [MPa]')
title('O/F ratio over time')
grid('on')

nextPlot('')
plot(t,Thrust/1000)
xlim([0 t(burnOutIndex)]);
xlabel('Time [s]')
ylabel('Thrust [kN]')
title('Thrust over time')
grid('on')

nextPlot('')
plot(t,ccTemperature)
xlim([0 t(burnOutIndex)]);
xlabel('Time [s]')
ylabel('CC Temperature [K]')
title('Combustion Chamber Temperature over time')
grid('on')