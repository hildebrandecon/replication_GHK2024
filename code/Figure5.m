Opt.mp_rule = 1;

for temp_comment = {'htmownership', 'highmpc'}
    
    Opt.comment_main = temp_comment{1};
    
    % regime elastic
    Opt.comment = [Opt.comment_main, '_', 'normal'];
    r_normal = load([Opt.respath, '/irfs/', Opt.comment, '_mp', num2str(Opt.mp_rule)', '.mat']);
    
    % regime inelastic
    Opt.comment = [Opt.comment_main, '_', 'shortage'];
    r_shortage = load([Opt.respath, '/irfs/', Opt.comment, '_mp', num2str(Opt.mp_rule)', '.mat']);
    
    %% Set up figure inputs ---------------------------------------------------
    
    results_1 = r_normal.results.det_a;
    results_2 = r_shortage.results.det_a;
    shockvar_1 = 'nu_R';
    shockvar_2 = 'nu_R';
    shock_1 = 'epsr';
    shock_2 = 'epsr';
    
    % 25bp cut in exogenous component of the nominal interest rate
    impact_response = -0.0025;
    
    name_1 = 'fixed-price';
    name_2 = 'fixed-supply';
    legend_var = 'R_ann';
    legend_loc = [0.575 0.18 0.38 0.225];
    
    %% Set up figure parameters -----------------------------------------------
    
    reset(groot);
    
    font_size_axis = 45;
    font_size_legend = 35;
    line_width = 4;
    lgd_line_length = [50, 50];
    yaxis_label_width = 0.04;
    right_margin_width = -0.05;
    top_margin_height = -0.05;
    
    myxlims = [0, 6];
    myxticks = 0:2:6;
    
    %% Computations for all figures -------------------------------------------
    
    vars_full = results_1.M_.endo_names;
    steady = results_1.oo_.steady_state;
    
    irfs_1 = results_1.oo_.irfs;
    irfs_2 = results_2.oo_.irfs;
    
    % compute standardization factor
    myfactor_1 = impact_response / abs(eval(['irfs_1.', shockvar_1, '_', shock_1, '(1)']) / steady(ismember(vars_full, shockvar_1))) * sign(eval(['irfs_1.', shockvar_1, '_', shock_1, '(1)']));
    myfactor_2 = impact_response / abs(eval(['irfs_2.', shockvar_2, '_', shock_2, '(1)']) / steady(ismember(vars_full, shockvar_2))) * sign(eval(['irfs_2.', shockvar_2, '_', shock_2, '(1)']));
    
    % length of IRFs
    T = length(eval(['irfs_1.', shockvar_1, '_', shock_1]));
    x_start = myxlims(1);
    x_end = x_start + T - 1;
    
    % unit of variables
    unit = 'pcts';
    
    %% Figure 5a/d: core inflation --------------------------------------------
    
    plotvar = 'Pi_G_ann';
    
    if endsWith(plotvar, '_devs')
        y_unit = 'devs';
    else
        y_unit = unit;
    end
    
    y_irf_1 = eval(['irfs_1.', plotvar, '_', shock_1]);
    y_irf_2 = eval(['irfs_2.', plotvar, '_', shock_2]);
    y_ss = steady(ismember(vars_full, plotvar));
    
    if strcmp(y_unit, 'lvls')
        y_irf_1_plt = myfactor_1 * y_irf_1 + y_ss;
        y_irf_2_plt = myfactor_2 * y_irf_2 + y_ss;
        intercept = y_ss;
    elseif strcmp(y_unit, 'devs')
        y_irf_1_plt = myfactor_1 * y_irf_1;
        y_irf_2_plt = myfactor_2 * y_irf_2;
        intercept = 0;
    elseif strcmp(y_unit, 'pcts')
        y_irf_1_plt = myfactor_1 * y_irf_1 / y_ss * 100;
        y_irf_2_plt = myfactor_2 * y_irf_2 / y_ss * 100;
        intercept = 0;
    end
    
    fig = figure('Visible', 'off');
    hold on
    plot(x_start:x_end,round(y_irf_1_plt, 6), '-k', 'LineWidth', line_width, 'DisplayName', name_1)
    plot(x_start:x_end,round(y_irf_2_plt, 6), '-.k', 'LineWidth', line_width, 'DisplayName', name_2)
    yline(intercept, ':k', 'LineWidth', line_width, 'HandleVisibility', 'off')
    hold off
    if strcmp(legend_var, 'all') || strcmp(legend_var, plotvar)
        lgd = legend('Location', legend_loc, 'Box', 'off', 'FontSize', font_size_legend);
        lgd.ItemTokenSize = lgd_line_length;
    end
    
    axis padded
    xlim(myxlims);
    xticks(myxticks);
    
    % the following code chunk is to make space for the y-axis label so that all plots have the same box
    current_position = get(gca, 'Position');
    current_position(1) = current_position(1) + yaxis_label_width;
    current_position(3) = current_position(3) - (yaxis_label_width + right_margin_width);
    current_position(4) = current_position(4) - top_margin_height;
    set(gca, 'Position', current_position);
    
    box on
    ax = gca;
    ax.YAxis.Exponent = 0;
    set(gca , 'FontSize', font_size_axis);
    
    % save figure
    orient landscape
    if strcmp(Opt.comment_main, 'htmownership')
        print(fig, [Opt.respath, '/figures/', 'Figure5_a', '.pdf'], '-dpdf', '-r0', '-fillpage')
        
        disp('Figure 5a done')
    elseif strcmp(Opt.comment_main, 'highmpc')
        print(fig, [Opt.respath, '/figures/', 'Figure5_d', '.pdf'], '-dpdf', '-r0', '-fillpage')
        
        disp('Figure 5d done')
    end
    
    %% Figure 5b/e: employment ------------------------------------------------
    
    plotvar = 'N';
    
    if endsWith(plotvar, '_devs')
        y_unit = 'devs';
    else
        y_unit = unit;
    end
    
    y_irf_1 = eval(['irfs_1.', plotvar, '_', shock_1]);
    y_irf_2 = eval(['irfs_2.', plotvar, '_', shock_2]);
    y_ss = steady(ismember(vars_full, plotvar));
    
    if strcmp(y_unit, 'lvls')
        y_irf_1_plt = myfactor_1 * y_irf_1 + y_ss;
        y_irf_2_plt = myfactor_2 * y_irf_2 + y_ss;
        intercept = y_ss;
    elseif strcmp(y_unit, 'devs')
        y_irf_1_plt = myfactor_1 * y_irf_1;
        y_irf_2_plt = myfactor_2 * y_irf_2;
        intercept = 0;
    elseif strcmp(y_unit, 'pcts')
        y_irf_1_plt = myfactor_1 * y_irf_1 / y_ss * 100;
        y_irf_2_plt = myfactor_2 * y_irf_2 / y_ss * 100;
        intercept = 0;
    end
    
    fig = figure('Visible', 'off');
    hold on
    plot(x_start:x_end,round(y_irf_1_plt, 6), '-k', 'LineWidth', line_width, 'DisplayName', name_1)
    plot(x_start:x_end,round(y_irf_2_plt, 6), '-.k', 'LineWidth', line_width, 'DisplayName', name_2)
    yline(intercept, ':k', 'LineWidth', line_width, 'HandleVisibility', 'off')
    hold off
    if strcmp(legend_var, 'all') || strcmp(legend_var, plotvar)
        lgd = legend('Location', legend_loc, 'Box', 'off', 'FontSize', font_size_legend);
        lgd.ItemTokenSize = lgd_line_length;
    end
    
    axis padded
    xlim(myxlims);
    xticks(myxticks);
    
    % the following code chunk is to make space for the y-axis label so that all plots have the same box
    current_position = get(gca, 'Position');
    current_position(1) = current_position(1) + yaxis_label_width;
    current_position(3) = current_position(3) - (yaxis_label_width + right_margin_width);
    current_position(4) = current_position(4) - top_margin_height;
    set(gca, 'Position', current_position);
    
    box on
    ax = gca;
    ax.YAxis.Exponent = 0;
    set(gca , 'FontSize', font_size_axis);
    
    % save figure
    orient landscape
    if strcmp(Opt.comment_main, 'htmownership')
        print(fig, [Opt.respath, '/figures/', 'Figure5_b', '.pdf'], '-dpdf', '-r0', '-fillpage')
        
        disp('Figure 5b done')
    elseif strcmp(Opt.comment_main, 'highmpc')
        print(fig, [Opt.respath, '/figures/', 'Figure5_e', '.pdf'], '-dpdf', '-r0', '-fillpage')
        
        disp('Figure 5e done')
    end
    
    %% Figure 5c/f: inequality ------------------------------------------------
    
    plotvar = 'inequality_G';
    
    if endsWith(plotvar, '_devs')
        y_unit = 'devs';
    else
        y_unit = unit;
    end
    
    y_irf_1 = eval(['irfs_1.', plotvar, '_', shock_1]);
    y_irf_2 = eval(['irfs_2.', plotvar, '_', shock_2]);
    y_ss = steady(ismember(vars_full, plotvar));
    
    if strcmp(y_unit, 'lvls')
        y_irf_1_plt = myfactor_1 * y_irf_1 + y_ss;
        y_irf_2_plt = myfactor_2 * y_irf_2 + y_ss;
        intercept = y_ss;
    elseif strcmp(y_unit, 'devs')
        y_irf_1_plt = myfactor_1 * y_irf_1;
        y_irf_2_plt = myfactor_2 * y_irf_2;
        intercept = 0;
    elseif strcmp(y_unit, 'pcts')
        y_irf_1_plt = myfactor_1 * y_irf_1 / y_ss * 100;
        y_irf_2_plt = myfactor_2 * y_irf_2 / y_ss * 100;
        intercept = 0;
    end
    
    fig = figure('Visible', 'off');
    hold on
    plot(x_start:x_end,round(y_irf_1_plt, 6), '-k', 'LineWidth', line_width, 'DisplayName', name_1)
    plot(x_start:x_end,round(y_irf_2_plt, 6), '-.k', 'LineWidth', line_width, 'DisplayName', name_2)
    yline(intercept, ':k', 'LineWidth', line_width, 'HandleVisibility', 'off')
    hold off
    if strcmp(legend_var, 'all') || strcmp(legend_var, plotvar)
        lgd = legend('Location', legend_loc, 'Box', 'off', 'FontSize', font_size_legend);
        lgd.ItemTokenSize = lgd_line_length;
    end
    
    axis padded
    xlim(myxlims);
    xticks(myxticks);
    
    % the following code chunk is to make space for the y-axis label so that all plots have the same box
    current_position = get(gca, 'Position');
    current_position(1) = current_position(1) + yaxis_label_width;
    current_position(3) = current_position(3) - (yaxis_label_width + right_margin_width);
    current_position(4) = current_position(4) - top_margin_height;
    set(gca, 'Position', current_position);
    
    box on
    ax = gca;
    ax.YAxis.Exponent = 0;
    set(gca , 'FontSize', font_size_axis);
    
    % save figure
    orient landscape
    if strcmp(Opt.comment_main, 'htmownership')
        print(fig, [Opt.respath, '/figures/', 'Figure5_c', '.pdf'], '-dpdf', '-r0', '-fillpage')
        
        disp('Figure 5c done')
    elseif strcmp(Opt.comment_main, 'highmpc')
        print(fig, [Opt.respath, '/figures/', 'Figure5_f', '.pdf'], '-dpdf', '-r0', '-fillpage')
        
        disp('Figure 5f done')
    end
    
end
