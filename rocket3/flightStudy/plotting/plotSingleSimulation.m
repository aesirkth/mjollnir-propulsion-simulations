function plotSingleSimulation(flightOpts, t, State)
    r = State(:, 1:2);
    v = State(:, 3:4);
    
    goalKm = 12;

    altitude = r(:,2);
    vMag = vecnorm(v');
    acceleration = gradient(vMag, t);
    propellantMass = State(:, 5);

    burnOutIndex = find(max(0, t - flightOpts.BurnTime), 1);
    [~, apogeeIndex] = max(altitude);
    
    global storeFiguresToFile;
    storeFiguresToFile = 1;
    setupSubplots(4,3);

    plot(r(:,1)/1e3, r(:,2)/1e3, '-', 'LineWidth', 2, 'HandleVisibility','off')
    hold on
    plot(r(1,1)/1e3, r(1,2)/1e3, '*', 'DisplayName', 'Initial')
    plot(r(apogeeIndex,1)/1e3, r(apogeeIndex,2)/1e3, 'b*', 'DisplayName', 'Apogee')
    plot(r(burnOutIndex,1)/1e3, r(burnOutIndex,2)/1e3, 'ro', 'DisplayName', 'Burnout')
    lims = xlim;
    plot(lims, [goalKm goalKm], '--', 'LineWidth', 2, 'DisplayName', sprintf("%.0f km goal", goalKm))
    xlabel("downrange [km]");
    ylabel("altitude [km]");
    title("2D trajectory");
    legend('show', 'Location', 'best');
    grid on
    scaleLims(0.1);
    nextPlot('plot1_downrangeAltitude');
    
    plot(t, altitude/1e3, 'LineWidth', 2, 'HandleVisibility','off');
    hold on
    plot(t(apogeeIndex), altitude(apogeeIndex)/1e3, 'b*', 'DisplayName', 'Apogee')
    plot(t(burnOutIndex), altitude(burnOutIndex)/1e3, 'ro', 'DisplayName', 'Burnout')
    xlabel("time [s]");
    ylabel("Altitude [km]");
    title("Altitude over time");
    legend('show', 'Location', 'best');
    grid on
    scaleLims(0.1);
    nextPlot('plot2_altitudeOverTime');
    
    plot(t, vMag, 'LineWidth', 2, 'HandleVisibility','off');
    hold on
    plot(t(apogeeIndex), vMag(apogeeIndex), 'b*', 'DisplayName', 'Apogee')
    plot(t(burnOutIndex), vMag(burnOutIndex), 'ro', 'DisplayName', 'Burnout')
    xlabel("time [s]");
    ylabel("Velocity [m/s]");
    title("Velocity over time");
    legend('show', 'Location', 'best');
    grid on
    scaleLims(0.1);
    nextPlot('plot3_velocityOverTime');
    
    [ambientDensity, ambientPressure, speedOfSound] = atmosphereModel(altitude);
    plot(t, vMag./speedOfSound, 'LineWidth', 2, 'HandleVisibility','off');
    hold on
    plot(t(apogeeIndex), vMag(apogeeIndex)./speedOfSound(apogeeIndex), 'b*', 'DisplayName', 'Apogee')
    plot(t(burnOutIndex), vMag(burnOutIndex)./speedOfSound(burnOutIndex), 'ro', 'DisplayName', 'Burnout')
    xlabel("time [s]");
    ylabel("Mach");
    title("Mach over time");
    legend('show', 'Location', 'best');
    grid on
    scaleLims(0.1);
    nextPlot('plot4_machOverTime');
    
    plot(altitude / 1000, vMag, 'LineWidth', 2, 'HandleVisibility','off')
    hold on
    plot(altitude(1) / 1000, vMag(1), '*', 'DisplayName', 'Initial')
    plot(altitude(apogeeIndex) / 1000, vMag(apogeeIndex), 'b*', 'DisplayName', 'Apogee')
    plot(altitude(burnOutIndex) / 1000, vMag(burnOutIndex), 'ro', 'DisplayName', 'Burnout')
    xlabel("altitude [km]");
    ylabel("velocity [m/s]");
    title("Velocity as function of altitude");
    legend('show', 'Location', 'best');
    grid on
    scaleLims(0.1);
    nextPlot('plot5_velocityWithAltitude');
    
    plot(t, abs(acceleration)/9.8066, 'LineWidth', 2, 'HandleVisibility','off');
    hold on
    plot(t(apogeeIndex), abs(acceleration(apogeeIndex))/9.8066, 'b*', 'DisplayName', 'Apogee')
    plot(t(burnOutIndex), abs(acceleration(burnOutIndex))/9.8066, 'ro', 'DisplayName', 'Burnout')
    xlabel("time [s]");
    ylabel("acceleration [g]");
    title("Acceleration over time");
    legend('show', 'Location', 'best');
    grid on
    scaleLims(0.1);
    nextPlot('plot6_accelerationOverTime');
    
    plot(t, ambientPressure/1e3, 'LineWidth', 2, 'HandleVisibility','off');
    hold on
    plot(t(apogeeIndex), ambientPressure(apogeeIndex)/1e3, 'b*', 'DisplayName', 'Apogee')
    plot(t(burnOutIndex), ambientPressure(burnOutIndex)/1e3, 'ro', 'DisplayName', 'Burnout')
    xlabel("time [s]");
    ylabel("Ambient pressure [kPa]");
    title("Atmosphere pressure");
    legend('show', 'Location', 'best');
    grid on
    scaleLims(0.1);
    nextPlot('plot7_ambientPressure');
    
    plot(t, ambientDensity, 'LineWidth', 2, 'HandleVisibility','off');
    hold on
    plot(t(apogeeIndex), ambientDensity(apogeeIndex), 'b*', 'DisplayName', 'Apogee')
    plot(t(burnOutIndex), ambientDensity(burnOutIndex), 'ro', 'DisplayName', 'Burnout')
    xlabel("time [s]");
    ylabel("Ambient density [kg/m^3]");
    title("Atmosphere density");
    legend('show', 'Location', 'best');
    grid on
    scaleLims(0.1);
    nextPlot('plot8_atmosphereDensity');
    
    Cd = dragCoefficientModel(vMag, speedOfSound);
    % mass = massModel(t, flightOpts.DryMass, propellantMass);
    dragFactor = dragModel(vMag, ambientDensity, flightOpts.Radius, Cd);
    plot(t, dragFactor, 'LineWidth', 2, 'HandleVisibility','off');
    hold on
    plot(t(apogeeIndex), dragFactor(apogeeIndex), 'b*', 'DisplayName', 'Apogee')
    plot(t(burnOutIndex), dragFactor(burnOutIndex), 'ro', 'DisplayName', 'Burnout')
    xlabel("time [s]");
    ylabel("drag [N]");
    title("Drag over time");
    legend('show', 'Location', 'best');
    grid on
    scaleLims(0.1);
    nextPlot('plot9_dragOvertime');
    
    plot(altitude / 1000, dragFactor, 'LineWidth', 2, 'HandleVisibility','off')
    hold on
    plot(altitude(1) / 1000, dragFactor(1), '*', 'DisplayName', 'Initial')
    plot(altitude(apogeeIndex) / 1000, dragFactor(apogeeIndex), 'b*', 'DisplayName', 'Apogee')
    plot(altitude(burnOutIndex) / 1000, dragFactor(burnOutIndex), 'ro', 'DisplayName', 'Burnout')
    xlabel("altitude [km]");
    ylabel("drag [N]");
    title("Drag as function of altitude");
    legend('show', 'Location', 'best');
    grid on
    scaleLims(0.1);
    nextPlot('plot10_dragWithAltitude');
    
    plot(t, propellantMass, 'LineWidth', 2, 'HandleVisibility','off')
    hold on
    plot(t(apogeeIndex), propellantMass(apogeeIndex), 'b*', 'DisplayName', 'Apogee')
    plot(t(burnOutIndex), propellantMass(burnOutIndex), 'ro', 'DisplayName', 'Burnout')
    xlabel("time [s]");
    ylabel("propellant mass [kg]");
    title("Propellant mass over time");
    legend('show', 'Location', 'best');
    xlim([-1 t(apogeeIndex)+1]);
    xticks([0 t(burnOutIndex) t(apogeeIndex)]);
    grid on
    scaleLims(0.1);
    nextPlot('plot11_propellantOverTime');
    
    massFlow = gradient(propellantMass, t);
    plot(t, massFlow, 'LineWidth', 2, 'HandleVisibility','off')
    hold on
    plot(t(apogeeIndex), massFlow(apogeeIndex), 'b*', 'DisplayName', 'Apogee')
    plot(t(burnOutIndex), massFlow(burnOutIndex), 'ro', 'DisplayName', 'Burnout')
    xlabel("time [s]");
    xlim([-1 t(apogeeIndex)+1]);
    xticks([0 t(burnOutIndex) t(apogeeIndex)]);
    ylabel("propellant mass flow [kg/s]");
    title("Propellant mass flow over time");
    legend('show', 'Location', 'best');
    grid on
    scaleLims(0.1);
    nextPlot('plot12_massFlowOverTime');
end

