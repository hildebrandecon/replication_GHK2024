function [irfs] = store_irfs(store_info, oo_, M_)

if store_info == 0
    irfs.oo_.steady_state = oo_.steady_state;
    irfs.oo_.irfs = oo_.irfs;
    irfs.M_.params = M_.params;
    irfs.M_.param_names = M_.param_names;
    irfs.M_.param_names_long = M_.param_names_long;
    irfs.M_.param_names_tex = M_.param_names_tex;
    irfs.M_.endo_names = M_.endo_names;
    irfs.M_.endo_names_long = M_.endo_names_long;
    irfs.M_.endo_names_tex = M_.endo_names_tex;
else
    irfs = [];
end

end