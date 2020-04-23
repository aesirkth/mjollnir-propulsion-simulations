# Mjollnir Propulsion Simulations

A collection of simulations done for the propulsion system of the Mjollnir project.
The main file is [`./main.m`](./main.m). No other file should be run in isolation. In this file, one can choose to save plots by changing the plot mode:

```
setPlotMode("show"); % This shows figures in plot windows


setPlotMode("save"); % This save figures to files
```

## Structure

There are currently 4 different simulation models.

- [(`./nozzle`)](./nozzle) - Nozzle
- [(`./combustion`)](./combustion) - Combustion
- [(`./physicalDesign`)](./physicalDesign) - Physical design (tanks, masses, etc)
- [(`./flight`)](./flight) - Flight

In each model folder, there are typically a specific set of files:

- `assumptions.m` - Contains all the assumptions necessary for each simulation model. This file is where one typically changes things to alter the simulation!
- `derivedProperties.m` - Contains derived properties necessary for each simulation model. This file does not contain any assumptions!
- `plot<FolderNameOrSimilar>.m` - A file containing a function that runs `createPlots.m` or a similarly named file.
- `createPlots.m` (or similarly named) - A file containing plotting routines for the specific model
- `<folderName>SimulationAssumptions.m` - Contains a function that returns the assumptions for the simulation. The return value can be modified before passing it to the simulation function.
- `<folderName>Simulation.m` - Contains a function with code necessary to run simulation. Takes in output from other simulation models as well as the assumptions, and returns an output state.

There are also typically 3 folders:

- `models` - Contains all the smaller models that are necessary for the simulation.
- `properties` - Contains material and similar properties, which technically are mostly assumptions, but things that we can't really change.
- `system` - Contains any functions or code necessary to simulate the model using an ODE/PDE solver.
