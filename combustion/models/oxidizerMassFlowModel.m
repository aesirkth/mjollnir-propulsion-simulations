function massFlow = oxidizerMassFlowModel(tankPressure,combustionChamberPressure,tankSpecificEnthalpy,opts)
  
if combustionChamberPressure < tankPressure
    kappa = sqrt((tankPressure - combustionChamberPressure) / (tankPressure - combustionChamberPressure)); % right now this always results in kappa = 1, assumption: fluid entering injector with saturation pressure
    massFlowSPI = opts.InjectorsCd * opts.InjectorsArea * sqrt(2* opts.OxidizerDensity * (tankPressure - combustionChamberPressure));

    % Calculate specific enthalpy downstream of injector assuming
    tankEntropy = py.CoolProp.CoolProp.PropsSI('S','P',tankPressure,'Q',0,'N2O');                % mass specific entropy
    downstreaminjectorSpecificEnthalpy = py.CoolProp.CoolProp.PropsSI('H','P',combustionChamberPressure,'S',tankEntropy,'N2O'); % get downstream enthalpy assuming constant entropy
    downstreaminjectorDensity = py.CoolProp.CoolProp.PropsSI('D','P',combustionChamberPressure,'S',tankEntropy,'N2O');
    massFlowHEM = opts.InjectorsCd * opts.InjectorsArea * downstreaminjectorDensity * sqrt(2 * (tankSpecificEnthalpy - downstreaminjectorSpecificEnthalpy));
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