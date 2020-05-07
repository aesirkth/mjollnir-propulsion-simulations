function cStar = characteristicVelocity(opts,ccPressure,oxidizerMassFlow,fuelMassFlow)
if fuelMassFlow <= 0
    cStar = 0;
else
    of = oxidizerMassFlow / fuelMassFlow;
 
    ccPressureBars = ccPressure / 1e5;
    cStar = interp2(opts.cstarInterpol.pressures, opts.cstarInterpol.ofRatios, opts.cstarInterpol.cStars, ccPressureBars, of, 'linear', 1500);
end
end