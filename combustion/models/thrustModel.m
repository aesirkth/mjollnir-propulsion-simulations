% Compute thrust as function of mass flow, ambient pressure and other things
function [thrust, exhaustMach, exhaustPressure, thrustCoefficient] = thrustModel(t, massFlow, ccPressure, ambientPressure, cStar, opts)
    func = @(M) opts.input.nozzleState.NozzleExhaustArea / opts.input.nozzleState.NozzleThroatArea - 1/M*...
        (2/(opts.Gamma+1)*(1+(opts.Gamma-1)/2*M^2))^((opts.Gamma+1)/2/(opts.Gamma-1));
    
    k = opts.Gamma;
    
    Me = fzero(func,1.5);
    pe = ccPressure*(1+(opts.Gamma-1)/2*Me^2)^(opts.Gamma/(1-opts.Gamma));
    
    %if Me < 1.0
       %error("Me < 1.0 (%.8f < 1.0)", Me); 
    %end
    if pe > ccPressure
       error("pe > ccPressure (%.8f MPa > %.8f MPa)", pe/1e6, ccPressure/1e6); 
    end
    
    Cs = sqrt(...
        2*k^2/(k-1)*(2/(k+1))^((k+1)/(k-1)) *...
        (1-(pe/ccPressure)^((k-1)/k)) ...
        ) + ...
        (pe - ambientPressure)/ccPressure * ...
        opts.input.nozzleState.NozzleExhaustArea/opts.input.nozzleState.NozzleThroatArea;
    Cs = max([Cs 0]);
    
    exhaustMach = Me;
    exhaustPressure = pe;
    thrustCoefficient = Cs;
    thrust = massFlow * cStar * Cs;
end