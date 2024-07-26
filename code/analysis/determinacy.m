% code for determinacy analysis

disp('--------------------------------------------------------------------------------')
disp('DETERMINACY:')

polnames = Opt.polnames;
polnames_no = strcat(string(1:length(polnames)), ": ", polnames);
polnames_no = polnames_no(Opt.det_sel);

detregion = zeros(length(Opt.det_sel),2);
rowNames = cell(length(Opt.det_sel),1);
store_rules = zeros(length(Opt.det_sel),1);

%% determinacy for each policy rule

for i = 1:size(detregion,1)
    
    dyn_passive_ub = NaN; dyn_active_lb = NaN;
    run_dynare(Opt, 'taylor', 1, 'mp_rule', Opt.det_sel(i));
    detregion(i,:) = [dyn_passive_ub, dyn_active_lb];
    rowNames{i} = polnames_no{i};
    store_rules(i) = Opt.det_sel(i);
    
end

%% display and save results

% display results in table
if Opt.show_tab == 1
    disp(table( ...
        detregion(:,1), detregion(:,2), ...
        'VariableNames', {'passive_ub', 'active_lb'}, ...
        'RowNames', rowNames));
end

% save results to disc
save([Opt.respath, '/determinacy/', Opt.comment, '.mat'], 'detregion', 'store_rules', 'polnames');

%% Done

run dynare_cleanup.m

disp('--------------------------------------------------------------------------------')
