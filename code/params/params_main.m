
if ~isfield(Opt,'comment')
    Opt.comment = '';
end
if ~isfield(Opt,'hank')
    Opt.hank = 'tank';
end

%% Baseline parameterization
% set Table 1 in the paper, top panel

% shock processes
param.prho_xi_E = 0.97;
param.prho_p_E = 0.97;
param.prho_R = 0.5;
param.prho_T = 0.5;
param.prho_omega = 0.5;

% preferences
param.pbeta = 0.995;
param.psigma = 2;
param.pvarphi = 3;
% pchi is calibrated later
param.plambda = 0.24;
% pebar is calibrated later
% pgamma is calibrated later
param.peta = 0.1;

% production
param.pepsilon = 11;
% ppsi is calibrated later
% palpha is calibrated later
param.ptheta = 0.1;

% labor market
param.pepsilon_w = 11;
% ppsi_w is calibrated later
param.labormarket = 1; % indicator: 0 for flexible wages case, 1 for sticky wages case

% energy, foreign
param.piota = 1/3; % zero means all energy is imported
% p_E is calibrated later (and stored in steady state, not as parameter)
param.pmu_1 = 0.25;
param.pmu_2 = 0.02;
param.regime_E = 0; % indicator: 0 for fixed-price regime, 1 for fixed-quantity regime

% government
param.ptau_y = param.pepsilon/(param.pepsilon-1) - 1;
param.ptau_w = param.pepsilon_w/(param.pepsilon_w-1) - 1;
param.pnu = 0.0;
param.pvartheta = 0.0;
% Tbar is calibrated later
param.pphi_pi = 1000.0; % set to something arbitrarily large for now
param.pphi_pi_baseline = 1.5; % baseline value for pphi_pi
param.ptau_e_c = 0.0;
param.ptau_e_f = 0.0;

%% Calibration targets: normal steady state
% see Table 2 in the paper, P/Q scenario

param.target_for_pgamma = 0.04; % households' expenditure share of energy/GDP
param.target_for_palpha = 0.08; % firms' expenditure share of energy/GDP
param.target_for_pebar = 0.25; % households' subsistence energy share
param.target_for_PC = 0.1; % slope of the Phillips curve
param.target_for_N = 1.0; % labor supply
param.target_for_E_or_C_E = 1.0; % energy in production or consumption (depending on model version)
param.target_for_inequality = 1.0; % consumption inequality

%% Special cases for calibration

% RANK calibration
if strcmp(Opt.hank,'rank')
    param.pnu = param.plambda;
    param.pvartheta = param.plambda;
end

% closed economy, all energy owned domestically
if contains(Opt.comment_main,'closed')
    param.piota = 1.0;
end

% open economy, no energy owned domestically
if contains(Opt.comment_main,'open')
    param.piota = 0.0;
end

% high foreign MPC
if contains(Opt.comment_main,'highmpc')
    param.pmu_1 = 0.5;
end

% domestic energy proportionally owned by HtM households
if contains(Opt.comment_main,'htmownership')
    param.pvartheta = param.plambda;
end
