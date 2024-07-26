%% Baseline calibration ---------------------------------------------------
% run the results for the baseline calibration

Opt.comment = [Opt.comment_main, '_', 'normal'];

% set parameters
run params_main.m
run calib_model_main.m
run calib_ppsi.m
run update_targets.m
run dynare_options.m

% run steady state
run_dynare(Opt, 'mp_rule', Opt.mp_rule);
run store_steady.m

% run determinacy analysis
run determinacy.m

% run IRFs
run compute_irfs.m

clearvars -except Opt param

%% Shortage calibration ---------------------------------------------------
% run the results for the shortage calibration

Opt.comment = [Opt.comment_main, '_', 'shortage'];

% update parameters
Opt.crisis = 0;
run changes_for_shortage.m
run recalib_model_main.m
run update_targets.m
run dynare_options.m

% run steady state
run_dynare(Opt, 'mp_rule', Opt.mp_rule);
run store_steady.m

% run determinacy analysis
run determinacy.m

% run IRFs
run compute_irfs.m

clearvars -except Opt param

%% Crisis calibration -----------------------------------------------------
% run the results for the crisis calibration

if strcmp(Opt.comment_main, 'base')
    
    Opt.comment = [Opt.comment_main, '_', 'storm'];
    
    % update parameters
    Opt.crisis = 1;
    run changes_for_shortage.m
    run recalib_model_main.m
    run update_targets.m
    run dynare_options.m
    
    % run steady state
    run_dynare(Opt, 'mp_rule', Opt.mp_rule);
    run store_steady.m
    
    % run determinacy analysis
    run determinacy.m
    
    % run IRFs
    run compute_irfs.m
    
    clearvars -except Opt param
    
    %% Sensitivity for crisis calibration ---------------------------------
    % run the sensitivity analysis for the crisis calibration
    
    if Opt.run_appendixG
        
        Opt.comment = [Opt.comment_main, '_', 'storm'];
        
        temp_Opt = Opt;
        
        for temp_mp_rule = Opt.sens_sel
            
            Opt.mp_rule = temp_mp_rule;
            
            % run additional results: ownership structure
            run_open = 1; run_closed = 1;
            run quantitative_ownership.m
            
            % run additional results: subsidies
            run quantitative_subsidies.m
            
            % run additional results: energy intensity of Y vs C
            run quantitative_E_in_C_vs_Y.m
            
            clearvars -except Opt param temp_Opt
            
        end
        
        Opt = temp_Opt;
        
    end
    
end

run dynare_cleanup
