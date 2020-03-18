% Calculate massflow
function massFlow = massFlowModel(t, burnTime, initialMassFlow, propellantMass)
    massFlow = 0;
    
    pressureDecreaseAtEndOfVapor = 0.15;
    
    factor = sqrt(1 - pressureDecreaseAtEndOfVapor*min(1, t/burnTime));
    if propellantMass < 1
        massFlow = factor*initialMassFlow * propellantMass;
    elseif propellantMass > 0
        massFlow = factor*initialMassFlow;
    end    
end