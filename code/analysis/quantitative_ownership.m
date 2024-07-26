% code for computing the results with respect to ownership structure (closed and open economy)

inner_temp_Opt = Opt;

%% Open economy

if run_open == 1
    
    disp('--------------------------------------------------------------------------------')
    disp('OWNERSHIP (open economy):')
    
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
    
    % values for foreign MPC
    loop_vec = 0.0:0.01:1.0;
    
    % run model for TANK and RANK
    store_baseline_model = Opt.hank;
    model_versions = {'tank', 'rank'};
    
    % parameter to loop over
    this_param = 'pmu_1';
    baseline_value = Opt.store_params(find(strcmp(Opt.store_param_names,this_param)));
    loop_vec = unique(round(sort([loop_vec, baseline_value]),4));
    
    % results matrix:
    % - 1st dimension: loop_vec
    % - 2nd dimension: 1 + 2 (1 for loop_vec, 2 for results)
    % - 3rd dimension: for each model version
    results = NaN(length(loop_vec), 1 + 2, length(model_versions));
    
    %% Foreign MPC
    
    for outeriter = 1:length(model_versions)
        
        % select model version
        Opt.hank = model_versions{outeriter};
        
        disp('--------------------------------------------------------------------------------')
        disp(['OWNERSHIP (open economy): ', Opt.hank, ', policy rule ', num2str(Opt.mp_rule)])
        
        % calibrate model
        run params_main.m
        run calib_model_main.m
        
        Opt.crisis = 1;
        run changes_for_shortage.m
        run recalib_model_main.m
        
        run update_targets.m
        run dynare_options.m
        
        param.baseline_pchi = param.pchi;
        param.baseline_xi_E = param.xi_E;
        
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
    
    % restore baseline
    Opt.hank = store_baseline_model;
    
    % save Opt and results to disc at .mat file
    save([[Opt.respath, '/sensitivity/'], [this_param,'_open','_mp',num2str(Opt.mp_rule)]], 'Opt', 'results')
    
    disp('--------------------------------------------------------------------------------')
    
end

%% Done

run dynare_cleanup.m

% reset options etc
Opt = inner_temp_Opt;

clearvars -except Opt temp_Opt
