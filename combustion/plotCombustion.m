function plotCombustion(combustionState, tankModel)
    if tankModel == 0
      filepath = './combustion/simulation_without_tank';
      mkdir(filepath)
    elseif tankModel == 1
      filepath = './combustion/simulation_with_tank';
      mkdir(filepath)
    elseif tankModel == 2
      filepath = './combustion/simulation_tank_drain_to_atmosphere';
      mkdir(filepath)
    end
    run("./combustion/createPlots");
end