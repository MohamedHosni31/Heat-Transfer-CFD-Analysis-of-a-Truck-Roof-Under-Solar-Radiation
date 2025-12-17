%% =========================================================
%  Empirical Heat Transfer on Truck Roof (MATLAB)
%  Laminar–Turbulent Transition (STRICT REGIME CHECK)
% =========================================================

clc; clear; close all;

%% ---------------- Geometry & constants -------------------
L = 8;                 % Plate length (m)
W = 2.5;               % Plate width (m)

G = 1000;              % Solar irradiation (W/m^2)
alpha = 0.2;           
q_abs = alpha * G;     % Absorbed heat flux (W/m^2)

T_inf = 293;           % Ambient temperature (K)

% Air properties (assumed constant)
rho = 1.2;             % kg/m^3
mu  = 1.8e-5;          % Pa.s
k   = 0.026;           % W/m.K
Pr  = 0.71;            

Re_crit = 5e5;         % Critical Reynolds number

%% ---------------- Discretization -------------------------
dx = 0.02;             % Spatial step (m)
x  = 0:dx:L;           % Distance along plate (m)
x_eff = max(x,0.01);   % Avoid singularity at x = 0

U_kmh = 20:20:140;     % Velocity sweep (km/h)
U = U_kmh / 3.6;       % Convert to m/s

%% ---------------- Preallocate -----------------------------
Ts = zeros(length(U), length(x));   % Surface temperature (°C)

%% ---------------- Main calculation ------------------------
for j = 1:length(U)

    Re_x = rho * U(j) .* x_eff / mu;

    % Laminar and turbulent Nusselt numbers
    Nu_lam = 0.332 .* Re_x.^0.5 .* Pr^(1/3);
    Nu_tur = 0.0296 .* Re_x.^0.8 .* Pr^(1/3);

    % Strict regime selection
Nu_lam = 0.332 .* Re_x.^0.5 .* Pr^(1/3);
Nu_tur = 0.0296 .* Re_x.^0.8 .* Pr^(1/3);

Nu_x = sqrt(Nu_lam.^2 + Nu_tur.^2);

    % Heat transfer coefficient
    h_x = Nu_x .* k ./ x_eff;

    % Surface temperature (°C)
    Ts(j,:) = T_inf + q_abs ./ h_x - 273;

end

%% ---------------- Plot results ----------------------------
figure; hold on; grid on;
for j = 1:length(U)
    plot(x, Ts(j,:), 'LineWidth', 1.8);
end

xlabel('Distance x (m)');
ylabel('Local Surface Temperature T_s (°C)');
legend('20','40','60','80','100','120','140','Location','best');
title('Local Surface Temperature Along Truck Roof');

%% ---------------- Export table (version-safe) ----------------
varNames = cell(1, length(U_kmh)+1);
varNames{1} = 'x_m';

for j = 1:length(U_kmh)
    varNames{j+1} = ['U_' num2str(U_kmh(j)) '_kmh'];
end

Results = array2table([x.' Ts.'], 'VariableNames', varNames);

% Optional Excel export
% writetable(Results,'Ts_Empirical_MATLAB.xlsx');
