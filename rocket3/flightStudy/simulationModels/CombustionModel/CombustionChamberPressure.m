clear all
close all
injectors_diam = 0.002;
nozzle_diam = 0.02;
nb_injectors = 20;
opts = struct(...
    ... %% Fuel grain parameters
    'PortLength',0.3,...
    'FuelDensity',900,...
    ... %% Nozzle parameters
    'NozzleThroatDiameter',nozzle_diam,...
    ... %% Injectors parameters
    'InjectorsCd',0.83,...
    'InjectorsDiameter',injectors_diam,...
    'InjectorsArea',pi*injectors_diam^2/4*nb_injectors,...
    'NumberInjectors',nb_injectors,...
    ... %% Oxidizer parameters
    'OxidizerDensity',1250,...
    'OxidizerTankPressure',50e5,...
    ... %% Combustion parameters
    'Gamma',1.4,...
    'SpecificR',287,...
    'ccTemperature',3500,...
    'burnTime',10);

odefunc = @(t,X) solveCombustion(t,X,opts);
[t,X] = ode45(odefunc,[0 10],[0.03]);

combustionChamberPressure = zeros(1,length(t));
oxidizerMassFlow = zeros(1,length(t));
regressionRate = zeros(1,length(t));
fuelMassFlow = zeros(1,length(t));
for i=1:length(t)
[regressionRate(i),combustionChamberPressure(i),oxidizerMassFlow(i),fuelMassFlow(i)] = solveCombustion(t(i),X(i),opts);
end

f = 1;
figure(f)
plot(t,regressionRate*1000)
xlabel('Time (s)')
ylabel('Regression Rate (mm/s)')
grid('on')

f = f+1;
figure(f)
plot(t,combustionChamberPressure/10^6)
xlabel('Time (s)')
ylabel('Combustion Chamber Pressure (MPa)')
grid('on')

f = f+1;
figure(f)
plot(t,X*1000)
xlabel('Time (s)')
ylabel('Port Radius (mm)')
grid('on')

f = f+1;
figure(f)
hold on
plot(t,oxidizerMassFlow);
plot(t,fuelMassFlow);
plot(t,oxidizerMassFlow+fuelMassFlow);
hold off
grid('on')
legend('Oxidizer','Fuel','Total')
xlabel('Time (s)')
ylabel('Mass Flow (kg/s)')

f = f+1;
figure(f)
plot(t,oxidizerMassFlow./fuelMassFlow)
xlabel('Time (s)')
ylabel('O/F ratio')
grid('on')








