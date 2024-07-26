cd([Opt.codedir,'/dynare/']);
try
    rmdir(['+', Opt.mod_file], 's');
    rmdir(Opt.mod_file, 's');
catch
    disp('No old files to delete');
end
cd(Opt.codedir);
