function cStar = characteristicVelocity(oxidizerMassFlow,fuelMassFlow)
if fuelMassFlow <= 0
    cStar = 0;
else
    of = oxidizerMassFlow / fuelMassFlow;
    if of>=10
        cStar = 1580;
    elseif of<=0
        cStar = 0;
    else
        OF = [0 1 4 6 7 10]';
        C = [0 1100 1500 1610 1620 1580]';
        cStar = interp1q(OF,C,of);
    end
end
end