
load([Opt.respath,'/data/bilateral-trade.mat'], 'data_trade');
load([Opt.respath,'/data/energy.mat'], 'data_energy');

%% Set up figure parameters -----------------------------------------------

reset(groot);

font_size_axis = 45;
font_size_legend = 35;
line_width = 4;
lgd_line_length = [50, 50];
yaxis_label_width = 0.04;
right_margin_width = -0.05;
top_margin_height = -0.05;

%% Figure 1a: Gas prices --------------------------------------------------

% select data
x_data = data_energy.period;
y_data_1 = data_energy.gas_europe;
y_data_2 = data_energy.gas_us;
y_data_3 = data_energy.gas_japan;
missing = isnan(y_data_1) | isnan(y_data_2) | isnan(y_data_3);
x_data = x_data(~missing);
y_data_1 = y_data_1(~missing);
y_data_2 = y_data_2(~missing);

ylims = [0, ceil(max([y_data_1; y_data_2; y_data_3]) * 1.01)];

% plot data
fig = figure('Visible', 'off', 'Name', 'Gas prices');
hold on
plot(x_data, y_data_1, '-k', 'LineWidth', line_width, 'DisplayName', 'Europe');
plot(x_data, y_data_2, '-.k', 'LineWidth', line_width, 'DisplayName', 'US');
plot(x_data, y_data_3, '--k', 'LineWidth', line_width, 'DisplayName', 'Japan');
xline(datetime(2022,1,1), '--k', 'LineWidth', line_width, 'HandleVisibility', 'off');
hold off
axis padded
ylim(ylims);
xtickformat('yy');

% set x-ticks to every two years
x_years = year(x_data);
tick_positions = datetime(unique(x_years(rem(x_years, 2) == 0)), 1, 1);
% tick_positions = [tick_positions; datetime(2024, 1, 1)];
set(gca, 'XTick', tick_positions);

% the following code chunk is to make space for the y-axis label so that all plots have the same box
current_position = get(gca, 'Position');
current_position(1) = current_position(1) + yaxis_label_width;
current_position(3) = current_position(3) - (yaxis_label_width + right_margin_width);
current_position(4) = current_position(4) - top_margin_height;
set(gca, 'Position', current_position);

box on
set(gca, 'FontSize', font_size_axis);

lgd = legend('Location', 'NorthWest', 'Box', 'off', 'FontSize', font_size_legend);
lgd.ItemTokenSize = lgd_line_length;

% save figure
orient landscape
print(fig, [Opt.respath, '/figures/', 'Figure1_a', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure 1a done')

%% Figure 1b: Trade with the World ----------------------------------------

% unit converter: from million to billion
factor = 1e3;

% select data
x_data = data_trade.qrtly.X_EUR.period;
y_data_1 = data_trade.qrtly.X_EUR.('World') ./ factor;
y_data_2 = data_trade.qrtly.M_EUR.('World') ./ factor;
x_data = x_data(~isnan(y_data_1));
y_data_1 = y_data_1(~isnan(y_data_1));
y_data_2 = y_data_2(~isnan(y_data_2));

% plot data
fig = figure('Visible', 'off', 'Name', ['Trade, ', 'World']);
hold on
plot(x_data, y_data_1, '-k', 'LineWidth', line_width, 'DisplayName', 'Exports');
plot(x_data, y_data_2, '-.k', 'LineWidth', line_width, 'DisplayName', 'Imports');
xline(datetime(2022,1,1), '--k', 'LineWidth', line_width, 'HandleVisibility', 'off');
hold off
axis padded
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

lgd = legend('Location', 'NorthWest', 'Box', 'off', 'FontSize', font_size_legend);
lgd.ItemTokenSize = lgd_line_length;

% save figure
orient landscape
print(fig, [Opt.respath, '/figures/', 'Figure1_b', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure 1b done')

%% Figure 1c: Trade with Russia -------------------------------------------

% unit converter: from million to billion
factor = 1e3;

% select data
x_data = data_trade.qrtly.X_EUR.period;
y_data_1 = data_trade.qrtly.X_EUR.('Russia') ./ factor;
y_data_2 = data_trade.qrtly.M_EUR.('Russia') ./ factor;
x_data = x_data(~isnan(y_data_1));
y_data_1 = y_data_1(~isnan(y_data_1));
y_data_2 = y_data_2(~isnan(y_data_2));

% plot data
fig = figure('Visible', 'off', 'Name', ['Trade, ', 'Russia']);
hold on
plot(x_data, y_data_1, '-k', 'LineWidth', line_width, 'DisplayName', 'Exports');
plot(x_data, y_data_2, '-.k', 'LineWidth', line_width, 'DisplayName', 'Imports');
xline(datetime(2022,1,1), '--k', 'LineWidth', line_width, 'HandleVisibility', 'off');
hold off
axis padded
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

lgd = legend('Location', 'NorthWest', 'Box', 'off', 'FontSize', font_size_legend);
lgd.ItemTokenSize = lgd_line_length;

% save figure
orient landscape
print(fig, [Opt.respath, '/figures/', 'Figure1_c', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure 1c done')