function massFlow = oxidizerMassFlowModel(tankPressure,combustionChamberPressure,tankSpecificEnthalpy,opts)
  
if combustionChamberPressure < tankPressure
    kappa = sqrt((tankPressure - combustionChamberPressure) / (tankPressure - combustionChamberPressure)); % right now this always results in kappa = 1, assumption: fluid entering injector with saturation pressure
    massFlowSPI = opts.InjectorsCd * opts.InjectorsArea * sqrt(2* opts.OxidizerDensity * (tankPressure - combustionChamberPressure));

    % Calculate specific enthalpy downstream of injector assuming
    ox_upstream = oxidizerPropertiesPressure('interp', tankPressure,[], {'s_l'}, opts);
    ox_downstream = oxidizerPropertiesPressure('coolprop', combustionChamberPressure,ox_upstream.s_l, {'h_sconst', 'rho_sconst'}, opts);
    massFlowHEM = opts.InjectorsCd * opts.InjectorsArea * ox_downstream.rho_sconst * sqrt(2 * (tankSpecificEnthalpy - ox_downstream.h_sconst));
    massFlow = (kappa * massFlowSPI + massFlowHEM) / (1 + kappa);
    
%     py.CoolProp.CoolProp.PhaseSI('P',combustionChamberPressure,'H',downstreaminjectorSpecificEnthalpy,'N2O')
%         py.CoolProp.CoolProp.PropsSI('Phase','P',combustionChamberPressure,'H',downstreaminjectorSpecificEnthalpy,'N2O')
%         
%     downstreaminjectorTemperature = py.CoolProp.CoolProp.PropsSI('T','P',combustionChamberPressure,'S',tankEntropy,'N2O');
%     rho_l = py.CoolProp.CoolProp.PropsSI('D','T',downstreaminjectorTemperature,'Q',0,'N2O');
%     rho_g = py.CoolProp.CoolProp.PropsSI('D','T',downstreaminjectorTemperature,'Q',1,'N2O');

else
    massFlow = 0;
end
    
end