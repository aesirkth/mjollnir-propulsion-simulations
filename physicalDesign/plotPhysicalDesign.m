function plotPhysicalDesign(physicalDesignState, tankModel)

if tankModel == 0
    filepath = './physicalDesign/simulation_without_tank';
    mkdir(filepath)
elseif tankModel == 1
    filepath = './physicalDesign/simulation_with_tank';
    mkdir(filepath)
elseif tankModel == 2
    filepath = './physicalDesign/simulation_tank_drain_to_atmosphere';
    mkdir(filepath)
end
run("./physicalDesign/createPlots");

end