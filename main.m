run("./setup");

%%
setPlotMode("save");
% setPlotMode("show");

%%
nozzleAssumptions = nozzleSimulationAssumptions()
nozzleState = nozzleSimulation(nozzleAssumptions)
%%
combustionAssumptions = combustionSimulationAssumptions()
combustionState = combustionSimulation(combustionAssumptions, nozzleState)
combustionOpts = combustionState.opts
%%
figure('Name', 'Combustion');
%%
plotCombustion(combustionState);
%%
physicalDesignAssumptions = physicalDesignSimulationAssumptions(nozzleState, combustionState)
physicalDesignState = physicalDesignSimulation(physicalDesignAssumptions, nozzleState, combustionState)
physicalDesignOpts = physicalDesignState.opts
%%
figure('Name', 'Physical design');
%%
plotPhysicalDesign(physicalDesignState);

%%
flightAssumptions = flightSimulationAssumptions
flightState = flightSimulation(flightAssumptions, nozzleState, combustionState, physicalDesignState)
flightOpts = flightState.opts
%%
figure('Name', 'Flight physics');
%%
plotFlightPhysics(flightState);

%%
figure('Name', 'Flight');
%%
plotFlight(flightState);

close all