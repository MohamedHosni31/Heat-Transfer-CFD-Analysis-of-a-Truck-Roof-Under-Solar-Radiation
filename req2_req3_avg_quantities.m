%% =========================================================
%  Requirements 2 & 3
%  Average Heat Transfer & Drag vs Velocity
% =========================================================

clc; clear; close all;

%% ---------------- Geometry & constants -------------------
L = 8;                 % Plate length (m)
W = 2.5;               % Plate width (m)
A = L * W;             % Area (m^2)

G = 1000;              % Solar irradiation (W/m^2)
alpha = 0.2;
q_abs = alpha * G;     % Absorbed heat flux (W/m^2)

T_inf = 293;           % Ambient temperature (K)

% Air properties
rho = 1.2;             % kg/m^3
mu  = 1.8e-5;          % Pa.s
k   = 0.026;           % W/m.K
Pr  = 0.71;

%% ---------------- Velocity sweep -------------------------
U_kmh = 20:20:140;
U = U_kmh / 3.6;       % m/s

%% ---------------- Spatial discretization -----------------
dx = 0.02;
x = 0:dx:L;
x_eff = max(x,0.01);

%% ---------------- Preallocation --------------------------
h_avg   = zeros(size(U));
Ts_avg  = zeros(size(U));
Cf_avg  = zeros(size(U));
Fd      = zeros(size(U));

%% ---------------- Main loop -------------------------------
for j = 1:length(U)

    % ---- Local Reynolds number ----
    Re_x = rho * U(j) .* x_eff / mu;

    % ---- Fully turbulent local Nusselt number ----
    Nu_x = 0.0296 .* Re_x.^0.8 .* Pr^(1/3);

    % ---- Local heat transfer coefficient ----
    h_x = Nu_x .* k ./ x_eff;

    % ---- Average heat transfer coefficient ----
    h_avg(j) = (1/L) * trapz(x, h_x);

    % ---- Average surface temperature ----
    Ts_avg(j) = T_inf + q_abs / h_avg(j) - 273;

    % ---- Reynolds number based on plate length ----
    Re_L = rho * U(j) * L / mu;

    % ---- Average skin-friction coefficient ----
    Cf_avg(j) = 0.074 / Re_L^(1/5);

    % ---- Aerodynamic drag force ----
    Fd(j) = 0.5 * rho * U(j)^2 * A * Cf_avg(j);

end

% -------- Interpolation for smooth curves --------
U_kmh_fine = linspace(min(U_kmh), max(U_kmh), 300);

Ts_avg_smooth = interp1(U_kmh, Ts_avg, U_kmh_fine, 'pchip');
h_avg_smooth  = interp1(U_kmh, h_avg,  U_kmh_fine, 'pchip');

Fd_smooth     = interp1(U_kmh, Fd,     U_kmh_fine, 'pchip');
Cf_avg_smooth = interp1(U_kmh, Cf_avg, U_kmh_fine, 'pchip');

%% ---------------- Plots ----------------------------------
figure;
yyaxis left
plot(U_kmh_fine, Ts_avg_smooth, 'LineWidth', 2);
ylabel('Average Surface Temperature T_{s,avg} (°C)');

yyaxis right
plot(U_kmh_fine, h_avg_smooth, 'LineWidth', 2);
ylabel('Average Heat Transfer Coefficient h_{avg} (W/m^2·K)');

grid on;
xlabel('Velocity U (km/h)');
title('Average Surface Temperature and Heat Transfer Coefficient vs Velocity');
legend('T_{s,avg}','h_{avg}','Location','best');

figure;
yyaxis left
plot(U_kmh_fine, Fd_smooth, 'LineWidth', 2);
ylabel('Drag Force F_d (N)');

yyaxis right
plot(U_kmh_fine, Cf_avg_smooth, 'LineWidth', 2);
ylabel('Average Skin-Friction Coefficient C_{f,avg}');

grid on;
xlabel('Velocity U (km/h)');
title('Aerodynamic Drag Force and Skin-Friction Coefficient vs Velocity');
legend('F_d','C_{f,avg}','Location','best');


%% ---------------- Export results table -------------------
Results_avg = table( ...
    U_kmh.', Ts_avg.', h_avg.', Cf_avg.', Fd.', ...
    'VariableNames', ...
    {'U_kmh','Ts_avg_C','h_avg_W_m2K','Cf_avg','Fd_N'} );

% Optional export
% writetable(Results_avg,'Req2_Req3_Results.xlsx');
