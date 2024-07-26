
load([Opt.respath, '/sensitivity/', 'slopes_paperpencil.mat'], 'results', 'loop_vec', 'param_base', 'colnames');

%% Set up figure parameters -----------------------------------------------

reset(groot);

font_size_axis = 25;
font_size_legend = 25;
line_width = 4;
lgd_line_length = [50, 50];

%% Figure F1a, c, e: NKPC slope over psigma and pvarphi -------------------

% get data: rows
idx_regime_E = ones(size(results, 1), 1);
idx_piota = results(:, 2) == 0.0 | results(:, 2) == 1.0 | results(:, 2) == round(param_base.piota, 6);
idx_palpha = results(:, 3) == round(param_base.palpha, 6);
idx_psigma = ones(size(results, 1), 1);
idx_pvarphi = ones(size(results, 1), 1);
idx_ptheta = results(:, 6) == round(param_base.ptheta, 6);
idx_rows = idx_regime_E & idx_piota & idx_palpha & idx_psigma & idx_pvarphi & idx_ptheta;

% get data: columns
pos_var = find(strcmp(colnames, 'pkappa_tilde'));

% get data
temp = get_data(results, idx_rows, pos_var);

% plot: closed economy
indices = {3, 1, ':', ':', 1}; % w/o regime_E, added in plot_3d
save_path = [Opt.respath, '/figures/', 'FigureF1_a'];
plot_3d(temp.psigma, temp.pvarphi, temp.out, indices, '$$\sigma$$', '$$\varphi$$', [0,4], [0,4], true, false, save_path, true, true, font_size_axis, font_size_legend, line_width, lgd_line_length)

disp('Figure F1a done')

% plot: baseline economy
indices = {2, 1, ':', ':', 1}; % w/o regime_E, added in plot_3d
save_path = [Opt.respath, '/figures/', 'FigureF1_c'];
plot_3d(temp.psigma, temp.pvarphi, temp.out, indices, '$$\sigma$$', '$$\varphi$$', [0,4], [0,4], true, false, save_path, true, true, font_size_axis, font_size_legend, line_width, lgd_line_length)

disp('Figure F1c done')

% plot: open economy
indices = {1, 1, ':', ':', 1}; % w/o regime_E, added in plot_3d
save_path = [Opt.respath, '/figures/', 'FigureF1_e'];
plot_3d(temp.psigma, temp.pvarphi, temp.out, indices, '$$\sigma$$', '$$\varphi$$', [0,4], [0,4], true, false, save_path, true, true, font_size_axis, font_size_legend, line_width, lgd_line_length)

disp('Figure F1e done')

%% Figure F1b, d, f: NKPC slope over ptheta and pvarphi -------------------

% get data: rows
idx_regime_E = ones(size(results, 1), 1);
idx_piota = results(:, 2) == 0.0 | results(:, 2) == 1.0 | results(:, 2) == round(param_base.piota, 6);
idx_palpha = results(:, 3) == round(param_base.palpha, 6);
idx_psigma = results(:, 4) == round(param_base.psigma, 6);
idx_pvarphi = ones(size(results, 1), 1);
idx_ptheta = ones(size(results, 1), 1);
idx_rows = idx_regime_E & idx_piota & idx_palpha & idx_psigma & idx_pvarphi & idx_ptheta;

% get data: columns
pos_var = find(strcmp(colnames, 'pkappa_tilde'));

% get data
temp = get_data(results, idx_rows, pos_var);

% plot: closed economy
indices = {3, 1, 1, ':', ':'}; % w/o regime_E, added in plot_3d
save_path = [Opt.respath, '/figures/', 'FigureF1_b'];
plot_3d(temp.ptheta, temp.pvarphi, temp.out, indices, '$$\theta$$', '$$\varphi$$', [0,0.5], [0,4], true, false, save_path, false, true, font_size_axis, font_size_legend, line_width, lgd_line_length)

disp('Figure F1b done')

% plot: baseline economy
indices = {2, 1, 1, ':', ':'}; % w/o regime_E, added in plot_3d
save_path = [Opt.respath, '/figures/', 'FigureF1_d'];
plot_3d(temp.ptheta, temp.pvarphi, temp.out, indices, '$$\theta$$', '$$\varphi$$', [0,0.5], [0,4], true, false, save_path, false, true, font_size_axis, font_size_legend, line_width, lgd_line_length)

disp('Figure F1d done')

% plot: open economy
indices = {1, 1, 1, ':', ':'}; % w/o regime_E, added in plot_3d
save_path = [Opt.respath, '/figures/', 'FigureF1_f'];
plot_3d(temp.ptheta, temp.pvarphi, temp.out, indices, '$$\theta$$', '$$\varphi$$', [0,0.5], [0,4], true, false, save_path, false, true, font_size_axis, font_size_legend, line_width, lgd_line_length)

disp('Figure F1f done')

%% Helper functions -------------------------------------------------------

function [temp, len] = get_data(results, idx_rows, pos_var)

% get data: columns
idx_cols = [1:6, pos_var];

% get data
temp.results = results(idx_rows, idx_cols);

% get lengths
len.regime_E = length(unique(temp.results(:, 1)));
len.piota = length(unique(temp.results(:, 2)));
len.palpha = length(unique(temp.results(:, 3)));
len.psigma = length(unique(temp.results(:, 4)));
len.pvarphi = length(unique(temp.results(:, 5)));
len.ptheta = length(unique(temp.results(:, 6)));

% reshape data to matrices
temp.regime_E = reshape(temp.results(:, 1), len.ptheta, len.pvarphi, len.psigma, len.palpha, len.piota, len.regime_E);
temp.piota = reshape(temp.results(:, 2), len.ptheta, len.pvarphi, len.psigma, len.palpha, len.piota, len.regime_E);
temp.palpha = reshape(temp.results(:, 3), len.ptheta, len.pvarphi, len.psigma, len.palpha, len.piota, len.regime_E);
temp.psigma = reshape(temp.results(:, 4), len.ptheta, len.pvarphi, len.psigma, len.palpha, len.piota, len.regime_E);
temp.pvarphi = reshape(temp.results(:, 5), len.ptheta, len.pvarphi, len.psigma, len.palpha, len.piota, len.regime_E);
temp.ptheta = reshape(temp.results(:, 6), len.ptheta, len.pvarphi, len.psigma, len.palpha, len.piota, len.regime_E);
temp.out = reshape(temp.results(:, 7), len.ptheta, len.pvarphi, len.psigma, len.palpha, len.piota, len.regime_E);

% change the order of the dimensions: regime_E, piota, palpha, psigma, pvarphi, ptheta
temp.regime_E = permute(temp.regime_E, [6, 5, 4, 3, 2, 1]);
temp.piota = permute(temp.piota, [6, 5, 4, 3, 2, 1]);
temp.palpha = permute(temp.palpha, [6, 5, 4, 3, 2, 1]);
temp.psigma = permute(temp.psigma, [6, 5, 4, 3, 2, 1]);
temp.pvarphi = permute(temp.pvarphi, [6, 5, 4, 3, 2, 1]);
temp.ptheta = permute(temp.ptheta, [6, 5, 4, 3, 2, 1]);
temp.out = permute(temp.out, [6, 5, 4, 3, 2, 1]);

end

function [] = plot_3d(x, y, z, indices, names_x, names_y, lims_x, lims_y, save_fig, show_fig, save_path, add_legend, remove_negative, font_size_axis, font_size_legend, line_width, lgd_line_length)

col1 = '#DCDCDC';
col2 = '#808080';
legend_pos = [0.05 0.9 0.23822945912679 0.062];

indices_1 = {1, indices{:}}; %#ok<*CCAT>
indices_2 = {2, indices{:}};

if remove_negative
    z(z < 0) = NaN;
end

fig = figure('Visible', 'off');
surf(squeeze(x(indices_2{:})), squeeze(y(indices_2{:})), squeeze(z(indices_2{:})), 'FaceColor', col2, 'EdgeColor', 'none', 'DisplayName', 'fixed-supply');
hold on;
surf(squeeze(x(indices_1{:})), squeeze(y(indices_1{:})), squeeze(z(indices_1{:})), 'FaceColor', col1, 'EdgeColor', 'none', 'DisplayName', 'fixed-price');
xlabel(names_x, 'Interpreter', 'latex');
ylabel(names_y, 'Interpreter', 'latex');
grid on
axis padded
xlim(lims_x)
ylim(lims_y)
box on
set(gca, 'FontSize', font_size_axis);

if add_legend
    lgd = legend('Position', legend_pos, 'Box', 'off', 'FontSize', font_size_legend);
    lgd.ItemTokenSize = lgd_line_length;
end

if save_fig
    orient landscape;
    print(fig, [save_path,'.pdf'], '-dpdf', '-r0', '-fillpage')
end
if show_fig
    shg %#ok<*UNRCH>
end

end