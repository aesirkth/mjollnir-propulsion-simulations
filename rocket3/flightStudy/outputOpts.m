function outputOpts(opts)
    fprintf("Assumptions:\n");
    fprintf("  Oxidizer-fuel ratio: %.2f\n", opts.OxidizerFuelRatio);
    fprintf("  Non-engine dry mass: %.2f kg\n", opts.PayloadMass);
    fprintf("  Rocket diameter: %.1f cm\n", 1e2*opts.Radius*2);
    fprintf("  Combustion chamber diameter: %.1f cm\n", 1e2*opts.CombustionChamberDiameter);
    fprintf("  Fuel margin thickness: %.1f mm\n", 1e3*opts.FuelGrainMarginThickness);
    fprintf("  Fuel grain length: %.1f cm\n", 1e2*opts.FuelGrainLength);
    fprintf("  Fuel grain port diameter: %.1f cm\n", 1e2*opts.FuelGrainPortRadius*2);
    fprintf("  Isp: %.1f s\n", opts.Isp);
    fprintf("  Nozzle expansion pressure: %.1f atm\n", opts.ExpansionPressure / 101300);
    fprintf("  Mass flow: %.1f kg/s\n", opts.MassFlow);
    fprintf("  Launch angle: %.1f degrees\n", opts.LaunchAngle);
    fprintf("  Oxidizer tank pressure: %.2f MPa\n", opts.OxidizerTankPressure/1e6);
    fprintf("  Combustion pressure: %.2f MPa\n", opts.CombustionChamberPressure/1e6);
    
    fprintf("  Material properties:\n");
    fprintf("    Oxidizer density: %.0f kg/m^3\n", opts.OxidizerDensity);
    fprintf("    Fuel density: %.0f kg/m^3\n", opts.FuelDensity);
    fprintf("    Oxidizer tank:\n");
    fprintf("      Material density: %.0f kg/m^3\n", opts.OxidizerTankDensity);
    fprintf("      Sigma: %.1f [MPa]\n", opts.OxidizerTankSigma/1e6);
    fprintf("      Safety margin: %.1fx\n", opts.OxidizerTankSafetyMargin);
    fprintf("    Combustion chamber:\n");
    fprintf("      Material density: %.0f kg/m^3\n", opts.CombustionChamberDensity);
    fprintf("      Sigma: %.1f [MPa]\n", opts.CombustionChamberSigma/1e6);
    fprintf("      Safety margin: %.1fx\n", opts.CombustionChamberSafetyMargin);
    
    fprintf("Dimensions (assumed pressure vessels with hemispherical ends):\n");
    fprintf("  Oxidizer tank:\n");
    fprintf("    Radius: %.2f cm\n", 1e2*opts.OxidizerTankRadius);
    fprintf("    Diameter: %.2f cm\n", 1e2*opts.OxidizerTankDiameter);
    fprintf("    Thickness: %.2f mm\n", 1e3*opts.OxidizerTankWallThickness);
    fprintf("    Length (cylinder part): %.2f cm\n", 1e2*opts.OxidizerTankLength);
    fprintf("    Volume: %.2f l\n", 10*10*10*opts.OxidizerVolume);
    fprintf("    Mass: %.2f kg\n", opts.OxidizerTankMass);
    fprintf("  Combustion chamber:\n");
    fprintf("    Radius: %.2f cm\n", 1e2*opts.CombustionChamberRadius);
    fprintf("    Diameter: %.2f cm\n", 1e2*opts.CombustionChamberDiameter);
    fprintf("    Thickness: %.2f mm\n", 1e3*opts.CombustionChamberWallThickness);
    fprintf("    Length (cylinder part): %.2f cm\n", 1e2*opts.CombustionChamberLength);
    fprintf("    Volume: %.2f l\n", 10*10*10*opts.FuelVolume);
    fprintf("    Mass: %.2f kg\n", opts.CombustionChamberMass);
    
    fprintf("Masses:\n");
    fprintf("  Dry: %.2f kg\n", opts.DryMass);
    fprintf("  Wet: %.2f kg\n", opts.WetMass);
    fprintf("  Propellant: %.2f kg\n", opts.PropellantMass);
    fprintf("   - Oxidizer: %.2f kg\n", opts.OxidizerMass);
    fprintf("   - Fuel: %.2f kg\n", opts.FuelMass);
    fprintf("  Parachute: %.2f kg\n", opts.ParachuteMass);
    fprintf("  Electronics: %.2f kg\n", opts.ElectronicsMass);
    fprintf("  Body tube: %.2f kg\n", opts.BodyTubeMass);
    fprintf("  Payload (misc): %.2f kg\n", opts.PayloadMass);
    fprintf("  Oxidizer tank: %.2f kg\n", opts.OxidizerTankMass);
    fprintf("  Engine mass: %.2f kg\n", opts.EngineMass);
    fprintf("   - Fixed: %.2f kg\n", opts.FixedEngineMass);
    fprintf("   - Combustion chamber: %.2f kg\n", opts.CombustionChamberMass);
    
    fprintf("Engine properties:\n");
    fprintf("  Thrust: %.2f kN\n", opts.Thrust/1e3);
    fprintf("  Burn time: %.1f s\n", opts.BurnTime);
    fprintf("  Mass flow: %.2f kg/s\n", opts.MassFlow);
    fprintf("    Oxidizer flow: %.2f kg/s\n", opts.MassFlow * (opts.OxidizerFuelRatio) / (opts.OxidizerFuelRatio + 1));
end