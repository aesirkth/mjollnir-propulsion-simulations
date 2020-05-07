function opts = nozzleSimulationAssumptions()
  opts = struct();
  addpath("./combustion/properties");
  run("./nozzle/assumptions");
end