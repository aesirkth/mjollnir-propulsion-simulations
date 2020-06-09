% Material properties from: https://www.nedal.com/wp-content/uploads/2016/11/Nedal-alloy-Datasheet-EN-AW-6082.pdf

function [density, sigma] = combustionChamberMaterialProperties()
    allowableStressAsFactorOfTensileStrength = 1.0;

    density = 2700;
    sigma = 250e6 * allowableStressAsFactorOfTensileStrength;
end