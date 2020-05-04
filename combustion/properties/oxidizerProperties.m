function ox = oxidizerProperties(p1)
% Get fluid properties: N2O

% Get table data for interpolation
run 'oxidizerProperties_interpol_data.m'

% liquid phase (% Q = 0: saturated liquid)
ox.cp_l = py.CoolProp.CoolProp.PropsSI('C','P',p1,'Q',0,'N2O');
ox.rho_l = py.CoolProp.CoolProp.PropsSI('D','P',p1,'Q',0,'N2O');
ox.T_l = py.CoolProp.CoolProp.PropsSI('T','P',p1,'Q',0,'N2O');
ox.mu_l = interp1(x_mu,v_mu_l,ox.T_l,'linear','extrap'); % interpolate viscosity from NOx.pdf
ox.k_l = interp1(x_k,v_k_l,ox.T_l,'linear','extrap'); % interpolate thermal conductivity from NOx.pdf

ox.h_l = py.CoolProp.CoolProp.PropsSI('H','P',p1,'Q',0,'N2O');
ox.u_l = py.CoolProp.CoolProp.PropsSI('U','P',p1,'Q',0,'N2O');

% gaseous phase (Q = 1: saturated vapor)
ox.cp_g = py.CoolProp.CoolProp.PropsSI('C','P',p1,'Q',1,'N2O');
ox.rho_g = py.CoolProp.CoolProp.PropsSI('D','P',p1,'Q',1,'N2O');
ox.T_g = py.CoolProp.CoolProp.PropsSI('T','P',p1,'Q',1,'N2O');
ox.mu_g = interp1(x_mu,v_mu_g,ox.T_g,'linear','extrap'); % interpolate viscosity from NOx.pdf
ox.k_g = interp1(x_k,v_k_g,ox.T_g,'linear','extrap'); % interpolate thermal conductivity from NOx.pdf

ox.u_g = py.CoolProp.CoolProp.PropsSI('U','P',p1,'Q',1,'N2O');

ox.M = py.CoolProp.CoolProp.PropsSI('M', 'N2O');

end

