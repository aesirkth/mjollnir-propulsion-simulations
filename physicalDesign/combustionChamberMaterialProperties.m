% Material properties from: https://www.nedal.com/wp-content/uploads/2016/11/Nedal-alloy-Datasheet-EN-AW-6082.pdf

function [density, sigma, safetyMargin] = combustionChamberMaterialProperties()
    allowableStressAsFactorOfTensileStrength = 0.5;

    density = 2700;
    sigma = 290e6 * allowableStressAsFactorOfTensileStrength;
    
    safetyMargin = 1.5;
end