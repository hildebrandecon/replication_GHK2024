Opt.mp_rule = 1;
Opt.comment_main = 'base';

% regime crisis
Opt.comment = [Opt.comment_main, '_', 'storm'];
r_storm = load([Opt.respath, '/irfs/', Opt.comment, '_mp', num2str(Opt.mp_rule)', '.mat']);

%% Set up figure inputs ---------------------------------------------------

results_1 = r_storm.results.indet;
shockvar_1 = 'p_E';
shock_1 = 'epssun';

% energy prices increase by 20%
impact_response = 0.02;

%% Set up figure parameters -----------------------------------------------

reset(groot);

font_size_axis = 45;
font_size_legend = 45;
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

% compute standardization factor
myfactor_1 = impact_response / abs(eval(['irfs_1.', shockvar_1, '_', shock_1, '(1)']) / steady(ismember(vars_full, shockvar_1))) * sign(eval(['irfs_1.', shockvar_1, '_', shock_1, '(1)']));

% length of IRFs
T = length(eval(['irfs_1.', shockvar_1, '_', shock_1]));
x_start = myxlims(1);
x_end = x_start + T - 1;

% unit of variables
unit = 'pcts';

%% Figure 7a: energy prices -----------------------------------------------

plotvar = 'p_E';

if endsWith(plotvar, '_devs')
    y_unit = 'devs';
else
    y_unit = unit;
end

y_irf_1 = eval(['irfs_1.', plotvar, '_', shock_1]);
y_ss = steady(ismember(vars_full, plotvar));

if strcmp(y_unit, 'lvls')
    y_irf_1_plt = myfactor_1 * y_irf_1 + y_ss;
    intercept = y_ss;
elseif strcmp(y_unit, 'devs')
    y_irf_1_plt = myfactor_1 * y_irf_1;
    intercept = 0;
elseif strcmp(y_unit, 'pcts')
    y_irf_1_plt = myfactor_1 * y_irf_1 / y_ss * 100;
    intercept = 0;
end

fig = figure('Visible', 'off');
hold on
plot(x_start:x_end,round(y_irf_1_plt, 6), '-k', 'LineWidth', line_width)
yline(intercept, ':k', 'LineWidth', line_width, 'HandleVisibility', 'off')
hold off

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
print(fig, [Opt.respath, '/figures/', 'Figure7_a', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure 7a done')

%% Figure 7b: nominal rate, annualized ------------------------------------

plotvar = 'R_ann';

if endsWith(plotvar, '_devs')
    y_unit = 'devs';
else
    y_unit = unit;
end

y_irf_1 = eval(['irfs_1.', plotvar, '_', shock_1]);
y_ss = steady(ismember(vars_full, plotvar));

if strcmp(y_unit, 'lvls')
    y_irf_1_plt = myfactor_1 * y_irf_1 + y_ss;
    intercept = y_ss;
elseif strcmp(y_unit, 'devs')
    y_irf_1_plt = myfactor_1 * y_irf_1;
    intercept = 0;
elseif strcmp(y_unit, 'pcts')
    y_irf_1_plt = myfactor_1 * y_irf_1 / y_ss * 100;
    intercept = 0;
end

fig = figure('Visible', 'off');
hold on
plot(x_start:x_end,round(y_irf_1_plt, 6), '-k', 'LineWidth', line_width)
yline(intercept, ':k', 'LineWidth', line_width, 'HandleVisibility', 'off')
hold off

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
print(fig, [Opt.respath, '/figures/', 'Figure7_b', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure 7b done')

%% Figure 7c: savers' goods consumption -----------------------------------

plotvar = 'C_S_G';

if endsWith(plotvar, '_devs')
    y_unit = 'devs';
else
    y_unit = unit;
end

y_irf_1 = eval(['irfs_1.', plotvar, '_', shock_1]);
y_ss = steady(ismember(vars_full, plotvar));

if strcmp(y_unit, 'lvls')
    y_irf_1_plt = myfactor_1 * y_irf_1 + y_ss;
    intercept = y_ss;
elseif strcmp(y_unit, 'devs')
    y_irf_1_plt = myfactor_1 * y_irf_1;
    intercept = 0;
elseif strcmp(y_unit, 'pcts')
    y_irf_1_plt = myfactor_1 * y_irf_1 / y_ss * 100;
    intercept = 0;
end

fig = figure('Visible', 'off');
hold on
plot(x_start:x_end,round(y_irf_1_plt, 6), '-k', 'LineWidth', line_width)
yline(intercept, ':k', 'LineWidth', line_width, 'HandleVisibility', 'off')
hold off

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
print(fig, [Opt.respath, '/figures/', 'Figure7_c', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure 7c done')

%% Figure 7d: core inflation, annualized ----------------------------------

plotvar = 'Pi_G_ann';

if endsWith(plotvar, '_devs')
    y_unit = 'devs';
else
    y_unit = unit;
end

y_irf_1 = eval(['irfs_1.', plotvar, '_', shock_1]);
y_ss = steady(ismember(vars_full, plotvar));

if strcmp(y_unit, 'lvls')
    y_irf_1_plt = myfactor_1 * y_irf_1 + y_ss;
    intercept = y_ss;
elseif strcmp(y_unit, 'devs')
    y_irf_1_plt = myfactor_1 * y_irf_1;
    intercept = 0;
elseif strcmp(y_unit, 'pcts')
    y_irf_1_plt = myfactor_1 * y_irf_1 / y_ss * 100;
    intercept = 0;
end

fig = figure('Visible', 'off');
hold on
plot(x_start:x_end,round(y_irf_1_plt, 6), '-k', 'LineWidth', line_width)
yline(intercept, ':k', 'LineWidth', line_width, 'HandleVisibility', 'off')
hold off

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
print(fig, [Opt.respath, '/figures/', 'Figure7_d', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure 7d done')

%% Figure 7e: employment --------------------------------------------------

plotvar = 'N';

if endsWith(plotvar, '_devs')
    y_unit = 'devs';
else
    y_unit = unit;
end

y_irf_1 = eval(['irfs_1.', plotvar, '_', shock_1]);
y_ss = steady(ismember(vars_full, plotvar));

if strcmp(y_unit, 'lvls')
    y_irf_1_plt = myfactor_1 * y_irf_1 + y_ss;
    intercept = y_ss;
elseif strcmp(y_unit, 'devs')
    y_irf_1_plt = myfactor_1 * y_irf_1;
    intercept = 0;
elseif strcmp(y_unit, 'pcts')
    y_irf_1_plt = myfactor_1 * y_irf_1 / y_ss * 100;
    intercept = 0;
end

fig = figure('Visible', 'off');
hold on
plot(x_start:x_end,round(y_irf_1_plt, 6), '-k', 'LineWidth', line_width)
yline(intercept, ':k', 'LineWidth', line_width, 'HandleVisibility', 'off')
hold off

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
print(fig, [Opt.respath, '/figures/', 'Figure7_e', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure 7e done')

%% Figure 7f: inequality --------------------------------------------------

plotvar = 'inequality_G';

if endsWith(plotvar, '_devs')
    y_unit = 'devs';
else
    y_unit = unit;
end

y_irf_1 = eval(['irfs_1.', plotvar, '_', shock_1]);
y_ss = steady(ismember(vars_full, plotvar));

if strcmp(y_unit, 'lvls')
    y_irf_1_plt = myfactor_1 * y_irf_1 + y_ss;
    intercept = y_ss;
elseif strcmp(y_unit, 'devs')
    y_irf_1_plt = myfactor_1 * y_irf_1;
    intercept = 0;
elseif strcmp(y_unit, 'pcts')
    y_irf_1_plt = myfactor_1 * y_irf_1 / y_ss * 100;
    intercept = 0;
end

fig = figure('Visible', 'off');
hold on
plot(x_start:x_end,round(y_irf_1_plt, 6), '-k', 'LineWidth', line_width)
yline(intercept, ':k', 'LineWidth', line_width, 'HandleVisibility', 'off')
hold off

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
print(fig, [Opt.respath, '/figures/', 'Figure7_f', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure 7f done')

%% Figure 7g: real wage ---------------------------------------------------

plotvar = 'w';

if endsWith(plotvar, '_devs')
    y_unit = 'devs';
else
    y_unit = unit;
end

y_irf_1 = eval(['irfs_1.', plotvar, '_', shock_1]);
y_ss = steady(ismember(vars_full, plotvar));

if strcmp(y_unit, 'lvls')
    y_irf_1_plt = myfactor_1 * y_irf_1 + y_ss;
    intercept = y_ss;
elseif strcmp(y_unit, 'devs')
    y_irf_1_plt = myfactor_1 * y_irf_1;
    intercept = 0;
elseif strcmp(y_unit, 'pcts')
    y_irf_1_plt = myfactor_1 * y_irf_1 / y_ss * 100;
    intercept = 0;
end

fig = figure('Visible', 'off');
hold on
plot(x_start:x_end,round(y_irf_1_plt, 6), '-k', 'LineWidth', line_width)
yline(intercept, ':k', 'LineWidth', line_width, 'HandleVisibility', 'off')
hold off

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
print(fig, [Opt.respath, '/figures/', 'Figure7_g', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure 7g done')

%% Figure 7h: exports to GDP ----------------------------------------------

plotvar = 'X_GDP_devs';

if endsWith(plotvar, '_devs')
    y_unit = 'devs';
else
    y_unit = unit;
end

y_irf_1 = eval(['irfs_1.', plotvar, '_', shock_1]);
y_ss = steady(ismember(vars_full, plotvar));

if strcmp(y_unit, 'lvls')
    y_irf_1_plt = myfactor_1 * y_irf_1 + y_ss;
    intercept = y_ss;
elseif strcmp(y_unit, 'devs')
    y_irf_1_plt = myfactor_1 * y_irf_1;
    intercept = 0;
elseif strcmp(y_unit, 'pcts')
    y_irf_1_plt = myfactor_1 * y_irf_1 / y_ss * 100;
    intercept = 0;
end

fig = figure('Visible', 'off');
hold on
plot(x_start:x_end,round(y_irf_1_plt, 6), '-k', 'LineWidth', line_width)
yline(intercept, ':k', 'LineWidth', line_width, 'HandleVisibility', 'off')
hold off

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
print(fig, [Opt.respath, '/figures/', 'Figure7_h', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure 7h done')

%% Figure 7i: GDP ---------------------------------------------------------

plotvar = 'GDP';

if endsWith(plotvar, '_devs')
    y_unit = 'devs';
else
    y_unit = unit;
end

y_irf_1 = eval(['irfs_1.', plotvar, '_', shock_1]);
y_ss = steady(ismember(vars_full, plotvar));

if strcmp(y_unit, 'lvls')
    y_irf_1_plt = myfactor_1 * y_irf_1 + y_ss;
    intercept = y_ss;
elseif strcmp(y_unit, 'devs')
    y_irf_1_plt = myfactor_1 * y_irf_1;
    intercept = 0;
elseif strcmp(y_unit, 'pcts')
    y_irf_1_plt = myfactor_1 * y_irf_1 / y_ss * 100;
    intercept = 0;
end

fig = figure('Visible', 'off');
hold on
plot(x_start:x_end,round(y_irf_1_plt, 6), '-k', 'LineWidth', line_width)
yline(intercept, ':k', 'LineWidth', line_width, 'HandleVisibility', 'off')
hold off

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
print(fig, [Opt.respath, '/figures/', 'Figure7_i', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure 7i done')