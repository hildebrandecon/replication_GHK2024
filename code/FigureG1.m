
%% Set up figure parameters -----------------------------------------------

reset(groot);

font_size_axis = 45;
font_size_legend = 35;
line_width = 4;
lgd_line_length = [50, 50];
yaxis_label_width = 0.04;
right_margin_width = -0.05;
top_margin_height = -0.05;

%% Figure G1a: Core inflation ---------------------------------------------

Opt.mp_rule = 1;

load([[Opt.respath, '/sensitivity/'], '/energy','_mp',num2str(Opt.mp_rule)','.mat'], 'results')

x_data1 = results(:,1,1);
y_data1 = results(:,3,1);
x_data2 = results(:,1,2);
y_data2 = results(:,3,2);
y_data1 = fillmissing(y_data1, 'linear', 'EndValues', 'none');
y_data2 = fillmissing(y_data2, 'linear', 'EndValues', 'none');

xlims = [0, 0.18];
ylims = [0.0, 20];

% plot data
fig = figure('Visible', 'off', 'Name', 'Energy in C vs Y');
hold on
plot(x_data1, y_data1, '-k', 'DisplayName', 'Energy use by firms', 'LineWidth', line_width)
plot(x_data2, y_data2, '--k', 'DisplayName', 'Energy use by househ.', 'LineWidth', line_width)
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
print(fig, [Opt.respath, '/figures/', 'FigureG1_a', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure G1a done')

%% Figure G1b: Headline inflation -----------------------------------------

Opt.mp_rule = 2;

load([[Opt.respath, '/sensitivity/'], '/energy','_mp',num2str(Opt.mp_rule)','.mat'], 'results')

x_data1 = results(:,1,1);
y_data1 = results(:,3,1);
x_data2 = results(:,1,2);
y_data2 = results(:,3,2);
y_data1 = fillmissing(y_data1, 'linear', 'EndValues', 'none');
y_data2 = fillmissing(y_data2, 'linear', 'EndValues', 'none');

xlims = [0, 0.18];
ylims = [0.0, 20];

% plot data
fig = figure('Visible', 'off', 'Name', 'Energy in C vs Y');
hold on
plot(x_data1, y_data1, '-k', 'DisplayName', 'Energy use by firms', 'LineWidth', line_width)
plot(x_data2, y_data2, '--k', 'DisplayName', 'Energy use by househ.', 'LineWidth', line_width)
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
print(fig, [Opt.respath, '/figures/', 'FigureG1_b', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure G1b done')

%% Figure G1c: NMC inflation ----------------------------------------------

Opt.mp_rule = 3;

load([[Opt.respath, '/sensitivity/'], '/energy','_mp',num2str(Opt.mp_rule)','.mat'], 'results')

x_data1 = results(:,1,1);
y_data1 = results(:,3,1);
x_data2 = results(:,1,2);
y_data2 = results(:,3,2);
y_data1 = fillmissing(y_data1, 'linear', 'EndValues', 'none');
y_data2 = fillmissing(y_data2, 'linear', 'EndValues', 'none');

xlims = [0, 0.18];
ylims = [0.0, 20];

% plot data
fig = figure('Visible', 'off', 'Name', 'Energy in C vs Y');
hold on
plot(x_data1, y_data1, '-k', 'DisplayName', 'Energy use by firms', 'LineWidth', line_width)
plot(x_data2, y_data2, '--k', 'DisplayName', 'Energy use by househ.', 'LineWidth', line_width)
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
print(fig, [Opt.respath, '/figures/', 'FigureG1_c', '.pdf'], '-dpdf', '-r0', '-fillpage')

disp('Figure G1c done')
