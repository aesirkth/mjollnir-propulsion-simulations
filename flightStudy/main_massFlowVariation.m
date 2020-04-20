% This file is where one can run multiple simulations that plot results with varying mass flow

clear

setup();

% set the region of mass flows to consider
massFlowMin = 1;
massFlowMax = 6;

% how many samples to run
samples = 300;
samplesRun = 0;

% include assumptions
run assumptions

massFlows = zeros(samples, 1);
apogees = zeros(samples, 1);
maxAccels = zeros(samples, 1);
startAccels = zeros(samples, 1);
burnTimes = zeros(samples, 1);
thrusts = zeros(samples, 1);

for i = 1:samples
    massFlow = rand() * (massFlowMax - massFlowMin) + massFlowMin;
        
    flightOpts = computeDerivedFlightOpts(struct( ...
        'PayloadMass', payloadMass, ...
        'PropellantMass', propellantMass, ...
        'Radius', (rocketDiameterInCentimeters/100)/2, ...
        'ExpansionPressure', expansionPressureInAtmospheres * 101300, ...
        'ExhaustDiameter', diameterOfNozzleExhaustInCentimeters / 100, ...
        'Isp', specificImpulse,  ...
        'MassFlow', massFlow,  ...
        'LaunchAngle', launchAngle ...
    ));

    if i == 1
        flightOpts
    end

    model = @(t, y) flightModel(t, y, flightOpts);

    odeOpts = odeset('Events', @flightModelEvents, 'RelTol', 1e-8, 'AbsTol', 1e-8);
    [t, State] = ode45(model, [0 500], [0 0 0 0 flightOpts.PropellantMass], odeOpts);

    r = State(:, 1:2);
    v = State(:, 3:4);

    altitude = r(:,2);
    vMag = vecnorm(v');
    acceleration = gradient(vMag, t);
    
    burnOutIndex = find(max(0, t - flightOpts.BurnTime), 1);
    
    if length(burnOutIndex) == 0
        continue
    end
    
    burnOutIndex = burnOutIndex(1);
    massFlows(i) = massFlow;
    apogees(i) = max(altitude);
    maxAccels(i) = max(acceleration(1:burnOutIndex)) / 9.8066;
    startAccels(i) = acceleration(1) / 9.8066;
    burnTimes(i) = t(burnOutIndex);
    thrusts(i) = flightOpts.Thrust;

    samplesRun = i;
    
    if samplesRun > 5
        plotAll(massFlows, apogees, maxAccels, startAccels, burnTimes, thrusts, samplesRun);
        drawnow
    end
end

%%
flightOpts
plotAll(massFlows, apogees, maxAccels, startAccels, burnTimes, thrusts, samplesRun);

function plotAll(massFlows, apogees, maxAccels, startAccels, burnTimes, thrusts, samplesRun)
    goal = 14;

    massFlows = massFlows(1:samplesRun);
    apogees = apogees(1:samplesRun)/1e3;
    maxAccels = maxAccels(1:samplesRun);
    startAccels = startAccels(1:samplesRun);
    burnTimes = burnTimes(1:samplesRun);
    thrusts = thrusts(1:samplesRun);
    [~, order] = sort(massFlows);

    massFlows = massFlows(order);
    apogees = apogees(order);
    maxAccels = maxAccels(order);
    startAccels = startAccels(order);
    burnTimes = burnTimes(order);
    thrusts = thrusts(order);
    
    [hasAnyCrossings, upwardCrossings, downwardCrossings] = findGoalCrossings(massFlows, apogees, goal);

    rangeForNarrowedMassFlow = [min(massFlows) max(massFlows)];
    if hasAnyCrossings
        if length(downwardCrossings) > 0
            rangeForNarrowedMassFlow(2) = max(downwardCrossings);
        end
        if length(upwardCrossings) > 0
            rangeForNarrowedMassFlow(1) = min(upwardCrossings);
        end
    end
    rangeRadius = rangeForNarrowedMassFlow(2) - rangeForNarrowedMassFlow(1);
    rangeForNarrowedMassFlow(1) = rangeForNarrowedMassFlow(1) - rangeRadius*0.1;
    rangeForNarrowedMassFlow(2) = rangeForNarrowedMassFlow(2) + rangeRadius*0.1;
    
    setupSubplots(3,2);
    nextPlot();    
    plot(massFlows, apogees, '-', 'HandleVisibility','off');
    hold on
    lims = xlim;
    plot(lims, [goal goal], 'b--', 'DisplayName', 'Goal apogee');
    scaleLims(0.1);
    lims = ylim;
    
    for crossing = upwardCrossings
        plot([crossing crossing], lims, 'r--', 'DisplayName', 'Reachable goal, lower bound');
    end
    for crossing = downwardCrossings
        plot([crossing crossing], lims, 'm--', 'DisplayName', 'Reachable goal, upper bound');
    end
    
    xlabel("Mass flow [kg/s]");
    ylabel("Apogee reached [km]");
    legend('show', 'Location', 'best');
    grid on
    
    nextPlot();    
    plot(massFlows, maxAccels, '-', 'DisplayName', 'Maximum during burn');
    hold on
    plot(massFlows, startAccels, '-', 'DisplayName', 'At liftoff');
    if hasAnyCrossings
        xlim(rangeForNarrowedMassFlow);
    end
    lims = ylim;
    for crossing = upwardCrossings
        plot([crossing crossing], lims, 'r--', 'DisplayName', 'Reachable goal, lower bound');
    end
    for crossing = downwardCrossings
        plot([crossing crossing], lims, 'm--', 'DisplayName', 'Reachable goal, upper bound');
    end
    xlabel("Mass flow [kg/s]");
    ylabel("Acceleration [G]");
    legend('show', 'Location', 'best');
    grid on
    
    nextPlot();    
    plot(massFlows, maxAccels, '-', 'DisplayName', 'Maximum during burn');
    hold on
    plot(massFlows, startAccels, '-', 'DisplayName', 'At liftoff');
    lims = ylim;
    for crossing = upwardCrossings
        plot([crossing crossing], lims, 'r--', 'DisplayName', 'Reachable goal, lower bound');
    end
    for crossing = downwardCrossings
        plot([crossing crossing], lims, 'm--', 'DisplayName', 'Reachable goal, upper bound');
    end
    xlabel("Mass flow [kg/s]");
    ylabel("Acceleration [G]");
    legend('show', 'Location', 'best');
    grid on
    
    nextPlot();    
    plot(massFlows, burnTimes, '-', 'HandleVisibility','off');
    hold on
    lims = ylim;
    if hasAnyCrossings
        xlim(rangeForNarrowedMassFlow);
        legend('show', 'Location', 'best');
    end
    for crossing = upwardCrossings
        plot([crossing crossing], lims, 'r--', 'DisplayName', 'Reachable goal, lower bound');
    end
    for crossing = downwardCrossings
        plot([crossing crossing], lims, 'm--', 'DisplayName', 'Reachable goal, upper bound');
    end
    xlabel("Mass flow [kg/s]");
    ylabel("Burn time [s]");
    grid on
    
    nextPlot();    
    plot(massFlows, burnTimes, '-', 'HandleVisibility','off');

%     if hasAnyCrossings
%         xlim(rangeForNarrowedMassFlow);
%         legend('show', 'Location', 'best');
%     end
    hold on
%     lims = ylim;
%     for crossing = upwardCrossings
%         plot([crossing crossing], lims, 'r--', 'DisplayName', 'Reachable goal, lower bound');
%     end
%     for crossing = downwardCrossings
%         plot([crossing crossing], lims, 'm--', 'DisplayName', 'Reachable goal, upper bound');
%     end
    xlabel("Mass flow [kg/s]");
    ylabel("Burn time [s]");
    grid on
    
    nextPlot();    
    plot(massFlows, thrusts/1e3, '-', 'HandleVisibility','off');

    if hasAnyCrossings
        xlim(rangeForNarrowedMassFlow);
        legend('show', 'Location', 'best');
    end
    hold on
    lims = ylim;
    for crossing = upwardCrossings
        plot([crossing crossing], lims, 'r--', 'DisplayName', 'Reachable goal, lower bound');
    end
    for crossing = downwardCrossings
        plot([crossing crossing], lims, 'm--', 'DisplayName', 'Reachable goal, upper bound');
    end
    xlabel("Mass flow [kg/s]");
    ylabel("Thrust [kN]");
    grid on
end