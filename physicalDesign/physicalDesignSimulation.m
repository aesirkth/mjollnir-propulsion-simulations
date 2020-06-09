function physicalDesignState = physicalDesignSimulation(opts, nozzleState, combustionState)
  addpath('./physicalDesign/models');
  addpath('./physicalDesign/properties');

  opts.input = struct( ...
    "nozzleState", nozzleState, ...
    "combustionState", combustionState ...
  );

  run("./physicalDesign/derivedProperties");

  physicalDesignState = struct();
  physicalDesignState.opts = opts;

  physicalDesignState.oxidizerTankMass = opts.OxidizerTankMass;
  physicalDesignState.engineMass = opts.EngineFixedMass + opts.ccMass;
  physicalDesignState.fuelGrainUnusableMass = combustionState.opts.UnusableFuelMass + opts.fuelGrainCasingMass;
  
  physicalDesignState.engineDryMass = opts.OxidizerTankMass + opts.EngineFixedMass + opts.ccMass + combustionState.opts.UnusableFuelMass + opts.fuelGrainCasingMass;
  physicalDesignState.propellantMass = combustionState.opts.OxidizerMass + combustionState.opts.FuelMass;
  physicalDesignState.oxidizerMass = combustionState.opts.OxidizerMass;
  physicalDesignState.fuelMass = combustionState.opts.FuelMass;
end