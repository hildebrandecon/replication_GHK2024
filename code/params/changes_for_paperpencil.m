% parametric assumptions required for closed form solution

% inelastic energy supply
param.regime_E = 1;

% no energy in consumption
param.target_for_pgamma = 0.0;
param.target_for_pebar = 0.0;

% target for energy in production
param.target_for_palpha = 0.081; % this is to match palpha & ppsi as in quantitative exercise

% unit MPC of Foreign
param.pmu_1 = 1.0;

% labor market setting
param.pepsilon_w = 10000.0;
param.labormarket = 0;
param.ptau_w = 0.0;

% no energy price subsidies
param.ptau_e_f = 0.0;
param.ptau_e_c = 0.0;