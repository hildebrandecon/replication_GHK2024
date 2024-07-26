% calibration of price adjustment costs via slope of PC
% notably: use paper-pencil solution for slope of PC, in the absence of energy in consumption

%% solve for ppsi given the target

x0 = [param.target_for_PC, 400];

% run non-linear solvers
% I first run a constrained solver to avoid complex solutions, then, taking that solution as input for normal fsolve

fun = @(x)conditions_ppsi(x, param);
options = optimset('Display','off','TolFun',1e-15);
[x_first,resnorm,residual,exitflag,output,lambda,jacobian] = lsqnonlin(fun,x0,zeros(size(x0)),[],options);
[x,FVAL,EXITFLAG,OUTPUT,JACOB] = fsolve(fun,x_first,options);

param.pkappa_tilde = x(1);
param.ppsi = round(x(2));

if Opt.disp_steady
    
    x = round(x, 4);
    FVAL = round(FVAL, 10);
    
    rowNames = {'pkappa_tilde', 'ppsi'};
    disp(table(x', FVAL', 'VariableNames', {'Steady State', 'residual'}, 'rowNames', rowNames))
    
    disp('--------------------------------------------------------------------------------')
    
end

% remove field pkappa_tilde from param
param = rmfield(param, 'pkappa_tilde');

% set ppsi_w as ppsi
param.ppsi_w = param.ppsi;

%% conditions

function F = conditions_ppsi(x, param)

% unpack parameters
target_for_PC = param.target_for_PC;
pepsilon = param.pepsilon;
psigma = param.psigma;
pvarphi = param.pvarphi;
ptheta = param.ptheta;
palpha = param.palpha;
piota = param.piota;

% unpack variables
pkappa_tilde = x(1);
ppsi = x(2);

% helper variables, see param_sol.m for details
pGamma_MC = (psigma + pvarphi - palpha/ptheta*(psigma-1) + piota*(palpha/(1-palpha)*(pvarphi + palpha/ptheta) + psigma*palpha/ptheta)) / ...
    (1 + (1-piota)*palpha*(psigma-1));

% conditions
F = [(pkappa_tilde) - (pepsilon/ppsi * pGamma_MC), ...
    (pkappa_tilde) - (target_for_PC)];

end
