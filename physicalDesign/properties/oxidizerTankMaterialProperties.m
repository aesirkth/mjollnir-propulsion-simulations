% Material properties from: https://www.nedal.com/wp-content/uploads/2016/11/Nedal-alloy-Datasheet-EN-AW-6082.pdf

function [density, sigma, thermalConductivity, specificHeat] = oxidizerTankMaterialProperties()
    allowableStressAsFactorOfTensileStrength = 1.0;

    density = 2700;
    sigma = 250e6 * allowableStressAsFactorOfTensileStrength;


    thermalConductivity = 195;  % average value from datasheet (170-220) 
    specificHeat = 896;  % https://www.leichtmetall.eu/site/assets/files/datenblatt/6082_Produktdatenblatt_A4-en_us.pdf
end