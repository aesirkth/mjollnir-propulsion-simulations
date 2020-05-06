function opts =  combustionSimulationAssumptions()
  addpath("./combustion/properties");
%   opts = struct();
  opts = oxidizerProperties_create_interpolationtables(200,305,0.1,1e5,60e5,1000);
  run("./combustion/assumptions");
  
end