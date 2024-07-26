
%% initialize steady state computation

% initial guesses: calibrated steady state w/o parameters, keeping Tbar free
% see calib_model_main.m for order of variables
x0 = Opt.store_x(1:(end-5));
rowNames = Opt.store_rowNames(1:(end-5));

% guess for xi_E
xi_E_guess = param.xi_E / 1.068;
position_of_sh_E_in_GDP = find(strcmp(rowNames, 'sh_E_in_GDP'));

%% calibrate energy supply

% run non-linear solvers
% normal fsolve, wrapper function to ensure that xi_E is recalibrated

fun = @(x)wrapper(x, param, x0, param.target_for_sh_E_in_GDP, position_of_sh_E_in_GDP);
options = optimset('Display','off','TolFun',1e-15);
[x,FVAL,~,~,~] = fsolve(fun,xi_E_guess,options);

param.xi_E = x;

if norm(FVAL) > 1e-10
    error('Not properly calibrated!')
end

%% compute steady state

% run non-linear solvers
% I first run a constrained solver to avoid complex solutions, then, taking that solution as input for normal fsolve

fun = @(x)recalib_model_main_conditions(x, param);
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

SS.xi_E = param.xi_E;
param.Tbar = SS.Tbar;

%% print table

if Opt.disp_steady
    
    diff = (x - x0) ./ x0 .* 100;
    disp(table(x0', x', diff', FVAL', 'VariableNames', {'Steady State 1', 'Steady State 2', 'difference', 'residual'}, 'rowNames', rowNames))
    
    disp('--------------------------------------------------------------------------------')
    
end

if norm(FVAL) > 1e-10
    error('Not properly calibrated!')
end


%% write wrapper for function

function F = wrapper(x, param, ss_guess, target_for_sh_E_in_GDP, position_of_sh_E_in_GDP)

param.xi_E = x;

fun = @(x)recalib_model_main_conditions(x, param);
options = optimset('Display','off','TolFun',1e-15);
[x_first,~,~,~,~,~,~] = lsqnonlin(fun,ss_guess,zeros(size(ss_guess)),[],options);
[x,~,~,~,~] = fsolve(fun,x_first,options);

F = x(position_of_sh_E_in_GDP) - 100 * target_for_sh_E_in_GDP;

end