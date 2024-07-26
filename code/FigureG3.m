
%% Set up figure parameters -----------------------------------------------

reset(groot);

font_size_axis = 45;
font_size_legend = 35;
line_width = 4;
lgd_line_length = [50, 50];
yaxis_label_width = 0.04;
right_margin_width = -0.05;
top_margin_height = -0.05;

%% Figure G3a: Core inflation ---------------------------------------------

Opt.mp_rule = 1;

load([[Opt.respath, '/sensitivity/'], '/pmu_1_open','_mp',num2str(Opt.mp_rule),'.mat'], 'results')

x_data = round(results(:,1,2),3);
y_data1 = results(:,3,1);
y_data2 = results(:,3,2);
y_data1 = fillmissing(y_data1, 'linear', 'EndValues', 'none');
y_data2 = fillmissing(y_data2, 'linear', 'EndValues', 'none');

xlims = [0, 0.75];
ylims = [0.0, 20];

% plot data
fig = figure('Visible', 'off', 'Name', 'Foreign ownership');
hold on
plot(x_data, y_data1, '-k', 'LineWidth', line_width, 'DisplayName', 'Het. househ.')
plot(x_data, y_data2, '--k', 'LineWidth', line_width, 'DisplayName', 'Rep. househ.')
hold off
axis padded
xlim(xlims); ylim(ylims);

% the following code chunk is to make space for the y-axis label so that all plots have the same box
current_position = get(gca, 'Position');
current_position(1) = current_position(1) + yaxis_label_width;
current_position(3) = current_position(3) - (yaxis_label_width + right_margin_width);
current_position(4) = current_position(4) - top_margin_height;
set(gca, 'Position', current_position);

box on
set(gca, 'FontSize', font_size_axis);

if Opt.mp_rule == 2
    lgd = legend('Location', 'North', 'Box', 'off', 'FontSize', font_size_legend);
    lgd.ItemTokenSize = lgd_line_length;
end

% save figure
orient landscape
print(fig, [Opt.respath, '/figures/', 'FigureG3_a', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure G3a done')

%% Figure G3b: Headline inflation -----------------------------------------

Opt.mp_rule = 2;

load([[Opt.respath, '/sensitivity/'], '/pmu_1_open','_mp',num2str(Opt.mp_rule),'.mat'], 'results')

x_data = round(results(:,1,2),3);
y_data1 = results(:,3,1);
y_data2 = results(:,3,2);
y_data1 = fillmissing(y_data1, 'linear', 'EndValues', 'none');
y_data2 = fillmissing(y_data2, 'linear', 'EndValues', 'none');

xlims = [0, 0.75];
ylims = [0.0, 20];

% plot data
fig = figure('Visible', 'off', 'Name', 'Foreign ownership');
hold on
plot(x_data, y_data1, '-k', 'LineWidth', line_width, 'DisplayName', 'Het. househ.')
plot(x_data, y_data2, '--k', 'LineWidth', line_width, 'DisplayName', 'Rep. househ.')
hold off
axis padded
xlim(xlims); ylim(ylims);

% the following code chunk is to make space for the y-axis label so that all plots have the same box
current_position = get(gca, 'Position');
current_position(1) = current_position(1) + yaxis_label_width;
current_position(3) = current_position(3) - (yaxis_label_width + right_margin_width);
current_position(4) = current_position(4) - top_margin_height;
set(gca, 'Position', current_position);

box on
set(gca, 'FontSize', font_size_axis);

if Opt.mp_rule == 2
    lgd = legend('Location', 'North', 'Box', 'off', 'FontSize', font_size_legend);
    lgd.ItemTokenSize = lgd_line_length;
end

% save figure
orient landscape
print(fig, [Opt.respath, '/figures/', 'FigureG3_b', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure G3b done')

%% Figure G3c: NMC inflation ----------------------------------------------

Opt.mp_rule = 3;

load([[Opt.respath, '/sensitivity/'], '/pmu_1_open','_mp',num2str(Opt.mp_rule),'.mat'], 'results')

x_data = round(results(:,1,2),3);
y_data1 = results(:,3,1);
y_data2 = results(:,3,2);
y_data1 = fillmissing(y_data1, 'linear', 'EndValues', 'none');
y_data2 = fillmissing(y_data2, 'linear', 'EndValues', 'none');

xlims = [0, 0.75];
ylims = [0.0, 20];

% plot data
fig = figure('Visible', 'off', 'Name', 'Foreign ownership');
hold on
plot(x_data, y_data1, '-k', 'LineWidth', line_width, 'DisplayName', 'Het. househ.')
plot(x_data, y_data2, '--k', 'LineWidth', line_width, 'DisplayName', 'Rep. househ.')
hold off
axis padded
xlim(xlims); ylim(ylims);

% the following code chunk is to make space for the y-axis label so that all plots have the same box
current_position = get(gca, 'Position');
current_position(1) = current_position(1) + yaxis_label_width;
current_position(3) = current_position(3) - (yaxis_label_width + right_margin_width);
current_position(4) = current_position(4) - top_margin_height;
set(gca, 'Position', current_position);

box on
set(gca, 'FontSize', font_size_axis);

if Opt.mp_rule == 2
    lgd = legend('Location', 'North', 'Box', 'off', 'FontSize', font_size_legend);
    lgd.ItemTokenSize = lgd_line_length;
end

% save figure
orient landscape
print(fig, [Opt.respath, '/figures/', 'FigureG3_c', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure G3c done')
