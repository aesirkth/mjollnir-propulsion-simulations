function plotFlightPhysics(flightState,tankModel)
if tankModel == 0
    filepath = './flight/simulation_without_tank';
    mkdir(filepath)
elseif tankModel == 1
    filepath = './flight/simulation_with_tank';
    mkdir(filepath)
elseif tankModel == 2
    filepath = './flight/simulation_tank_drain_to_atmosphere';
    mkdir(filepath)
end
run("./flight/createPhysicsPlots");
end