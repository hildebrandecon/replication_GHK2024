% fiscal monetary interaction: the effect of subsidies on monetary policy

inner_temp_Opt = Opt;

disp('--------------------------------------------------------------------------------')
disp('SUBSIDIES (deviation from baseline values):')

%% Baseline calibration

Opt.disp_steady = 1;

run params_main.m
run calib_model_main.m
run calib_ppsi.m

Opt.crisis = 1;
run changes_for_shortage.m
run recalib_model_main.m

run update_targets.m
run dynare_options.m

param.baseline_pchi = param.pchi;
param.baseline_xi_E = param.xi_E;

run_dynare(Opt, 'mp_rule', Opt.mp_rule);

Opt.store_params = M_.params;
Opt.store_param_names = M_.param_names;

Opt.disp_steady = 0;

%% Initialize results matrix

% values for subsidies
loop_vec = 0.0:0.01:1.0;

% results matrix:
% - 1st dimension: loop_vec
% - 2nd dimension: 1 + 2 (1 for loop_vec, 2 for results)
% - 3rd dimension: for each subsidy type and both at the same time
results = NaN(length(loop_vec), 1 + 2, 3);

%% Energy subsidies: one subsidy at a time

subsidy_params = {'ptau_e_f', 'ptau_e_c'};

for outeriter = 1:length(subsidy_params)
    
    this_param = subsidy_params{outeriter};
    
    disp('--------------------------------------------------------------------------------')
    disp(['SUBSIDIES: ', this_param, ', policy rule ', num2str(Opt.mp_rule)])
    
    baseline_value = Opt.store_params(find(strcmp(Opt.store_param_names,this_param)));
    
    % store counter for failed runs
    failed_runs = 0;
    
    for mainiter = 1:length(loop_vec)
        
        param.(this_param) = loop_vec(mainiter);
        
        [failed_run] = run_dynare(Opt, 'mp_rule', Opt.mp_rule, 'taylor', 1);
        if failed_run == true
            failed_runs = failed_runs + 1;
            dyn_passive_ub = NaN; dyn_active_lb = NaN;
        end
        
        results(mainiter,:,outeriter) = [param.(this_param), dyn_passive_ub, dyn_active_lb];
        
        if failed_runs > 3 && param.(this_param) > baseline_value
            break
        end
        
    end
    
    % show results
    if Opt.show_tab
        disp(array2table(results(:,:,outeriter), 'VariableNames', [{this_param} {'passive_ub'} {'active_lb'}]))
    end
    
    % reset
    eval(['param.', this_param, ' = baseline_value;'])
    
end

store_i = outeriter;

%% Energy subsidies: both subsidies at the same time

subsidy_params = {'ptau_e'};

for outeriter = 1:length(subsidy_params)
    
    this_param = subsidy_params{outeriter};
    this_param_f = [this_param, '_f'];
    this_param_c = [this_param, '_c'];
    
    disp('--------------------------------------------------------------------------------')
    disp(['SUBSIDIES: ', this_param, ', policy rule ', num2str(Opt.mp_rule)])
    
    baseline_value_f = Opt.store_params(find(strcmp(Opt.store_param_names,this_param_f)));
    baseline_value_c = Opt.store_params(find(strcmp(Opt.store_param_names,this_param_c)));
    
    % store counter for failed runs
    failed_runs = 0;
    
    for mainiter = 1:length(loop_vec)
        
        param.(this_param_f) = loop_vec(mainiter);
        param.(this_param_c) = loop_vec(mainiter);
        
        [failed_run] = run_dynare(Opt, 'mp_rule', Opt.mp_rule, 'taylor', 1);
        if failed_run == true
            failed_runs = failed_runs + 1;
            dyn_passive_ub = NaN; dyn_active_lb = NaN;
        end
        
        results(mainiter,:,store_i + outeriter) = [param.(this_param_f), dyn_passive_ub, dyn_active_lb];
        
        if failed_runs > 3 && param.(this_param_f) > baseline_value_f && param.(this_param_c) > baseline_value_c
            break
        end
        
    end
    
    % show results
    if Opt.show_tab
        disp(array2table(results(:,:,store_i + outeriter), 'VariableNames', [{this_param} {'passive_ub'} {'active_lb'}]))
    end
    
    % reset
    eval(['param.', this_param_f, ' = baseline_value_f;'])
    eval(['param.', this_param_c, ' = baseline_value_c;'])
    
end

% save Opt and results to disc at .mat file
save([[Opt.respath, '/sensitivity/'], ['ptau_e','_mp',num2str(Opt.mp_rule)]], 'Opt', 'results')

disp('--------------------------------------------------------------------------------')

%% Done

run dynare_cleanup.m

% reset options etc
Opt = inner_temp_Opt;

clearvars -except Opt temp_Opt
