% this computes the IRFs for the model with different monetary policy rules,
% both, under active and passive monetary policy
% and saves the results in a .mat file
% note: cannot be put into a function since dynare runs in the base workspace

temp_Opt = Opt;

for temp_mp_rule = Opt.irf_sel
    
    Opt.mp_rule = temp_mp_rule;
    
    if isempty(find(Opt.det_sel == temp_mp_rule, 1))
        continue;
    end
    
    results = struct();
    Opt.temp_pphi_pi = param.pphi_pi; Opt.temp_prho_omega = param.prho_omega;
    
    % active monetary policy
    param.pphi_pi = max(param.pphi_pi_baseline, detregion(Opt.mp_rule, 2) + 0.01);
    param.prho_omega = 0.5;
    
    failed_run = run_dynare(Opt, 'mp_rule', Opt.mp_rule, 'verbose', 0);
    if failed_run == 1
        fprintf('[Active] Could not compute IRFs: policy rule %d, pphi_pi = %.2f and prho_omega = %.2f\n', Opt.mp_rule, param.pphi_pi, param.prho_omega)
    else
        fprintf('[Active] IRFs computed: policy rule %d, pphi_pi = %.2f and prho_omega = %.2f\n', Opt.mp_rule, param.pphi_pi, param.prho_omega)
    end
    
    results.det_a = store_irfs(store_info, oo_, M_);
    results.det_a.pphi_pi = param.pphi_pi;
    results.det_a.prho_omega = param.prho_omega;
    
    param.pphi_pi = Opt.temp_pphi_pi;
    param.prho_omega = Opt.temp_prho_omega;
    
    % (potentially) passive monetary policy
    param.pphi_pi = param.pphi_pi_baseline;
    param.prho_omega = 1.5;
    
    failed_run = run_dynare(Opt, 'mp_rule', Opt.mp_rule, 'verbose', 0);
    if failed_run == 1
        fprintf('[Passive] Could not compute IRFs: policy rule %d, pphi_pi = %.2f and prho_omega = %.2f\n', Opt.mp_rule, param.pphi_pi, param.prho_omega)
    else
        fprintf('[Passive] IRFs computed: policy rule %d, pphi_pi = %.2f and prho_omega = %.2f\n', Opt.mp_rule, param.pphi_pi, param.prho_omega)
    end
    
    results.indet = store_irfs(store_info, oo_, M_);
    results.indet.pphi_pi = param.pphi_pi;
    results.indet.prho_omega = param.prho_omega;
    
    param.pphi_pi = Opt.temp_pphi_pi;
    param.prho_omega = Opt.temp_prho_omega;
    
    % save results
    save([Opt.respath, '/irfs/', Opt.comment, '_mp', num2str(Opt.mp_rule)', '.mat'], ...
        'Opt', 'param', 'ind', 'SS', 'detregion', 'results');
    
end

Opt = temp_Opt;
