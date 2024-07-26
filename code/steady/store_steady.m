% keep only relevant parts of M_ and oo_
old_M_ = M_;
old_oo_ = oo_;

M_ = struct();
oo_ = struct();

M_.params = old_M_.params;
M_.param_names = old_M_.param_names;
M_.param_names_long = old_M_.param_names_long;
M_.param_names_tex = old_M_.param_names_tex;
M_.endo_names = old_M_.endo_names;
M_.endo_names_long = old_M_.endo_names_long;
M_.endo_names_tex = old_M_.endo_names_tex;

oo_.steady_state = old_oo_.steady_state;

save([Opt.respath, '/calibration/', Opt.comment, '.mat'], 'M_', 'oo_');
