function opts = oxidizerProperties_create_interpolationtables(Tmin,Tmax,Tstep,pmin,pmax,pstep)

% Temperature dependency
opts.oxidizerData.T = Tmin:Tstep:Tmax;
opts.oxidizerData.T_mu = [182.33, 184.69, [185:5:300]];
opts.oxidizerData.T_k = [182.33, 184.69, [185:5:280]];

for ii = 1:length(opts.oxidizerData.T)
    % liquid phase
    opts.oxidizerData.cp_l(ii) = py.CoolProp.CoolProp.PropsSI('C','T',opts.oxidizerData.T(ii),'Q',0,'N2O');
    opts.oxidizerData.rho_l(ii) = py.CoolProp.CoolProp.PropsSI('D','T',opts.oxidizerData.T(ii),'Q',0,'N2O');
    opts.oxidizerData.h_l(ii) = py.CoolProp.CoolProp.PropsSI('H','T',opts.oxidizerData.T(ii),'Q',0,'N2O');
    opts.oxidizerData.u_l(ii) = py.CoolProp.CoolProp.PropsSI('U','T',opts.oxidizerData.T(ii),'Q',0,'N2O');   

    % gaseous phase
    opts.oxidizerData.cp_g(ii) = py.CoolProp.CoolProp.PropsSI('C','T',opts.oxidizerData.T(ii),'Q',1,'N2O');
    opts.oxidizerData.rho_g(ii) = py.CoolProp.CoolProp.PropsSI('D','T',opts.oxidizerData.T(ii),'Q',1,'N2O');
    opts.oxidizerData.h_g(ii) = py.CoolProp.CoolProp.PropsSI('H','T',opts.oxidizerData.T(ii),'Q',1,'N2O');
    opts.oxidizerData.u_g(ii) = py.CoolProp.CoolProp.PropsSI('U','T',opts.oxidizerData.T(ii),'Q',1,'N2O');
end

opts.oxidizerData.mu_l = 1e-3*[0.4619,0.4306,0.4267,0.3705,0.3244,0.2861,0.2542,0.2272,0.2042,0.1846,0.1676,0.1528,0.1399,0.1284,0.1183,0.1093,0.1012,0.0939,0.0872,0.0810,0.0754,0.0700,0.0650,0.0601,0.0552,0.0501];
opts.oxidizerData.mu_g = 1e-6*[9.4,9.6,9.6,9.8,10.1,10.3,10.6,10.9,11.1,11.4,11.7,12.0,12.3,12.6,12.9,13.3,13.7,14.0,14.4,14.9,15.4,15.9,16.5,17.2,18.1,19.2];
opts.oxidizerData.k_l = 1e-3*[146.9,145.6,145.5,142.8,140.2,137.6,135.1,132.6,130.0,127.6,125.1,122.7,120.3,117.9,115.6,113.3,111.0,108.7,106.5,104.4,102.2,100.1];
opts.oxidizerData.k_g = 1e-3*[8.2,8.4,8.4,8.9,9.3,9.7,10.2,10.7,11.2,11.7,12.2,12.8,13.4,14.0,14.7,15.3,16.1,16.8,17.6,18.5,19.5,20.6];

% Pressure dependency
opts.oxidizerData.p = pmin:pstep:pmax;

for ii = 1:length(opts.oxidizerData.p)
    % liquid phase
    opts.oxidizerData.s_l(ii) = py.CoolProp.CoolProp.PropsSI('S','P',opts.oxidizerData.p(ii),'Q',0,'N2O'); 
%     opts.oxidizerData.h_sconst(ii) = py.CoolProp.CoolProp.PropsSI('H','P',opts.oxidizerData.p(ii),'S',opts.oxidizerData.s_l(ii),'N2O'); % get enthalpy assuming constant entropy
%     opts.oxidizerData.rho_sconst(ii) = py.CoolProp.CoolProp.PropsSI('D','P',opts.oxidizerData.p(ii),'S',opts.oxidizerData.s_l(ii),'N2O'); % get density assuming constant entropy
end