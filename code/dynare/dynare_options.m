
%% set up options for dynare

% demand aggregation
if round(param.peta, 4) == 1.0
    ind.cddemand = 1;
else
    ind.cddemand = 0;
end

% supply aggregation
if round(param.ptheta, 4) == 1.0
    ind.cdprod = 1;
else
    ind.cdprod = 0;
end

% domestic E-good ownership
if param.piota == 1
    ind.open = 0;
else
    ind.open = 1;
end

% E-good in consumption
if round(param.target_for_pgamma, 4) == 0
    ind.E_in_C = 0;
else
    ind.E_in_C = 1;
end

% energy in production
if round(param.target_for_palpha, 4) == 0.0
    ind.E_in_Y = 0;
else
    ind.E_in_Y = 1;
end

% E-supply regime
if param.regime_E == 1
    ind.regime_E = 1;
else
    ind.regime_E = 0;
end

% labor market
if param.labormarket == 0
    ind.labormarket = 0;
elseif param.labormarket == 1
    ind.labormarket = 1;
end

Opt.dynare_options = [ ...
    sprintf(...
    ' -Dcddemand=%d -Dcdprod=%d -Dopen=%d -DE_in_C=%d -DE_in_Y=%d -Dregime_E=%d -Dlabormarket=%d ', ...
    ind.cddemand, ind.cdprod, ind.open, ind.E_in_C, ind.E_in_Y, ind.regime_E, ind.labormarket ...
    ), ...
    ' nolog notime nopreprocessoroutput nostrict ' ...
    ];

%% some interdependencies

if round(param.target_for_pgamma, 4) == 0.0
    param.target_for_pebar = 0.0;
end
