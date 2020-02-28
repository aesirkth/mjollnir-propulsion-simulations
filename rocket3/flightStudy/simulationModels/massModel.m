% Mass of the rocket as function of time
function mass = massModel(t, dryMass, propellantMass)
    mass = dryMass + propellantMass;
end
