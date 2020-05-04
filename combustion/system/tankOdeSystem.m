% The simulation system
function [dXtank_dt, temperatureGradient_l, temperatureGradient_g, internalEnegeryGradient, massFlow, tankPressure, tankTemperature, wallTemperature_l, wallTemperature_g]  = tankOdeSystem(t, Xtank, Xcc, opts)
%% TO DO: 
% tank mass of the nodes could be changed to fit real shape of tanks
% (implement into mass and filling height calc)
% differentiate between p1 and p1,sat for mass flow calc (account for 
% pressure losses from tank to injector)
% get fluid state at injector outlet
%% Limitations
% doesnt account for acceleration and convective heat transfer in flight
% Q_fillinglvl doesnt take half-spherical end shapes of tank into account
%%
    % X is of the form  [T_wl, T_wg, U, m]
    %{
    Args:
        X (): state vector, containing the state variables:            
            T_wl ():    wall temperature (wetted with liquid)
            T_wg ():    wall temperature (wetted with gas)
            U ():       interal energy [J]
            m ():       oxidizer mass stored in tank [kg]
    %}
    
    T_wl = Xtank(1);
    T_wg = Xtank(2);
    U = Xtank(3);
    m = Xtank(4);
    
    if isnan(Xcc)
        ccPressure = opts.AmbientPressure;
    else
        ccPressure = Xcc(3);
    end
    
    tankVolume = opts.OxidizerVolume; 
    r_i = opts.tankDiameter/2;  
    r_o = r_i + opts.tankThickness;
    
    %% Set tank pressure according to constraint for bisection given in eq. (22) and (23) in Zimmerman2013.pdf
    % set temperature boundaries for bisection algorithm according to
    % temperature of previous time step
    global tankTemperature
    T_low = tankTemperature - 1;%0.001;
    T_up = tankTemperature + 1;%0.001;
    tankTemperature = tankVolumeConstraint_BisectionAlgorithm(m, U, tankVolume, T_low, T_up, 1E-6);    
    tankPressure = py.CoolProp.CoolProp.PropsSI('P','T',tankTemperature,'Q',0,'N2O');
%     disp(['N2O temperature ' num2str(tankTemperature)])
    
    %% Get fluid properties: N2O
    ox = oxidizerProperties(tankPressure);
    %% Calculate oxidizer mass flow
    massFlow = oxidizerMassFlowModel(tankPressure, ccPressure, ox.h_l, opts);
    %% Heat Transfer
    [temperatureGradient_l, temperatureGradient_g, mass_l, mass_g, Q_w_conv_in_l, Q_w_conv_in_g, wallTemperature_l, wallTemperature_g] = tankHeatTransferModel(opts, T_wl, T_wg, m, tankVolume, r_i, r_o, ox, opts.air, massFlow);
    
%     %% Run some checks
%     tol = 1E-3;
%     x_calc1 = mass_g/(mass_l+mass_g); 
%     x_calc2 = ((U/m) - ox.u_l) / (ox.u_g - ox.u_l);
%     if (abs(x_calc1 - x_calc2) > tol) && (x_calc1 > 0.01) && (mass_l > 0)
%         error('State of mass and internal energy inconsistent')
%     end
    %%
    Q_in = Q_w_conv_in_l + Q_w_conv_in_g;
    h_out = ox.h_l;
    
    internalEnegeryGradient = -massFlow*h_out + Q_in;
        
    dXtank_dt = [temperatureGradient_l; temperatureGradient_g; internalEnegeryGradient; -massFlow];
end
