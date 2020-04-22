function physicalDesignState = physicalDesignSimulation(opts, nozzleState, combustionState)
  addpath('./physicalDesign/models');
  addpath('./physicalDesign/properties');

  opts.input = struct( ...
    "nozzleState", nozzleState, ...
    "combustionState", combustionState ...
  );

  run("./physicalDesign/derivedProperties");

  physicalDesignState = struct();
end