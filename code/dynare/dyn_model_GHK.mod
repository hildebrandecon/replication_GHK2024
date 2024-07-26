/*

SH, July 25, 2024

*/

% ///////////////////////////////////////////////////////////////////////////
% /*
% Endogenous variables
% */
% ///////////////////////////////////////////////////////////////////////////

var

% sunspot structure as in Bianchi & Nicolo (2021)
omega           $\omega$            (long_name='sun spot variable')
FE              ${FE}$              (long_name='forecast error in C')

% exogenous shocks
nu_xi_E         $\nu_{\xi_E}$       (long_name='exogenous E-supply shifter')
nu_p_E          $\nu_{p_E}$         (long_name='exogenous E-price shifter')
nu_R            $\nu_{R}$           (long_name='exogenous monetary policy shifter')
nu_T            $\nu_{T}$           (long_name='exogenous fiscal policy shifter')

% prices, wages, and inflation rates
p_E             $p_E$               (long_name='real price of E-good')
p_E_c           $p^c_E$             (long_name='real price of E-good that households pay')
p_E_f           $p^f_E$             (long_name='real price of E-good that firms pay')
p_G             $p_G$               (long_name='real price of G-good')
w               $w$                 (long_name='real wage')
Pi_W            $\Pi_W$             (long_name='nominal wage inflation')
Pi              $\Pi$               (long_name='marginal-CPI inflation')
Pi_G            $\Pi_G$             (long_name='producer price inflation')
Pi_E            $\Pi_E$             (long_name='E-price inflation')
Pi_nmc          $\Pi_{nmc}$         (long_name='nominal marginal cost inflation')
Pi_w            $\Pi_{rw}$          (long_name='real wage inflation')

% consumption
C_H_E           $C_{H,E}$           (long_name='hand-to-mouth household´s consumption of E-good')
C_S_E           $C_{S,E}$           (long_name='saver´s consumption of E-good')
C_E             $C_E$               (long_name='aggregate consumption of E-good')
C_H_G           $C_{H,G}$           (long_name='hand-to-mouth household´s consumption of G-good')
C_S_G           $C_{S,G}$           (long_name='saver´s consumption of G-good')
C_G             $C_G$               (long_name='aggregate consumption of G-good')
C_H             $C_H$               (long_name='hand-to-mouth household´s consumption bundle')
C_S             $C_S$               (long_name='saver´s consumption bundle')
C               $C$                 (long_name='aggregate consumption')
GDP             $GDP$               (long_name='gross domestic product')
inequality      $C_S/C_H$           (long_name='Inequality in consumption')
inequality_G    $C_S_G/C_H_G$       (long_name='Inequality in consumption of G-good')
inequality_E    $C_S_E/C_H_E$       (long_name='Inequality in consumption of E-good')

% marginal utilities
U_C_H           $U_{C_H}$           (long_name='hand-to-mouth household´s marginal utility of consumption')
U_C_S           $U_{C_S}$           (long_name='saver´s marginal utility of consumption')
U_C             $U_{C}$             (long_name='average marginal utility of consumption')
U_N_H           $U_{N_H}$           (long_name='hand-to-mouth household´s marginal utility of labor')
U_N_S           $U_{N_S}$           (long_name='saver´s marginal utility of labor')
U_N             $U_{N}$             (long_name='average marginal utility of labor')

% supply and production
xi_E            $\xi_E$             (long_name='supply of E-good')
N_H             $N_H$               (long_name='hand-to-mouth household´s labor supply')
N_S             $N_S$               (long_name='saver´s labor supply')
N               $N$                 (long_name='aggregate labor supply')
Y_G             $Y_G$               (long_name='output of G-good')
E               $E$                 (long_name='use of E-good in production')
D               $D$                 (long_name='profits')
MC              $\Lambda$           (long_name='real marginal cost')

% fiscal and monetary policies
R               $R$                 (long_name='gross nominal interest rate')
rr              $r$                 (long_name='real interest rate')
T_H             $T_H$               (long_name='lump-sum transfer to hand-to-mouth households')
T_S             $T_S$               (long_name='lump-sum transfer to savers')
Gexp            $G_{exp}$           (long_name='government spending')
Grev            $G_{rev}$           (long_name='government revenues')

% foreign
b               $b$                 (long_name='real external savings')
Ystar           $Y^*$               (long_name='Foreign´s revenue')
X               $X$                 (long_name='exports to Foreign')
M               $M$                 (long_name='imports from Foreign')
NX              $NX$                (long_name='net exports')

% checks
check_walras
check_budget_1
check_budget_2
check_savers
check_C_H
check_C_S
check_fiscal

% additional variables
X_GDP_devs      $X/\bar{GDP}$       (long_name='exports as percentage of GDP, exported as devs always')
M_GDP_devs      $M/\bar{GDP}$       (long_name='imports as percentage of GDP, exported as devs always')
NX_GDP_devs     $NX/\bar{GDP}$      (long_name='net exports as percentage of GDP, exported as devs always')
b_devs          $b$                 (long_name='real external savings, exported as devs always')

% annualized variables
R_ann           $R^{y}$             (long_name='annualized gross nominal interest rate')
rr_ann          $r^{y}$             (long_name='annualized real interest rate')
Pi_ann          $\Pi^{y}$           (long_name='annualized marginal-CPI inflation')
Pi_G_ann        $\Pi_G^{y}$         (long_name='annualized producer price inflation')
Pi_E_ann        $\Pi_E^{y}$         (long_name='annualized E-price inflation')
Pi_nmc_ann      $\Pi_{nmc}^{y}$     (long_name='annualized nominal marginal cost inflation')
Pi_W_ann        $\Pi_{W}^{y}$       (long_name='annualized nominal wage inflation')
Pi_w_ann        $\Pi_{rw}^{y}$      (long_name='annualized real wage inflation')

% shares
sh_E_in_C
sh_E_in_Y
sh_E_in_GDP
sh_subsistence

;

% ///////////////////////////////////////////////////////////////////////////
% /*
% Exogenous variables
% */
% ///////////////////////////////////////////////////////////////////////////

varexo

epse
epsp
epssun
epsr
epst

;

% ///////////////////////////////////////////////////////////////////////////
% /*
% Parameter declaration
% */
% ///////////////////////////////////////////////////////////////////////////

parameters

% shock processes
prho_xi_E       $\rho_{\xi_E}$      (long_name='autocorrelation of E-supply shock')
prho_p_E        $\rho_{p_E}$        (long_name='autocorrelation of E-price shock')
prho_R          $\rho_{R}$          (long_name='autocorrelation of monetary policy shock')
prho_T          $\rho_{T}$          (long_name='autocorrelation of fiscal policy shock')
prho_omega      $\rho_{\omega}$     (long_name='autocorrelation of sunspot process')

% preferences
pbeta           $\beta$             (long_name='discount factor')
psigma          $\sigma$            (long_name='inverse intertemporal elasticity of substitution')
pvarphi         $\varphi$           (long_name='inverse Frisch elasticity')
pchi            $\chi$              (long_name='disutility of labor supply')
plambda         $\lambda$           (long_name='share of hand-to-mouth households')
pebar           $\bar{e}$           (long_name='subsistence level of E-good in consumption')
pgamma          $\gamma$            (long_name='share of E-good in consumption basket')
peta            $\eta$              (long_name='elasticity between E- and G-good in consumption basket')

% production
pepsilon        $\varepsilon$       (long_name='substitutability between goods varieties')
ppsi            $\psi$              (long_name='price adjustment costs')
palpha          $\alpha$            (long_name='share of E-good in production')
ptheta          $\theta$            (long_name='elasticity of substitution between E-good and labor in production')

% labor market
pepsilon_w      $\varepsilon_w$     (long_name='substitutability between labor varieties')
ppsi_w          $\psi_w$            (long_name='wage adjustment costs')

% energy, foreign
piota           $\iota$             (long_name='share of E-good owned by domestic economy')
pmu_1           $\mu_1$             (long_name='marginal propensity to consume out of E-good revenues of Foreign')
pmu_2           $\mu_2$             (long_name='marginal propensity to consume out of wealth of Foreign')

% government
ptau_y          $\tau^y$            (long_name='production subsidy')
ptau_w          $\tau^w$            (long_name='employment subsidy')
pnu             $\nu$               (long_name='hand-to-mouth households´ share in dividend revenues')
pvartheta       $\vartheta$         (long_name='hand-to-mouth households´ share in domestic E-good revenues')
Tbar            $\bar{T}$           (long_name='constant lump-sum transfer for hand-to-mouth households')
pphi_pi         $\phi_{\pi}$        (long_name='Taylor coefficient on inflation')
ptau_e_c        $\tau_{e}^c$        (long_name='E-price subsidy for households')
ptau_e_f        $\tau_{e}^f$        (long_name='E-price subsidy for firms')

% targets
target_for_pgamma
target_for_palpha
target_for_pebar
target_for_PC
target_for_N
target_for_E_or_C_E

% steady state values
p_E_0
p_G_0
w_0
C_H_E_0
C_S_E_0
C_E_0
C_H_G_0
C_S_G_0
C_G_0
C_H_0
C_S_0
C_0
inequality_0
xi_E_0
N_H_0
N_S_0
N_0
Y_G_0
E_0
D_0
MC_0
rr_0
T_H_0
T_S_0
Gexp_0
Grev_0
X_0
sh_E_in_C_0
sh_E_in_Y_0
sh_E_in_GDP_0
sh_subsistence_0

;

set_param_value('prho_xi_E', param.prho_xi_E);
set_param_value('prho_p_E', param.prho_p_E);
set_param_value('prho_R', param.prho_R);
set_param_value('prho_T', param.prho_T);
set_param_value('prho_omega', param.prho_omega);
set_param_value('pbeta', param.pbeta);
set_param_value('psigma', param.psigma);
set_param_value('pvarphi', param.pvarphi);
set_param_value('pchi', param.pchi);
set_param_value('plambda', param.plambda);
set_param_value('pebar', param.pebar);
set_param_value('pgamma', param.pgamma);
set_param_value('peta', param.peta);
set_param_value('pepsilon', param.pepsilon);
set_param_value('ppsi', param.ppsi);
set_param_value('palpha', param.palpha);
set_param_value('ptheta', param.ptheta);
set_param_value('pepsilon_w', param.pepsilon_w);
set_param_value('ppsi_w', param.ppsi_w);
set_param_value('piota', param.piota);
set_param_value('pmu_1', param.pmu_1);
set_param_value('pmu_2', param.pmu_2);
set_param_value('ptau_y', param.ptau_y);
set_param_value('ptau_w', param.ptau_w);
set_param_value('pnu', param.pnu);
set_param_value('pvartheta', param.pvartheta);
set_param_value('Tbar', param.Tbar);
set_param_value('pphi_pi', param.pphi_pi);
set_param_value('ptau_e_c', param.ptau_e_c);
set_param_value('ptau_e_f', param.ptau_e_f);
set_param_value('target_for_pgamma', param.target_for_pgamma);
set_param_value('target_for_palpha', param.target_for_palpha);
set_param_value('target_for_pebar', param.target_for_pebar);
set_param_value('target_for_PC', param.target_for_PC);
set_param_value('target_for_N', param.target_for_N);
set_param_value('target_for_E_or_C_E', param.target_for_E_or_C_E);

set_param_value('p_E_0', SS.p_E);
set_param_value('p_G_0', SS.p_G);
set_param_value('w_0', SS.w);
set_param_value('C_H_E_0', SS.C_H_E);
set_param_value('C_S_E_0', SS.C_S_E);
set_param_value('C_E_0', SS.C_E);
set_param_value('C_H_G_0', SS.C_H_G);
set_param_value('C_S_G_0', SS.C_S_G);
set_param_value('C_G_0', SS.C_G);
set_param_value('C_H_0', SS.C_H);
set_param_value('C_S_0', SS.C_S);
set_param_value('C_0', SS.C);
set_param_value('inequality_0', SS.inequality);
set_param_value('xi_E_0', SS.xi_E);
set_param_value('N_H_0', SS.N_H);
set_param_value('N_S_0', SS.N_S);
set_param_value('N_0', SS.N);
set_param_value('Y_G_0', SS.Y_G);
set_param_value('E_0', SS.E);
set_param_value('D_0', SS.D);
set_param_value('MC_0', SS.MC);
set_param_value('rr_0', SS.rr);
set_param_value('T_H_0', SS.T_H);
set_param_value('T_S_0', SS.T_S);
set_param_value('Gexp_0', SS.Gexp);
set_param_value('Grev_0', SS.Grev);
set_param_value('X_0', SS.X);
set_param_value('sh_E_in_C_0', SS.sh_E_in_C);
set_param_value('sh_E_in_Y_0', SS.sh_E_in_Y);
set_param_value('sh_E_in_GDP_0', SS.sh_E_in_GDP);
set_param_value('sh_subsistence_0', SS.sh_subsistence);

% ///////////////////////////////////////////////////////////////////////////
% /*
% Model block
% */
% ///////////////////////////////////////////////////////////////////////////

model;

% ///////////////// Shocks

% sunspot shock as in Bianchi & Nicolo (2021)
log(omega) = prho_omega * log(omega(-1)) + epssun + log(FE);
FE = exp(log(C) - expectation(-1)(log(C)));

% fundamental E-supply shock
nu_xi_E = nu_xi_E(-1)^(prho_xi_E) * exp(epse);

% fundamental E-price shock
nu_p_E = nu_p_E(-1)^(prho_p_E) * exp(epsp);

% monetary policy shock
nu_R = nu_R(-1)^(prho_R) * exp(epsr);

% fiscal policy shock
nu_T = nu_T(-1)^(prho_T) * exp(epst);

% ///////////////// Inflation definitions

% relation between producer price inflation and marginal-CPI inflation
Pi_G = p_G / p_G(-1) * Pi;

% relation between nominal wage inflation and marginal-CPI inflation
Pi_W = w / w(-1) * Pi;

% real wage inflation
Pi_w = w / w(-1);

% relation between nominal marginal cost inflation and marginal-CPI inflation
Pi_nmc = MC / MC(-1) * Pi;

% relation between E-price inflation and marginal-CPI inflation
Pi_E = p_E / p_E(-1) * Pi;

% ///////////////// Households in Home

% definition of the consumption-based price index
@#if cddemand
    1 = p_E_c^pgamma * p_G^(1-pgamma);
@#else
    1 = (pgamma * p_E_c^(1-peta) + (1-pgamma) * p_G^(1-peta))^(1/(1-peta));
@#endif

% consumption allocation across goods
@#if E_in_C
    C_H_G =         (p_G  )^(-peta) * C_H * (1-pgamma);
    C_S_G =         (p_G  )^(-peta) * C_S * (1-pgamma);
    C_H_E = pebar + (p_E_c)^(-peta) * C_H * pgamma;
    C_S_E = pebar + (p_E_c)^(-peta) * C_S * pgamma;
@#else
    C_H_G = C_H;
    C_S_G = C_S;
    C_H_E = 0.0;
    C_S_E = 0.0;
@#endif

% consumption bundles
@#if E_in_C
    check_C_H = exp(C_H) / (exp((pgamma^(1/peta) * (C_H_E - pebar)^((peta-1)/peta) + (1-pgamma)^(1/peta) * C_H_G^((peta-1)/peta))^(peta/(peta-1))));
    check_C_S = exp(C_S) / (exp((pgamma^(1/peta) * (C_S_E - pebar)^((peta-1)/peta) + (1-pgamma)^(1/peta) * C_S_G^((peta-1)/peta))^(peta/(peta-1))));
@#else
    check_C_H = 1;
    check_C_S = 1;
@#endif

% Euler equation of savers
U_C_S = pbeta * U_C_S(+1) * R / Pi(+1);

% household budget constraints
p_E_c*C_H_E + p_G*C_H_G = (1+ptau_w)*w*N_H + T_H;
check_savers = exp(p_E_c*C_S_E + p_G*C_S_G + 1/(1-plambda) * b) / exp((1+ptau_w)*w*N_S + 1/(1-plambda) * R(-1)/Pi*b(-1) + T_S);

% marginal utility of consumption and labor
U_C_H = C_H^(-psigma);
U_C_S = C_S^(-psigma);
U_C = C^(-psigma);
U_N_H = -pchi * N_H^(pvarphi);
U_N_S = -pchi * N_S^(pvarphi);
U_N = -pchi * N^(pvarphi);

% aggregation of households
C = plambda*C_H + (1-plambda)*C_S;
@#if E_in_C
    check_budget_1 = exp(p_E_c*C_E + p_G*C_G) / exp(C + p_E_c*pebar);
@#else
    check_budget_1 = exp(p_E_c*C_E + p_G*C_G) / exp(C);
@#endif
check_budget_2 = exp(p_E_c*C_E + p_G*C_G + b) / exp((1+ptau_w)*w*N + plambda*T_H + (1-plambda)*T_S + R(-1)/Pi*b(-1));

% inequality
inequality = C_S / C_H;
inequality_G = C_S_G / C_H_G;
@#if E_in_C
    inequality_E = C_S_E / C_H_E;
@#else
    inequality_E = 0.0;
@#endif

% ///////////////// Labor market in Home

% flexible wages
@#if labormarket == 0

    % labor supply decisions of spenders and savers
    (1+ptau_w)*(pepsilon_w-1)/pepsilon_w * w = - U_N_H / U_C_H;
    (1+ptau_w)*(pepsilon_w-1)/pepsilon_w * w = - U_N_S / U_C_S;

@#endif

% nominal wage rigidity
@#if labormarket == 1

    % nominal wage Phillips curve
    ppsi_w*Pi_W*(Pi_W-1) = pepsilon_w*(-U_N_H/(plambda*U_C_H + (1-plambda)*U_C_S) - (1+ptau_w)*(pepsilon_w-1)/pepsilon_w * w) + ppsi_w*pbeta*((plambda*U_C_H(+1) + (1-plambda)*U_C_S(+1))/(plambda*U_C_H + (1-plambda)*U_C_S))*Pi_W(+1)*(Pi_W(+1)-1)*N_H(+1)/N_H;

    % symmetric labor supply
    N_S = N_H;

@#endif

% ///////////////// Production in Home

% production function
@#if E_in_Y
    @#if cdprod
        Y_G = E^(palpha) * N^(1-palpha);
    @#else
        Y_G = ( palpha * E^((ptheta-1)/ptheta) + (1-palpha) * N^((ptheta-1)/ptheta) )^(ptheta/(ptheta-1));
    @#endif
@#else
    Y_G = N;
@#endif

% Phillips curve
ppsi*Pi_G*(Pi_G-1) = (1+ptau_y)*(1-pepsilon) + pepsilon*MC/p_G + ppsi*pbeta*(C_S(+1)/C_S)^(-psigma)*Pi_G(+1)*(Pi_G(+1)-1)*Y_G(+1)/Y_G*p_G(+1)/p_G;

% marginal costs
@#if E_in_Y
    w     = MC * (1-palpha) * (Y_G / N)^(1/ptheta);
    p_E_f = MC * palpha     * (Y_G / E)^(1/ptheta);
@#else
    w = MC;
    E = 0.0;
@#endif

% profits
D = (1+ptau_y)*p_G*Y_G - w*N - p_E_f*E;

% ///////////////// Fiscal policy in Home

% government revenues
Grev = D + piota * p_E*xi_E;

% government spending
Gexp = plambda * T_H + (1-plambda) * T_S + ptau_y*p_G*Y_G + ptau_w*w*N + (p_E - p_E_c) * C_E + (p_E - p_E_f) * E;

% price subsidies
p_E_f = p_E * (p_E / STEADY_STATE(p_E))^(-ptau_e_f);
p_E_c = p_E * (p_E / STEADY_STATE(p_E))^(-ptau_e_c);

% transfers to households
plambda * T_H = pnu * (D - ptau_y*p_G*Y_G) + piota * pvartheta * p_E*xi_E - plambda*ptau_w*w*N_H + Tbar + log(nu_T);
(1-plambda) * T_S = Grev - (plambda * T_H + ptau_y*p_G*Y_G + ptau_w*w*N + (p_E - p_E_c) * C_E + (p_E - p_E_f) * E);

% government budget constraint
check_fiscal = exp(Grev) / exp(Gexp);

% ///////////////// Monetary policy in Home

% monetary policy, remember to adjust taylor_check below for additional rules
@#if mp_rule == 1
    R = STEADY_STATE(R) * (Pi_G)^(pphi_pi) * nu_R;
@#elseif mp_rule == 2
    R = STEADY_STATE(R) * (Pi)^(pphi_pi) * nu_R;
@#elseif mp_rule == 3
    R = STEADY_STATE(R) * (Pi_nmc)^(pphi_pi) * nu_R;
@#endif

% real rate
rr = R / Pi(+1);

% ///////////////// International trade and Foreign demand

% need to distinguish 2 cases: fully closed economy (all E domestically owned) and open economy (some E imported)
@#if open

    % budget constraint of foreign
    p_G*X - b = p_G*Ystar - R(-1)/Pi*b(-1);

    % demand for exports of foreign
    (X / STEADY_STATE(X)) = (Ystar / STEADY_STATE(Ystar))^pmu_1 * exp(-pmu_2 * (b(-1) - STEADY_STATE(b)) / STEADY_STATE(Ystar));

@#else

    % budget constraint of foreign
    b = 0;

    % demand for exports of foreign
    X = 0;

@#endif

% revenues of foreign
Ystar = p_E/p_G*xi_E * (1-piota);

% real imports
M = xi_E * (1-piota);

% net exports
NX = p_G*X - p_E*M;

% ///////////////// Supply regime for the E-good

@#if regime_E == 1
    (xi_E / STEADY_STATE(xi_E)) = 1 / nu_xi_E;
@#elseif regime_E == 0
    (p_E / STEADY_STATE(p_E)) = nu_p_E;
@#endif

% ///////////////// Market clearing and aggregation

% labor market
N = plambda*N_H + (1-plambda)*N_S;

% E-good market
xi_E = C_E + E;
C_E = plambda*C_H_E + (1-plambda)*C_S_E;

% G-good market
Y_G = C_G + X;
C_G = plambda*C_H_G + (1-plambda)*C_S_G;

% aggregate resource constraint
check_walras = exp(p_E*C_E + p_G*C_G + b) / exp(p_G*Y_G - p_E*E + p_E*xi_E * piota + R(-1)/Pi*b(-1));

% GDP
GDP = p_E*C_E + p_G*C_G + NX;

% ///////////////// Shares

% E-good in consumption
@#if E_in_C
    sh_E_in_C = (p_E * C_E) / (p_E*C_E + p_G*C_G) * 100;
    sh_subsistence = pebar / C_E * 100;
@#else
    sh_E_in_C = 0.0;
    sh_subsistence = 0.0;
@#endif

% E-good in production
@#if E_in_Y
    sh_E_in_Y = (p_E * E) / (p_E*C_E + p_G*C_G) * 100;
@#else
    sh_E_in_Y = 0.0;
@#endif

% E-good in aggregate
sh_E_in_GDP = (p_E * xi_E) / (p_E*C_E + p_G*C_G) * 100;

% ///////////////// Annualization

R_ann = R^4;
rr_ann = rr^4;
Pi_ann = Pi^4;
Pi_G_ann = Pi_G^4;
Pi_E_ann = Pi_E^4;
Pi_nmc_ann = Pi_nmc^4;
Pi_W_ann = Pi_W^4;
Pi_w_ann = Pi_w^4;

% ///////////////// Remaining definitions

X_GDP_devs = X / STEADY_STATE(GDP) * 100;
M_GDP_devs = M / STEADY_STATE(GDP) * 100;
NX_GDP_devs = NX / STEADY_STATE(GDP) * 100;
b_devs = b;

end;

% ///////////////////////////////////////////////////////////////////////////
% /*
% Steady state values block
% */
% ///////////////////////////////////////////////////////////////////////////

steady_state_model;

omega = 1;
FE = 1;
nu_xi_E = 1;
nu_p_E = 1;
nu_R = 1;
nu_T = 1;

p_E = p_E_0;
p_E_c = p_E_0;
p_E_f = p_E_0;
p_G = p_G_0;
w = w_0;

Pi_W = 1;
Pi = 1;
Pi_G = 1;
Pi_E = 1;
Pi_nmc = 1;
Pi_w = 1;

C_H_E = C_H_E_0;
C_S_E = C_S_E_0;
C_E = C_E_0;
C_H_G = C_H_G_0;
C_S_G = C_S_G_0;
C_G = C_G_0;
C_H = C_H_0;
C_S = C_S_0;
C = C_0;
GDP = p_E*C_E + p_G*C_G;
inequality = inequality_0;
inequality_G = C_S_G_0 / C_H_G_0;
@#if E_in_C
    inequality_E = C_S_E / C_H_E;
@#else
    inequality_E = 0.0;
@#endif

N_H = N_H_0;
N_S = N_S_0;
N = N_0;

U_C_H = C_H^(-psigma);
U_C_S = C_S^(-psigma);
U_C = C^(-psigma);
U_N_H = -pchi * N_H^(pvarphi);
U_N_S = -pchi * N_S^(pvarphi);
U_N = -pchi * N^(pvarphi);

xi_E = xi_E_0;
Y_G = Y_G_0;
E = E_0;
D = D_0;
MC = MC_0;

R = rr_0;
rr = rr_0;
T_H = T_H_0;
T_S = T_S_0;
Gexp = Gexp_0;
Grev = Grev_0;

b = 0;
Ystar = X_0;
X = X_0;
M = xi_E * (1-piota);
NX = 0;

check_walras = 1;
check_budget_1 = 1;
check_budget_2 = 1;
check_savers = 1;
check_C_H = 1;
check_C_S = 1;
check_fiscal = 1;

X_GDP_devs = X / GDP * 100;
M_GDP_devs = M / GDP * 100;
NX_GDP_devs = NX / GDP * 100;
b_devs = b;

R_ann = R^4;
rr_ann = rr^4;
Pi_ann = Pi^4;
Pi_G_ann = Pi_G^4;
Pi_E_ann = Pi_E^4;
Pi_nmc_ann = Pi_nmc^4;
Pi_W_ann = Pi_W^4;
Pi_w_ann = Pi_w^4;

sh_E_in_C = sh_E_in_C_0;
sh_E_in_Y = sh_E_in_Y_0;
sh_E_in_GDP = sh_E_in_GDP_0;
sh_subsistence = sh_subsistence_0;

end;

options_.qz_criterium = 1+1e-6; % make sure the option is set for resol below

@#if outputs_steady
    options_.noprint = 0; options_.nograph = 0;
    resid(1);
    check;
    model_diagnostics;
@#else
    options_.noprint = 1; options_.nograph = 1;
@#endif

steady;

% ///////////////////////////////////////////////////////////////////////////
% /*
% Computations
% */
% ///////////////////////////////////////////////////////////////////////////

shocks;
    var epsp = 0.01;
    var epse = 0.01;
    var epsr = 0.01;
    var epssun = 0.01;
    var epst = 0.01;
end;

@#if outputs_results
    options_.noprint = 0; options_.nograph = 0;
    stoch_simul(order = 1, irf = 1000, periods = 1000);
@#else
    options_.noprint = 1; options_.nograph = 1;
    stoch_simul(order = 1, irf = 1000, periods = 1000);
@#endif

store_info = info;

if info ~= 0
    error('The model does not solve!')
end

% code for checking the determinacy of the model, quick version
@#if taylor_check == 1

    % maximum value to look for
    max_taylor_value = 200;

    % passive region
    dyn_passive_ub = NaN;

    % active region
    dyn_active_lb = NaN;

    %% passive region ------------------------------------------------------

    % passive region: start with pphi_pi = 0.0 and increase until model is indeterminate, coarse grid
    start = 0.0;
    step = 0.1;
    check_determinacy = 1;

    while check_determinacy == 1 && start < max_taylor_value

        % checks determinacy of model
        set_param_value('pphi_pi', start);
        [dr,info] = resol(0,M_,options_,oo_);

        % if info(1) == 0, then determinate, else not.
        l_check_determinacy = (info(1) == 0);

        if (l_check_determinacy == 1)
            dyn_passive_ub = start;
            start = start + step;
        else
            check_determinacy = 0;
        end

    end

    % passive region: start with pphi_pi = dyn_passive_ub and increase until model is indeterminate, fine grid
    if ~isnan(dyn_passive_ub)

        start = dyn_passive_ub;
        step = 0.01;
        check_determinacy = 1;

        while check_determinacy == 1 && start < max_taylor_value

            % checks determinacy of model
            set_param_value('pphi_pi', start);
            [dr,info] = resol(0,M_,options_,oo_);

            % if info(1) == 0, then determinate, else not.
            l_check_determinacy = (info(1) == 0);

            if (l_check_determinacy == 1)
                dyn_passive_ub = start;
                start = start + step;
            else
                check_determinacy = 0;
            end

        end

    end

    %% active region 1 -----------------------------------------------------

    % active region: start with pphi_pi = max(0,dyn_passive_ub+0.01) and increase until model is determinate, coarse grid
    start = max(0,dyn_passive_ub+0.01);
    step = 0.1;
    check_determinacy = 0;

    while check_determinacy == 0 && start < max_taylor_value

        % checks determinacy of model
        set_param_value('pphi_pi', start);
        [dr,info] = resol(0,M_,options_,oo_);

        % if info(1) == 0, then determinate, else not.
        l_check_determinacy = (info(1) == 0);

        if (l_check_determinacy == 0)
            start = start + step;
        else
            dyn_active_lb = start;
            check_determinacy = 1;
        end

    end

    % active region: start with pphi_pi = max(0,dyn_active_lb-0.1) and increase until model is determinate, fine grid
    if ~isnan(dyn_active_lb)

        start = max(0,dyn_active_lb-0.1);
        step = 0.01;
        check_determinacy = 0;

        while check_determinacy == 0 && start < max_taylor_value

            % checks determinacy of model
            set_param_value('pphi_pi', start);
            [dr,info] = resol(0,M_,options_,oo_);

            % if info(1) == 0, then determinate, else not.
            l_check_determinacy = (info(1) == 0);

            if (l_check_determinacy == 0)
                start = start + step;
            else
                dyn_active_lb = start;
                check_determinacy = 1;
            end

        end

    end

    % adjust bounds to obtain < or > signs
    dyn_passive_ub = dyn_passive_ub + 0.01; % model is determinate if pphi_pi < dyn_passive_ub
    dyn_active_lb = dyn_active_lb - 0.01; % model is determinate if dyn_active_lb > pphi_pi

@#endif
