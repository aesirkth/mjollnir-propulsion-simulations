function opts =  combustionSimulationAssumptions()
  addpath("./combustion/properties");
  addpath("./physicalDesign/properties"); % lol
%   opts = struct();
  run("./combustion/assumptions");
  
end