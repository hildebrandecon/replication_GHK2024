function [failed_run] = run_dynare(Opt, varargin)

%% Default values
default.mp_rule = 1;
default.steady = 0;
default.results = 0;
default.taylor = 0;
default.taylor_slow = 0;
default.verbose = 1;

%% Parse optional inputs
p = inputParser;
addParameter(p, 'mp_rule', default.mp_rule);
addParameter(p, 'steady', default.steady);
addParameter(p, 'results', default.results);
addParameter(p, 'taylor', default.taylor);
addParameter(p, 'taylor_slow', default.taylor_slow);
addParameter(p, 'verbose', default.verbose);
parse(p, varargin{:});

%% Function body

% try to run the dynare code, if it fails, return to the original directory and display the error message
cd([Opt.codedir,'/dynare/'])
try
    eval(sprintf(['dynare ', Opt.mod_file, ' -Dmp_rule=%d -Doutputs_steady=%d -Doutputs_results=%d -Dtaylor_check=%d -Dtaylor_check_slow=%d ', Opt.dynare_options], p.Results.mp_rule, p.Results.steady, p.Results.results, p.Results.taylor, p.Results.taylor_slow))
    failed_run = false;
catch ME
    if p.Results.verbose
        disp(['Error during dynare execution: ', ME.message]);
    end
    failed_run = true;
end
cd(Opt.codedir)

end