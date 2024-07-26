% This is the mainboard for all results in the paper.
% SH, July 25, 2024
% All results are tested with MATLAB R2022b & Dynare 5.1

% path to dynare on local machine
addpath('/Applications/Dynare/5.1/matlab')

clear all; close all; clc;

addpath('functions', 'params', 'steady', 'analysis', 'dynare')

format shortg

Opt.show_tab = 1; % show tables in terminal
Opt.disp_steady = 1;

Opt.codedir = pwd;
Opt.maindir = fileparts(cd);
Opt.respath = [Opt.maindir,'/results/'];
Opt.datapath = [Opt.maindir,'/data/'];

Opt.mod_file = 'dyn_model_GHK';

% RANK or TANK version of the model
Opt.hank = 'tank';

% for which of the policies to run the results...
Opt.polnames = {'PPI', 'mCPI', 'NMC'};
Opt.mp_rule = 1; % baseline monetary policy rule
Opt.det_sel = [1, 2, 3]; % determinacy analysis
Opt.irf_sel = 1; % impulse responses
Opt.sens_sel = [1, 2, 3]; % sensitivity analysis

% create directories
[~ , ~] = mkdir([Opt.respath, '/calibration/']);
[~ , ~] = mkdir([Opt.respath, '/determinacy/']);
[~ , ~] = mkdir([Opt.respath, '/irfs/']);
[~ , ~] = mkdir([Opt.respath, '/sensitivity/']);
[~ , ~] = mkdir([Opt.respath, '/figures/']);
[~ , ~] = mkdir([Opt.respath, '/data/']);

% select whether to run Appendix G experiments and figures
Opt.run_appendixG = 0;

%% Run data results -------------------------------------------------------
% compute data figures in Section 4 of the paper

Opt.xmin = datetime(2016,1,1);
run wrapper_data.m

% Figure 1
run Figure1.m

% Figure 2
run Figure2.m

%% Run quantitative results -----------------------------------------------
% compute results in Section 4 and G of the paper
% - baseline calibration
% - htmonwership calibration for comparison in Figure 5
% - highmpc calibration for comparison in Figure 5

% calibration selection (see params_main.m) via loop
for temp_comment = {'base', 'htmownership', 'highmpc'}
    
    Opt.comment_main = temp_comment{1};
    
    run wrapper_quantitative.m
    
end

% Figure 3
run Figure3.m

% Figure 4
run Figure4.m

% Figure 5
run Figure5.m

% Figure 6
run Figure6.m

% Figure 7
run Figure7.m

if Opt.run_appendixG
    % Figure G1
    run FigureG1.m
    
    % Figure G2
    run FigureG2.m
    
    % Figure G3
    run FigureG3.m
end

%% Run paper-pencil results -----------------------------------------------
% compute results in Section F of the paper

run wrapper_paperpencil.m

% Figure F1
run FigureF1.m