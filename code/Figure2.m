
load([Opt.respath,'/data/wages.mat'], 'data_wages');

%% Set up figure parameters -----------------------------------------------

reset(groot);

font_size_axis = 45;
font_size_legend = 35;
line_width = 4;
lgd_line_length = [50, 50];
yaxis_label_width = 0.04;
right_margin_width = -0.05;
top_margin_height = -0.05;

%% Figure 2a: real wages --------------------------------------------------

% select data
x_data = data_wages.period;
y_data = data_wages.ha_wage_r_sa;
missing = isnan(y_data);
x_data = x_data(~missing);
y_data = y_data(~missing);

ylims = [floor(min(y_data) * 0.99), ceil(max(y_data) * 1.01)];

% plot data
fig = figure('Visible', 'off', 'Name', 'Real wage, Haver data, SA only');
hold on
plot(x_data, y_data, '-k', 'LineWidth', line_width);
xline(datetime(2022,1,1), '--k', 'LineWidth', line_width, 'HandleVisibility', 'off');
yline(100, ':k', 'LineWidth', line_width, 'HandleVisibility', 'off');
hold off
axis padded
ylim(ylims);
xtickformat('yy');

% set x-ticks to every two years
x_years = year(x_data);
tick_positions = datetime(unique(x_years(rem(x_years, 2) == 0)), 1, 1);
tick_positions = [tick_positions; datetime(2024, 1, 1)];
set(gca, 'XTick', tick_positions);

% the following code chunk is to make space for the y-axis label so that all plots have the same box
current_position = get(gca, 'Position');
current_position(1) = current_position(1) + yaxis_label_width;
current_position(3) = current_position(3) - (yaxis_label_width + right_margin_width);
current_position(4) = current_position(4) - top_margin_height;
set(gca, 'Position', current_position);

box on
set(gca, 'FontSize', font_size_axis);

% save figure
orient landscape
print(fig, [Opt.respath, '/figures/', 'Figure2_a', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure 2a done')

%% Figure 2b: nominal wages, quintile 1 -----------------------------------

% select measures to plot
measures = {'wage_n_average', 'wage_n_Q1', 'wage_n_Q2', 'wage_n_Q3', 'wage_n_Q4', 'wage_n_Q5'};

% ylims as min and max of all data
ymin = floor(min(cellfun(@(x) min(data_wages.(x)), measures)) * 0.99);
ymax = ceil(max(cellfun(@(x) max(data_wages.(x)), measures)) * 1.01);

% select data
x_data = data_wages.period;
y_data = data_wages.('wage_n_Q1');
x_data = x_data(~isnan(y_data));
y_data = y_data(~isnan(y_data));

% compute trend line
x_data_reg = (1:length(x_data))';
mdl = fitlm(x_data_reg, y_data);
trend_line = predict(mdl, x_data_reg);

% plot data
fig = figure('Visible', 'off', 'Name', ['Nominal wage, ', 'wage_n_Q1']);
hold on
plot(x_data, y_data, '-k', 'LineWidth', line_width);
plot(x_data, trend_line, '--k', 'LineWidth', line_width, 'HandleVisibility', 'off');
yline(100, ':k', 'LineWidth', line_width);
hold off
axis padded
ylim([ymin, ymax]);
xtickformat('yy/MM');

% the following code chunk is to make space for the y-axis label so that all plots have the same box
current_position = get(gca, 'Position');
current_position(1) = current_position(1) + yaxis_label_width;
current_position(3) = current_position(3) - (yaxis_label_width + right_margin_width);
current_position(4) = current_position(4) - top_margin_height;
set(gca, 'Position', current_position);

box on
set(gca, 'FontSize', font_size_axis);

% save figure
orient landscape
print(fig, [Opt.respath, '/figures/', 'Figure2_b', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure 2b done')

%% Figure 2c: nominal wages, quintile 5 -----------------------------------

% select measures to plot
measures = {'wage_n_average', 'wage_n_Q1', 'wage_n_Q2', 'wage_n_Q3', 'wage_n_Q4', 'wage_n_Q5'};

% ylims as min and max of all data
ymin = floor(min(cellfun(@(x) min(data_wages.(x)), measures)) * 0.99);
ymax = ceil(max(cellfun(@(x) max(data_wages.(x)), measures)) * 1.01);

% select data
x_data = data_wages.period;
y_data = data_wages.('wage_n_Q5');
x_data = x_data(~isnan(y_data));
y_data = y_data(~isnan(y_data));

% compute trend line
x_data_reg = (1:length(x_data))';
mdl = fitlm(x_data_reg, y_data);
trend_line = predict(mdl, x_data_reg);

% plot data
fig = figure('Visible', 'off', 'Name', ['Nominal wage, ', 'wage_n_Q5']);
hold on
plot(x_data, y_data, '-k', 'LineWidth', line_width);
plot(x_data, trend_line, '--k', 'LineWidth', line_width, 'HandleVisibility', 'off');
yline(100, ':k', 'LineWidth', line_width);
hold off
axis padded
ylim([ymin, ymax]);
xtickformat('yy/MM');

% the following code chunk is to make space for the y-axis label so that all plots have the same box
current_position = get(gca, 'Position');
current_position(1) = current_position(1) + yaxis_label_width;
current_position(3) = current_position(3) - (yaxis_label_width + right_margin_width);
current_position(4) = current_position(4) - top_margin_height;
set(gca, 'Position', current_position);

box on
set(gca, 'FontSize', font_size_axis);

% save figure
orient landscape
print(fig, [Opt.respath, '/figures/', 'Figure2_c', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure 2c done')