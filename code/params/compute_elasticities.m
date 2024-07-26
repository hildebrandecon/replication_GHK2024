function [param] = compute_elasticities(param, SS, warns)

%% unpack parameters
palpha = param.palpha;
ptheta = param.ptheta;
psigma = param.psigma;
piota = param.piota;
pvarphi = param.pvarphi;
pnu = param.pnu;
plambda = param.plambda;
pvartheta = param.pvartheta;
pepsilon = param.pepsilon;
ppsi = param.ppsi;
regime_E = param.regime_E;
ptau_y = param.ptau_y;

%% unpack steady state values
Y_G = SS.Y_G;
C = SS.C;
N = SS.N;
E = SS.E;
w = SS.w;
N_H = SS.N_H;
N_S = SS.N_S;
C_H = SS.C_H;
C_S = SS.C_S;
MC = SS.MC;
xi_E = SS.xi_E;
p_E = SS.p_E;

%% check assumptions for simple version

% check whether piota is 0 or 1 and regime_E is 0 or 1
if warns == true && (piota ~= 0 && piota ~= 1)
    warning('The simple version of the elasticities is only valid for piota = 0 or 1')
    warns = false;
end
if warns == true && (regime_E ~= 0 && regime_E ~= 1)
    warning('The simple version of the elasticities is only valid for regime_E = 0 or 1')
    warns = false;
end

% check steady states
if warns == true && (E ~= 1 || N ~= 1 || Y_G ~= 1 || MC ~= 1 || w ~= (1-palpha) || p_E ~= palpha || C_H ~= C_S || N_H ~= N_S)
    warning('The simple version of the elasticities is not valid for the current parameterization')
    warns = false;
end

%% marginal costs
if regime_E == 1
    num = (psigma * Y_G/C + pvarphi/(1-palpha) * (Y_G/N)^((ptheta-1)/ptheta) - psigma*(1-piota)*p_E*xi_E/C*1/ptheta - 1/ptheta + 1/ptheta * 1/(1-palpha) * (Y_G/N)^((ptheta-1)/ptheta));
    denom = (1 + psigma*(1-piota)*p_E*xi_E/C);
    full = num / denom;
elseif regime_E == 0
    num = (psigma * Y_G/C - psigma*(1-piota)*p_E*xi_E/C - 1/ptheta + (1/ptheta + pvarphi)*1/(1-palpha) * ((Y_G/N)^((ptheta-1)/ptheta) - palpha*(E/N)^((ptheta-1)/ptheta)));
    denom = (1 + ptheta*psigma*(1-piota)*p_E*xi_E/C + ptheta*(1/ptheta + pvarphi)*palpha/(1-palpha)*(E/N)^((ptheta-1)/ptheta));
    full = num / denom;
end

if warns == true
    if piota == 1 && regime_E == 1
        simple = psigma + pvarphi / (1-palpha) + palpha/ptheta/(1-palpha);
    elseif piota == 0 && regime_E == 1
        simple = (psigma + pvarphi - palpha/ptheta*(psigma-1)) / (1 + palpha*(psigma-1));
    elseif piota == 1 && regime_E == 0
        simple = (1-palpha)*(psigma + pvarphi) / (1 + palpha*ptheta*pvarphi);
    elseif piota == 0 && regime_E == 0
        simple = (1-palpha)*(psigma + pvarphi) / (1 + palpha*ptheta*(psigma+pvarphi));
    else
        simple = NaN;
        warning('The simple version of the elasticity of marginal costs is not implemented for the current parameterization')
    end
    
    if abs(full-simple) > 1e-10
        warning('The two versions of the elasticity of marginal costs are not equal: full = %f, simple = %f', full, simple)
    end
end
pGamma_MC = full;

%% energy supply
if regime_E == 1
    pGamma_E = 0;
elseif regime_E == 0
    pGamma_E = 1 + ptheta*pGamma_MC;
end

%% energy price
if regime_E == 1
    pGamma_pE = pGamma_MC + 1/ptheta;
elseif regime_E == 0
    pGamma_pE = 0;
end

%% aggregate labor
full = 1/(1-palpha) * (Y_G/N)^((ptheta-1)/ptheta) - palpha/(1-palpha) * (E/N)^((ptheta-1)/ptheta) * pGamma_E;

if warns == true
    simple = 1/(1-palpha) - palpha/(1-palpha) * pGamma_E;
    if abs(full-simple) > 1e-10
        warning('The two versions of the elasticity of aggregate labor supply are not equal: full = %f, simple = %f', full, simple)
    end
end

pGamma_N = full;

%% wage
full = pGamma_MC + 1/ptheta - 1/ptheta * pGamma_N;

if warns == true
    if regime_E == 1
        simple = pGamma_MC - palpha/ptheta/(1-palpha);
    elseif regime_E == 0
        simple = pGamma_MC/(1-palpha);
    else
        simple = NaN;
        warning('The simple version of the elasticity of wages is not implemented for the current parameterization')
    end
    if abs(full-simple) > 1e-10
        warning('The two versions of the elasticity of wages are not equal: full = %f, simple = %f', full, simple)
    end
end

pGamma_w = full;

%% dividends
full = (1+ptau_y)*Y_G - w*N*(pGamma_w + pGamma_N) - p_E*E*(pGamma_pE + pGamma_E);

if warns == true
    simple = ptau_y - pGamma_MC;
    if abs(full-simple) > 1e-10
        warning('The two versions of the semi-elasticity of dividends are not equal: full = %f, simple = %f', full, simple)
    end
end

pGamma_D = full;

%% transfers, HtM
full = pnu/plambda*(pGamma_D - ptau_y*Y_G) + piota*pvartheta/plambda*p_E*xi_E*(pGamma_pE + pGamma_E);

if warns == true
    simple = pnu/plambda*(pGamma_D - ptau_y) + piota*pvartheta/plambda*palpha*(pGamma_pE + pGamma_E);
    if abs(full-simple) > 1e-10
        warning('The two versions of the semi-elasticity of hand-to-mouth transfers are not equal: full = %f, simple = %f', full, simple)
    end
end

pGamma_TH = full;

%% transfers, savers
full = (1-pnu)/(1-plambda)*(pGamma_D - ptau_y*Y_G) + piota*(1-pvartheta)/(1-plambda)*p_E*xi_E*(pGamma_pE + pGamma_E);

if warns == true
    simple = (1-pnu)/(1-plambda)*(pGamma_D - ptau_y) + piota*(1-pvartheta)/(1-plambda)*palpha*(pGamma_pE + pGamma_E);
    if abs(full-simple) > 1e-10
        warning('The two versions of the semi-elasticity of saver transfers are not equal')
    end
end

pGamma_TS = full;

%% aggregate consumption
full = Y_G/C - (1-piota)*p_E*xi_E/C*(pGamma_pE + pGamma_E);

if warns == true
    simple = (1-(1-piota)*palpha*(pGamma_pE + pGamma_E))/(1-palpha+piota*palpha);
    if abs(full-simple) > 1e-10
        warning('The two versions of the elasticity of aggregate consumption are not equal')
    end
end

pGamma_C = full;

%% consumption, HtM
num = w*N_H*(1+pvarphi)/pvarphi*pGamma_w + pGamma_TH;
denom = C_H + w*N_H*psigma/pvarphi;
full = num / denom;

if warns == true
    simple = ((1+pvarphi)*pGamma_w)/(psigma+pvarphi+piota*palpha/(1-palpha)*pvarphi) + (pvarphi/(1-palpha)*pGamma_TH)/(psigma+pvarphi+piota*palpha/(1-palpha)*pvarphi);
    if abs(full-simple) > 1e-10
        warning('The two versions of the elasticity of hand-to-mouth consumption are not equal')
    end
end

pGamma_CH_only_w = w*N_H*(1+pvarphi)/pvarphi*pGamma_w / denom;
pGamma_CH_only_TH = pGamma_TH / denom;

pGamma_CH = full;

%% consumption, savers
full = (C*pGamma_C - plambda*C_H*pGamma_CH) / ((1-plambda)*C_S);

if warns == true
    simple = (pGamma_C-plambda*pGamma_CH)/(1-plambda);
    if abs(full-simple) > 1e-10
        warning('The two versions of the elasticity of saver consumption are not equal')
    end
end

pGamma_CS = full;

%% labor, HtM
pGamma_NH = 1/pvarphi * pGamma_w - psigma/pvarphi * pGamma_CH;

%% labor, savers
pGamma_NS = 1/pvarphi * pGamma_w - psigma/pvarphi * pGamma_CS;

%% slope of the Phillips curve
pkappa_tilde = pepsilon/ppsi * MC * pGamma_MC;

%% slope and discounting of the IS curve
if plambda == 0
    pGamma_CS = pGamma_C;
end
psigma_tilde = psigma*pGamma_CS;
pdelta_tilde = 1;

%% parameters in terms of GDP

% NKPC
slope_NKPC = pkappa_tilde / pGamma_C;

% IS
slope_IS = psigma_tilde / pGamma_C;

%% pack parameters into param struct

param.pGamma_MC = pGamma_MC; % 1
param.pGamma_E = pGamma_E; % 2
param.pGamma_pE = pGamma_pE; % 3
param.pGamma_N = pGamma_N; % 4
param.pGamma_w = pGamma_w; % 5
param.pGamma_D = pGamma_D; % 6
param.pGamma_TH = pGamma_TH; % 7
param.pGamma_TS = pGamma_TS; % 8
param.pGamma_C = pGamma_C; % 9
param.pGamma_CH = pGamma_CH; % 10
param.pGamma_CS = pGamma_CS; % 11
param.pGamma_NH = pGamma_NH; % 12
param.pGamma_NS = pGamma_NS; % 13
param.pkappa_tilde = pkappa_tilde; % 14
param.psigma_tilde = psigma_tilde; % 15
param.pdelta_tilde = pdelta_tilde; % 16
param.slope_NKPC = slope_NKPC; % 17
param.slope_IS = slope_IS; % 18
param.pGamma_CH_only_w = pGamma_CH_only_w; % 19
param.pGamma_CH_only_TH = pGamma_CH_only_TH; % 20
