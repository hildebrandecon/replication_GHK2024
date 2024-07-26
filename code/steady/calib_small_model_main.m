
%% initialize steady state computation

% initial guesses
guess.p_E = 0.05;
guess.p_G = 1.20;
guess.ToT = 0.05;
guess.h = 0.80;
guess.w = 1.30;
guess.C = 1.30;
guess.C_H = 1.30;
guess.C_S = 1.30;
guess.C_E = 0.50;
guess.C_H_E = 0.50;
guess.C_S_E = 0.50;
guess.C_G = 0.90;
guess.C_H_G = 0.90;
guess.C_S_G = 0.90;
guess.N = 1.00;
guess.N_H = 1.00;
guess.N_S = 1.00;
guess.T_H = 0.10;
guess.T_S = 0.10;
guess.Y_G = 1.00;
guess.D = 0.10;
guess.E = 1.00;
guess.MC = 1.30;
guess.rr = 1.05;
guess.Grev = 0.10;
guess.Gexp = 0.10;
guess.X = 0.10;
guess.GDP = 1.20;
guess.sh_E_in_C = 4.00;
guess.sh_E_in_Y = 6.00;
guess.sh_E_in_GDP = 10.0;
guess.sh_subsistence = 25.0;
guess.inequality = 1.00;
guess.Tbar = 0.00;
guess.pchi = 0.80;
guess.xi_E = 1.50;
guess.palpha = 0.05;
guess.pgamma = 0.25;
guess.pebar = 0.20;

% get row names
rowNames = fieldnames(guess);

% pack guesses from struct to vector
x0 = zeros(1,length(rowNames));
for i = 1:length(rowNames)
    x0(i) = guess.(rowNames{i});
end

%% compute steady state

% run non-linear solvers
% I first run a constrained solver to avoid complex solutions, then, taking that solution as input for normal fsolve

fun = @(x)calib_small_model_main_conditions(x, param);
options = optimset('Display','off','TolFun',1e-15);
[x_first,~,~,~,~,~,~] = lsqnonlin(fun,x0,zeros(size(x0)),[],options);
[x,FVAL,EXITFLAG,~,~] = fsolve(fun,x_first,options);

x = real(x);

if Opt.disp_steady
    
    disp('--------------------------------------------------------------------------------')
    disp(['CALIBRATION: ', 'norm(FVAL) = ' num2str(norm(FVAL)), ', EXITFLAG = ' num2str(EXITFLAG)])
    
end

%% unpack steady state

% pack steady state from vector to struct
SS = struct();
for i = 1:length(rowNames)
    SS.(rowNames{i}) = x(i);
end

param.pchi = SS.pchi;
param.xi_E = SS.xi_E;
param.palpha = SS.palpha;
param.pgamma = SS.pgamma;
param.pebar = SS.pebar;
param.Tbar = SS.Tbar;

%% print table

if Opt.disp_steady
    
    disp(table(x', FVAL', 'VariableNames', {'Steady State', 'residual'}, 'rowNames', rowNames))
    disp('--------------------------------------------------------------------------------')
    
end

if norm(FVAL) > 1e-10
    error('Not properly calibrated!')
end
