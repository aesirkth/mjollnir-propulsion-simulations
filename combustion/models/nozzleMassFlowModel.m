function massFlow = nozzleMassFlowModel(ccPressure,cStar,opts)
if cStar <= 0
    massFlow = 0;
else
    massFlow = opts.input.nozzleState.NozzleThroatArea * ccPressure / cStar;
end

end