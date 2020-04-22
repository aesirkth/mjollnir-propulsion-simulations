function opts = physicalDesignSimulationAssumptions(nozzleState, combustionState)
  addpath("./physicalDesign/properties");
  opts = struct();
  run("./physicalDesign/assumptions");
end