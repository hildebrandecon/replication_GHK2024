function F = recalib_model_main_conditions(x, param)

% unpack parameters
target_for_inequality = param.target_for_inequality;
peta = param.peta;
psigma = param.psigma;
pbeta = param.pbeta;
pvarphi = param.pvarphi;
plambda = param.plambda;
pnu = param.pnu;
pvartheta = param.pvartheta;
piota = param.piota;
ptheta = param.ptheta;
ptau_y = param.ptau_y;
pepsilon = param.pepsilon;
pepsilon_w = param.pepsilon_w;
ptau_w = param.ptau_w;
pchi = param.pchi;
xi_E = param.xi_E;
palpha = param.palpha;
pgamma = param.pgamma;
pebar = param.pebar;
baseline_Tbar = param.baseline_Tbar;

% unpack variables
count = 1;

p_E = x(count); count = count + 1;
p_G = x(count); count = count + 1;
ToT = x(count); count = count + 1;
h = x(count); count = count + 1;
w = x(count); count = count + 1;
C = x(count); count = count + 1;
C_H = x(count); count = count + 1;
C_S = x(count); count = count + 1;
C_E = x(count); count = count + 1;
C_H_E = x(count); count = count + 1;
C_S_E = x(count); count = count + 1;
C_G = x(count); count = count + 1;
C_H_G = x(count); count = count + 1;
C_S_G = x(count); count = count + 1;
N = x(count); count = count + 1;
N_H = x(count); count = count + 1;
N_S = x(count); count = count + 1;
T_H = x(count); count = count + 1;
T_S = x(count); count = count + 1;
Y_G = x(count); count = count + 1;
D = x(count); count = count + 1;
E = x(count); count = count + 1;
MC = x(count); count = count + 1;
rr = x(count); count = count + 1;
Gexp = x(count); count = count + 1;
Grev = x(count); count = count + 1;
X = x(count); count = count + 1;
GDP = x(count); count = count + 1;
sh_E_in_C = x(count); count = count + 1;
sh_E_in_Y = x(count); count = count + 1;
sh_E_in_GDP = x(count); count = count + 1;
sh_subsistence = x(count); count = count + 1;
inequality = x(count); count = count + 1;
Tbar = x(count); count = count + 1;

% check whether all variables have been unpacked
if (count-1) ~= length(x)
    error('Number of variables unpacked not equal to number of variables.')
end

% equations
count = 1;

if round(pgamma, 4) == 0.0
    F(count) = (ToT) - (1.0); count = count + 1;
    F(count) = (p_G) - (1.0); count = count + 1;
else
    F(count) = (p_E) - (ToT / h); count = count + 1;
    F(count) = (p_G) - (1 / h); count = count + 1;
end

if round(peta, 4) == 1.0
    F(count) = (h) - (ToT^pgamma); count = count + 1;
else
    F(count) = (h) - (( (1-pgamma) + pgamma * ToT^(1-peta) )^(1/(1-peta))); count = count + 1;
end

U_C_H = C_H^(-psigma);
U_C_S = C_S^(-psigma);
U_C = C^(-psigma);
U_N_H = -pchi * N_H^(pvarphi);
U_N_S = -pchi * N_S^(pvarphi);
U_N = -pchi * N^(pvarphi);

F(count) = (U_C_S) - (pbeta * U_C_S * rr); count = count + 1;

F(count) = ((1+ptau_w)*(pepsilon_w-1)/pepsilon_w * w) - (- U_N_H / U_C_H); count = count + 1;
F(count) = ((1+ptau_w)*(pepsilon_w-1)/pepsilon_w * w) - (- U_N_S / U_C_S); count = count + 1;

if round(pgamma, 4) == 0.0
    F(count) = (C_H_G) - (C_H); count = count + 1;
    F(count) = (C_S_G) - (C_S); count = count + 1;
    F(count) = (C_H_E) - (0.0); count = count + 1;
    F(count) = (C_S_E) - (0.0); count = count + 1;
else
    F(count) = (C_H_G) - (        (p_G)^(-peta) * C_H * (1-pgamma)); count = count + 1;
    F(count) = (C_S_G) - (        (p_G)^(-peta) * C_S * (1-pgamma)); count = count + 1;
    F(count) = (C_H_E) - (pebar + (p_E)^(-peta) * C_H * pgamma); count = count + 1;
    F(count) = (C_S_E) - (pebar + (p_E)^(-peta) * C_S * pgamma); count = count + 1;
end

F(count) = (p_E*C_H_E + p_G*C_H_G) - ((1+ptau_w)*w*N_H + T_H); count = count + 1;

F(count) = (plambda * T_H) - (pnu * (D - ptau_y*p_G*Y_G) + pvartheta * p_E*xi_E * piota - plambda*ptau_w*w*N_H + Tbar); count = count + 1;
F(count) = (Gexp) - (Grev); count = count + 1;

F(count) = (N) - (plambda*N_H + (1-plambda)*N_S); count = count + 1;
F(count) = (C) - (plambda*C_H + (1-plambda)*C_S); count = count + 1;
F(count) = (C_G) - (plambda*C_H_G + (1-plambda)*C_S_G); count = count + 1;
F(count) = (C_E) - (plambda*C_H_E + (1-plambda)*C_S_E); count = count + 1;

if round(palpha, 4) == 0.0
    F(count) = (Y_G) - (N); count = count + 1;
else
    if round(ptheta, 4) == 1.0
        F(count) = (Y_G) - (E^(palpha) * N^(1-palpha)); count = count + 1;
    else
        F(count) = (Y_G) - (( palpha * E^((ptheta-1)/ptheta) + (1-palpha) * N^((ptheta-1)/ptheta) )^(ptheta/(ptheta-1))); count = count + 1;
    end
end

F(count) = (0) - ((1+ptau_y)*(1-pepsilon) + pepsilon*MC/p_G); count = count + 1;

if round(palpha, 4) == 0.0
    F(count) = (w) - (MC); count = count + 1;
    F(count) = (E) - (0.0); count = count + 1;
else
    F(count) = (w  ) - (MC * (1-palpha) * (Y_G / N)^(1/ptheta)); count = count + 1;
    F(count) = (p_E) - (MC * palpha     * (Y_G / E)^(1/ptheta)); count = count + 1;
end

F(count) = (D) - ((1+ptau_y)*p_G*Y_G - w*N - p_E*E); count = count + 1;

F(count) = (Gexp) - (plambda * T_H + (1-plambda) * T_S + ptau_y*p_G*Y_G + ptau_w*w*N); count = count + 1;
F(count) = (Grev) - (D + piota * p_E*xi_E); count = count + 1;

F(count) = (X) - (p_E/p_G*xi_E * (1-piota)); count = count + 1;

F(count) = (xi_E) - (C_E + E); count = count + 1;
F(count) = (Y_G) - (C_G + X); count = count + 1;

F(count) = (GDP) - (p_E*C_E + p_G*C_G + p_G*X - p_E*xi_E * (1-piota)); count = count + 1;

if round(pgamma, 4) == 0.0
    F(count) = (sh_E_in_C) - (0.0); count = count + 1;
else
    F(count) = (sh_E_in_C) - (100 * (p_E * C_E) / (p_E*C_E + p_G*C_G)); count = count + 1;
end
if round(palpha, 4) == 0.0
    F(count) = (sh_E_in_Y) - (0.0); count = count + 1;
else
    F(count) = (sh_E_in_Y) - (100 * (p_E * E) / (p_E*C_E + p_G*C_G)); count = count + 1;
end
F(count) = (sh_E_in_GDP) - (100 * (p_E * xi_E) / (p_E*C_E + p_G*C_G)); count = count + 1;
if round(pgamma, 4) == 0.0 || round(pebar, 4) == 0.0
    F(count) = (sh_subsistence) - (0.0); count = count + 1;
else
    F(count) = (sh_subsistence) - (100 * (pebar) / (C_E)); count = count + 1;
end

F(count) = (inequality) - (C_S / C_H); count = count + 1;

% targets
if ~isnan(target_for_inequality)
    F(count) = (inequality) - (target_for_inequality); count = count + 1;
else
    F(count) = (Tbar) - (baseline_Tbar); count = count + 1;
end

% check whether same number of equations and variables
if (count-1) ~= length(x)
    error('Number of equations not equal to number of variables.')
end

end
