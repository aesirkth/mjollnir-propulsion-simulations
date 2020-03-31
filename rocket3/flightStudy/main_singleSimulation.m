% This file is where one can run single simulation that plots in greater detail


setup();
run assumptions

flightOpts = computeDerivedFlightOpts(struct( ...
    'OxidizerFuelRatio', ofRatio, ...
    'ParachuteMass', parachuteMass, ...
    'ElectronicsMass', electronicsMass, ...
    'BodyTubeMass', bodyTubeMass, ...
    'PayloadMass', payloadMass, ...
    'CombustionChamberRadius', combustionChamberDiameterCm/100/2, ...
    'FuelGrainLength', fuelGrainLengthCm/100, ...
    'FuelGrainMarginThickness', fuelGrainMarginThicknessMm/1000, ...
    'FuelGrainPortRadius', fuelGrainCenterPortDiameterCm/100/2, ...    
    'TankPressure', tankPressure, ...
    'CombustionPressure', combustionPressure, ...
    'Radius', (rocketDiameterInCentimeters/100)/2, ...
    'ExpansionPressure', expansionPressureInAtmospheres * 101300, ...
    'ExhaustDiameter', diameterOfNozzleExhaustInCentimeters / 100, ...
    'Isp', specificImpulse,  ...
    'MassFlow', massFlow,  ...
    'LaunchAngle', launchAngle ...
));
outputOpts(flightOpts)

%%
model = @(t, y) flightModel(t, y, flightOpts);

odeOpts = odeset('Events', @flightModelEvents, 'RelTol', 1e-8, 'AbsTol', 1e-8);
[t, State] = ode45(model, [0 500], [0 0 0 0 flightOpts.PropellantMass], odeOpts);

%%
plotSingleSimulation(flightOpts, t, State);

%%

y = 0;

clf
r = flightOpts.CombustionChamberRadius;
pr = flightOpts.FuelGrainPortRadius;
t = flightOpts.FuelGrainMarginThickness;
L = flightOpts.CombustionChamberLength;
[X, Y] = renderCapsuleTank(2*r, L);
hold on

ir = r-t;

subplot(1,2,1);
hold on
axis equal

offset = r;
fill([r ir ir r], [0 0 L L]+offset, 'r', 'HandleVisibility', 'off')
fill(-[r ir ir r], [0 0 L L]+offset, 'r', 'DisplayName', 'Unusable fuel (margin)');
fill([pr ir ir pr], [0 0 L L]+offset, 'g', 'HandleVisibility', 'off')
fill(-[pr ir ir pr], [0 0 L L]+offset, 'g', 'DisplayName', 'Usable fuel');
plot(X, Y+r,  'm', 'LineWidth', 2, 'DisplayName', 'Combustion Chamber');

lims = ylim;
ylim([lims(1)-r lims(2)+r])
title("Combustion chamber (under assumptions)");

legend('show')

subplot(1,2,2);
hold on
axis equal

fill([r ir ir r], [0 0 L L]+offset, 'r', 'HandleVisibility', 'off')
fill(-[r ir ir r], [0 0 L L]+offset, 'r', 'DisplayName', 'Unusable fuel (margin)');
fill([pr ir ir pr], [0 0 L L]+offset, 'g', 'HandleVisibility', 'off')
fill(-[pr ir ir pr], [0 0 L L]+offset, 'g', 'DisplayName', 'Usable fuel');
plot(X, Y+r,  'm', 'LineWidth', 2, 'DisplayName', 'Combustion Chamber');
axis equal
offset = L + 4*r;

L = flightOpts.OxidizerTankLength;
[X, Y] = renderCapsuleTank(2*r, L);
fill(X, Y+offset, [0.3 0.3 0.7], 'DisplayName', 'Oxidizer');
plot(X, Y+offset, 'r', 'LineWidth', 2, 'DisplayName', 'Oxidizer tank');

lims = ylim;
ylim([lims(1)-r lims(2)+r])
title("Full system (under assumptions)");
legend('show')

function [X, Y] = renderCapsuleTank(d, L)
    N = 50;
    
    X = zeros(2*N+1,1);
    Y = zeros(2*N+1,1);
    
    r = d/2;
    
    i = 1;
    for theta = linspace(0, pi, N)
        X(i) = cos(theta)*r;
        Y(i) = L + sin(theta)*r;
        i = i+1;
    end
    
    for theta = linspace(pi, 2*pi, N)
        X(i) = cos(theta)*r;
        Y(i) = sin(theta)*r;
        i = i+1;
    end
    
    X(end) = X(1);
    Y(end) = Y(1);
end