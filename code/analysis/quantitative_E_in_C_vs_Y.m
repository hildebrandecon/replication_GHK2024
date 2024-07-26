% energy in production vs energy in consumption (partial recalibration of steady state)

inner_temp_Opt = Opt;

disp('--------------------------------------------------------------------------------')
disp('ENERGY C VS Y:')

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

% loop vector
loop_vec = [0.0, linspace(0.02, 0.25, 50)];

sensitivity_params_values = struct();
sensitivity_params_values.target_for_palpha = loop_vec;
sensitivity_params_values.target_for_pgamma = loop_vec;
sensitivity_params = fieldnames(sensitivity_params_values);

% results matrix:
% - 1st dimension: loop_vec
% - 2nd dimension: 1 + 2 + 3 (1 for loop_vec, 2 for results, 3 for SS values)
% - 3rd dimension: for each sensitivity parameter
results = NaN(length(loop_vec), 1 + 2 + 3, length(sensitivity_params));

%% Energy shares

for outeriter = 1:length(sensitivity_params)
    
    this_param = sensitivity_params{outeriter};
    
    disp('--------------------------------------------------------------------------------')
    disp(['ENERGY SHARES: ' this_param, ', policy rule: ' num2str(Opt.mp_rule)])
    
    baseline_value = Opt.store_params(find(strcmp(Opt.store_param_names,this_param)));
    
    loop_vec = sensitivity_params_values.(this_param);
    loop_vec = unique(round(sort([loop_vec, baseline_value]),4));
    
    % store counter for failed runs
    failed_runs = 0;
    
    for mainiter = 1:length(loop_vec)
        
        param.(this_param) = loop_vec(mainiter);
        
        % recalibrate, holding some parameters constant
        try
            run calib_small_model_main.m
            run dynare_options.m
            calibration_failed = 0;
        catch ME
            fprintf('Error in recalibration for %s = %f\n', this_param, param.(this_param))
            calibration_failed = 1;
        end
        
        if calibration_failed == 0
            [failed_run] = run_dynare(Opt, 'mp_rule', Opt.mp_rule, 'taylor', 1);
            if failed_run == true
                failed_runs = failed_runs + 1;
                dyn_passive_ub = NaN; dyn_active_lb = NaN;
            end
        elseif calibration_failed == 1
            failed_runs = failed_runs + 1;
            dyn_passive_ub = NaN; dyn_active_lb = NaN;
        end
        
        results(mainiter,:,outeriter) = [param.(this_param), dyn_passive_ub, dyn_active_lb, SS.sh_E_in_C, SS.sh_E_in_Y, SS.sh_E_in_GDP];
        
        if failed_runs > 3 && param.(this_param) > baseline_value
            break
        end
        
    end
    
    % show results
    if Opt.show_tab
        disp(array2table(results(:,:,outeriter), 'VariableNames', [{this_param} {'passive_ub'} {'active_lb'} {'sh_E_in_C'} {'sh_E_in_Y'} {'sh_E_in_GDP'}]))
    end
    
    % reset
    eval(['param.', this_param, ' = baseline_value;'])
    
end

% save Opt and results to disc at .mat file
save([[Opt.respath, '/sensitivity/'], ['energy','_mp',num2str(Opt.mp_rule)]], 'Opt', 'results')

disp('--------------------------------------------------------------------------------')

%% Done

run dynare_cleanup.m

% reset options etc
inner_temp_Opt = Opt;

clearvars -except Opt temp_Opt
