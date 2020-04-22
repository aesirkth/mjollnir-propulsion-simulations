% Compute thrust as function of mass flow, ambient pressure and other things
function thrust = thrustModel(t, massFlow, ccPressure, ambientPressure, cStar, opts)
    func = @(M) opts.input.nozzleState.NozzleExhaustArea / opts.input.nozzleState.NozzleThroatArea - 1/M*...
        (2/(opts.Gamma+1)*(1+(opts.Gamma-1)/2*M^2))^((opts.Gamma+1)/2/(opts.Gamma-1));

    Me = fzero(func,1.5);
    pe = ccPressure*(1+(opts.Gamma-1)/2*Me^2)^(opts.Gamma/(1-opts.Gamma));
    Cs = sqrt(2*opts.Gamma^2/(opts.Gamma-1)*(2/(opts.Gamma+1))^...
        ((opts.Gamma+1)/(opts.Gamma-1))*...
        (1-(pe/ccPressure)^((opts.Gamma-1)/opts.Gamma)))+...
        (pe-ambientPressure)/ccPressure*opts.input.nozzleState.NozzleExhaustArea/opts.input.nozzleState.NozzleThroatArea;
    Cs = max([Cs 0]);
    thrust = massFlow * cStar * Cs;
end