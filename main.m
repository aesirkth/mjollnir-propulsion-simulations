run("./setup");
%% In order to execute this code, you need to have CoolProp installed. This can be done very fast if you follow the instructions given in:
% readmeCoolProp.txt
% on the highest level of the folder structure

%% Set up tank simulation
%{
0: approximation of tank pressure with linear decay
1: simulation with equilibrium model, coupled with combustion
2: simulation with equilibrium model, draining of tank to atmosphere
%}
tankModel = 0;

%%
setPlotMode("save");
% setPlotMode("show");

%%
nozzleAssumptions = nozzleSimulationAssumptions()
nozzleState = nozzleSimulation(nozzleAssumptions)

%%
combustionAssumptions = combustionSimulationAssumptions()
combustionState = combustionSimulation(combustionAssumptions, nozzleState, tankModel)
combustionOpts = combustionState.opts
%%
Fig = figure(1);
set(Fig, 'Name', 'Combustion');
plotCombustion(combustionState, tankModel);
drawnow
%%
physicalDesignAssumptions = physicalDesignSimulationAssumptions(nozzleState, combustionState)
physicalDesignState = physicalDesignSimulation(physicalDesignAssumptions, nozzleState, combustionState)
physicalDesignOpts = physicalDesignState.opts
%%
Fig = figure(2);
set(Fig, 'Name', 'Physical design');
plotPhysicalDesign(physicalDesignState,tankModel);
drawnow
%%
flightAssumptions = flightSimulationAssumptions
flightState = flightSimulation(flightAssumptions, nozzleState, combustionState, physicalDesignState)
flightOpts = flightState.opts
%%
Fig = figure(3);
set(Fig, 'Name', 'Flight physics');
plotFlightPhysics(flightState,tankModel);
drawnow
%%
Fig = figure(4);
set(Fig, 'Name', 'Flight');
plotFlight(flightState, tankModel);
drawnow