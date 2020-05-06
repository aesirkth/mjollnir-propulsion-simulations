function ox = oxidizerPropertiesTemperature(method,T, props, opts)
%{
Args:
    T (double):     temperature for the given state [K]
    props (cell):   properties which are to be determined for the given state define by T, contains strings
Returns:
    ox(struct):     contains fields in which the desired fluid properties of the given state are stores
%}

% Get fluid props: N2O
% liquid phase (% Q = 0: saturated liquid)
% gaseous phase (Q = 1: saturated vapor)

% Get data for interpolation

if strcmp(method, 'interp')
    
    for zz = 1:length(props)
        if strcmp(props{zz}, 'rho_l')
            ox.rho_l = interp1(opts.oxidizerData.T, opts.oxidizerData.rho_l, T);
        elseif strcmp(props{zz}, 'rho_g')
            ox.rho_g = interp1(opts.oxidizerData.T, opts.oxidizerData.rho_g, T);
        elseif strcmp(props{zz}, 'u_l')
            ox.u_l = interp1(opts.oxidizerData.T, opts.oxidizerData.u_l, T);
        elseif strcmp(props{zz}, 'u_g')
            ox.u_g = interp1(opts.oxidizerData.T, opts.oxidizerData.u_g, T);
        elseif strcmp(props{zz}, 'p')
            ox.p = py.CoolProp.CoolProp.PropsSI('P','T',T,'Q',0,'N2O');
        elseif strcmp(props{zz}, 'cp_l')
            ox.cp_l = interp1(opts.oxidizerData.T, opts.oxidizerData.cp_l, T);
        elseif strcmp(props{zz}, 'mu_l')
            ox.mu_l = interp1(opts.oxidizerData.T_mu,opts.oxidizerData.mu_l,T,'linear','extrap'); % interpolate viscosity from NOx.pdf
        elseif strcmp(props{zz}, 'k_l')
            ox.k_l = interp1(opts.oxidizerData.T_k,opts.oxidizerData.k_l,T,'linear','extrap'); % interpolate thermal conductivity from NOx.pdf
        elseif strcmp(props{zz}, 'h_l')
            ox.h_l = interp1(opts.oxidizerData.T, opts.oxidizerData.h_l, T);
        elseif strcmp(props{zz}, 'cp_g')
            ox.cp_g = interp1(opts.oxidizerData.T, opts.oxidizerData.cp_g, T);
        elseif strcmp(props{zz}, 'mu_g')
            ox.mu_g = interp1(opts.oxidizerData.T_mu,opts.oxidizerData.mu_g,T,'linear','extrap'); % interpolate viscosity from NOx.pdf
        elseif strcmp(props{zz}, 'k_g')
            ox.k_g = interp1(opts.oxidizerData.T_k,opts.oxidizerData.k_g,T,'linear','extrap'); % interpolate thermal conductivity from NOx.pdf
        elseif strcmp(props{zz}, 'h_g')
            ox.h_g = interp1(opts.oxidizerData.T, opts.oxidizerData.h_g, T);
        end
    end
    
elseif strcmp(method, 'coolprop')
    
    for zz = 1:length(props)
        if strcmp(props{zz}, 'rho_l')
            ox.rho_l = py.CoolProp.CoolProp.PropsSI('D','T',T,'Q',0,'N2O');
        elseif strcmp(props{zz}, 'rho_g')
            ox.rho_g = py.CoolProp.CoolProp.PropsSI('D','T',T,'Q',1,'N2O');
        elseif strcmp(props{zz}, 'u_l')
            ox.u_l = py.CoolProp.CoolProp.PropsSI('U','T',T,'Q',0,'N2O');
        elseif strcmp(props{zz}, 'u_g')
            ox.u_g = py.CoolProp.CoolProp.PropsSI('U','T',T,'Q',1,'N2O');
        elseif strcmp(props{zz}, 'p')
            ox.p = py.CoolProp.CoolProp.PropsSI('P','T',T,'Q',0,'N2O');
        elseif strcmp(props{zz}, 'cp_l')
            ox.cp_l = py.CoolProp.CoolProp.PropsSI('C','T',T,'Q',0,'N2O');
        elseif strcmp(props{zz}, 'mu_l')
            ox.mu_l = interp1(opts.oxidizerData.T_mu,opts.oxidizerData.mu_l,T,'linear','extrap'); % interpolate viscosity from NOx.pdf
        elseif strcmp(props{zz}, 'k_l')
            ox.k_l = interp1(opts.oxidizerData.T_k,opts.oxidizerData.k_l,T,'linear','extrap'); % interpolate thermal conductivity from NOx.pdf
        elseif strcmp(props{zz}, 'h_l')
            ox.h_l = py.CoolProp.CoolProp.PropsSI('H','T',T,'Q',0,'N2O');
        elseif strcmp(props{zz}, 'cp_g')
            ox.cp_g = py.CoolProp.CoolProp.PropsSI('C','T',T,'Q',1,'N2O');
        elseif strcmp(props{zz}, 'mu_g')
            ox.mu_g = interp1(opts.oxidizerData.T_mu,opts.oxidizerData.mu_g,T,'linear','extrap'); % interpolate viscosity from NOx.pdf
        elseif strcmp(props{zz}, 'k_g')
            ox.k_g = interp1(opts.oxidizerData.T_k,opts.oxidizerData.k_g,T,'linear','extrap'); % interpolate thermal conductivity from NOx.pdf
        elseif strcmp(props{zz}, 'h_g')
            ox.h_g = py.CoolProp.CoolProp.PropsSI('H','T',T,'Q',1,'N2O');
        end
    end
    
end
end


