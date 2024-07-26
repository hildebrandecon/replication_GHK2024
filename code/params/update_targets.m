try
    param.target_for_pgamma = SS.sh_E_in_C / 100;
catch ME
    disp(ME.message)
end

try
    param.target_for_palpha = SS.sh_E_in_Y / 100;
catch ME
    disp(ME.message)
end

try
    param.target_for_pebar = SS.sh_subsistence / 100;
catch ME
    disp(ME.message)
end

try
    param.target_for_N = SS.N;
catch ME
    disp(ME.message)
end

try
    if contains(Opt.comment, 'no_E_in_Y')
        param.target_for_E_or_C_E = SS.C_E;
    else
        param.target_for_E_or_C_E = SS.E;
    end
catch ME
    disp(ME.message)
end