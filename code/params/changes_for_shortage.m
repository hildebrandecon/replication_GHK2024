
sh_E_in_GDP = param.target_for_pgamma + param.target_for_palpha;

% switch of forced symmetry
param.target_for_inequality = NaN;

% switch on inelastic energy supply
param.regime_E = 1;

% select target for energy supply level
factor = 1;

if Opt.crisis == 1
    
    % switch on fiscal intervention
    param.ptau_e_f = 0.33;
    param.ptau_e_c = 0.33;
    
    % select target for energy supply level
    factor = 2;
    
    % make wages flexible
    param.labormarket = 0;
    param.ppsi_w = 0;
    
end

param.target_for_sh_E_in_GDP = sh_E_in_GDP * factor;