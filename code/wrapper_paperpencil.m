%% Paper-pencil baseline --------------------------------------------------
% run the baseline calibration

Opt.comment_main = 'base';
Opt.disp_steady = 0;

% set parameters
run params_main.m
run changes_for_paperpencil.m
run calib_model_main.m
run calib_ppsi.m
run update_targets.m
run dynare_options.m

% load parameters of paper-pencil solution
param = compute_elasticities(param, SS, false);

param_base = param;
clear param

%% Loop over parameters ---------------------------------------------------
% recompute elasticities over a grid of parameters

n = 30;

% set up grids, including baseline values
loop_vec.regime_E = sort(unique(round([0, 1, param_base.regime_E], 6)));
loop_vec.piota = sort(unique(round([0, 1, param_base.piota], 6)));
loop_vec.palpha = sort(unique(round([linspace(0.01,0.3,n), param_base.palpha], 6)));
loop_vec.psigma = sort(unique(round([linspace(0.5,4,n), param_base.psigma], 6)));
loop_vec.pvarphi = sort(unique(round([linspace(0.5,4,n), param_base.pvarphi], 6)));
loop_vec.ptheta = sort(unique(round([linspace(0.02,0.5,n), param_base.ptheta], 6)));

% set up results matrices
iter_length = ...
    length(loop_vec.regime_E) * ...
    length(loop_vec.piota) * ...
    length(loop_vec.palpha) * ...
    length(loop_vec.psigma) * ...
    length(loop_vec.pvarphi) * ...
    length(loop_vec.ptheta);

results = zeros(iter_length, 6 + 18);

iter = 0;
for l_regime_E = 1:length(loop_vec.regime_E)
    for l_piota = 1:length(loop_vec.piota)
        for l_palpha = 1:length(loop_vec.palpha)
            for l_psigma = 1:length(loop_vec.psigma)
                for l_pvarphi = 1:length(loop_vec.pvarphi)
                    for l_ptheta = 1:length(loop_vec.ptheta)
                        
                        iter = iter + 1;
                        
                        % parameters for this iteration
                        param.regime_E = loop_vec.regime_E(l_regime_E);
                        param.piota = loop_vec.piota(l_piota);
                        param.palpha = loop_vec.palpha(l_palpha);
                        param.psigma = loop_vec.psigma(l_psigma);
                        param.pvarphi = loop_vec.pvarphi(l_pvarphi);
                        param.ptheta = loop_vec.ptheta(l_ptheta);
                        
                        % invariant parameters
                        param.pnu = param_base.pnu;
                        param.plambda = param_base.plambda;
                        param.pvartheta = param_base.pvartheta;
                        param.pepsilon = param_base.pepsilon;
                        param.ppsi = param_base.ppsi;
                        param.ptau_y = param_base.ptau_y;
                        
                        % steady state assumptions
                        SS.Y_G = 1;
                        SS.C = 1 - (1-param.piota) * param.palpha;
                        SS.N = 1;
                        SS.E = 1;
                        SS.w = 1 - param.palpha;
                        SS.N_H = SS.N;
                        SS.N_S = SS.N;
                        SS.C_H = SS.C;
                        SS.C_S = SS.C;
                        SS.MC = 1;
                        SS.xi_E = 1;
                        SS.p_E = param.palpha;
                        
                        % store current parameters
                        results(iter, 1:6) = [
                            param.regime_E;
                            param.piota;
                            param.palpha;
                            param.psigma;
                            param.pvarphi;
                            param.ptheta;
                            ];
                        
                        % store elasticities
                        results(iter, 7:end) = store_elasticities(param, SS);
                        
                    end
                end
            end
        end
    end
end

colnames = {'regime_E', 'piota', 'palpha', 'psigma', 'pvarphi', 'ptheta', ...
    'pGamma_MC', 'pGamma_E', 'pGamma_pE', 'pGamma_N', 'pGamma_w', 'pGamma_D', ...
    'pGamma_TH', 'pGamma_TS', 'pGamma_C', 'pGamma_CH', 'pGamma_CS', 'pGamma_NH', ...
    'pGamma_NS', 'pkappa_tilde', 'psigma_tilde', 'pdelta_tilde', 'slope_NKPC', 'slope_IS'};

% save Opt and results to disc at .mat file
save([Opt.respath, '/sensitivity/', 'slopes_paperpencil.mat'], 'Opt', 'results', 'loop_vec', 'param_base', 'colnames');

%% helper functions

function [out] = store_elasticities(param, SS)

% load parameters of paper-pencil solution
param = compute_elasticities(param, SS, false);

% store results as vector
out = [
    param.pGamma_MC; % 1
    param.pGamma_E; % 2
    param.pGamma_pE; % 3
    param.pGamma_N; % 4
    param.pGamma_w; % 5
    param.pGamma_D; % 6
    param.pGamma_TH; % 7
    param.pGamma_TS; % 8
    param.pGamma_C; % 9
    param.pGamma_CH; % 10
    param.pGamma_CS; % 11
    param.pGamma_NH; % 12
    param.pGamma_NS; % 13
    param.pkappa_tilde; % 14
    param.psigma_tilde; % 15
    param.pdelta_tilde; % 16
    param.slope_NKPC; % 17
    param.slope_IS; % 18
    ];

end
