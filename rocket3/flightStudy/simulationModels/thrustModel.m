% Compute thrust as function of mass flow, ambient pressure and other things
function thrust = thrustModel(t, massFlow, ambientPressure, opts)
    pressureCutoffEpsilon = 1e-1; % The mass flow for when we set thrust to 0
    pressureFactor = min(pressureCutoffEpsilon, massFlow) / pressureCutoffEpsilon;
    thrustForce = opts.Isp * 9.8066 * massFlow + pressureFactor*(opts.ExpansionPressure - ambientPressure) * opts.ExhaustArea;
    thrust = thrustForce;
end