% =========================================================================
% Funzione di Benchmark: Ackley
% Confronto ABC (Artificial Bee Colony) vs APSO (Adaptive PSO)
% =========================================================================

% Nota bene: la Ackley è una funzione molto più impegnativa della Drop-Wave per questo tipo di 
% algoritmi — ha una superficie quasi piatta (con rumore da coseno) lontano dall'origine e una "buca" 
% stretta e ripida vicino al minimo, quindi è normale se convergenza è più lenta o se noti differenze di 
% comportamento più marcate tra ABC e APSO rispetto a prima. Utile proprio per mostrare in tesi 
% come si comportano i due algoritmi su funzioni con caratteristiche diverse (multimodale "a onde" vs 
% "quasi piatta con buca stretta").

clear; clc; close all;

% --- 1. Configurazione Parametri Generali ---
n_agents    = 50;     % Dimensione della popolazione
max_iter = 100;    % Numero di generazioni
dim      = 2;      % Dimensione del problema (x, y)
bounds   = [-32, 32]; % Dominio ackely
obiettivo = @(x) ackley(x);

% fprintf('Inizio Sperimentazione su Funzione di Ackley\n\n');

% 2. Esecuzione ABC (Artificial Bee Colony) 
%fprintf('1/2. Esecuzione Artificial Bee Colony...\n');
[best_pos_abc, best_fit_abc, history_abc] = ABC(obiettivo, n_agents, max_iter, bounds, dim);

% --- 3. Esecuzione APSO (Adaptive Particle Swarm Optimization) ----------
%fprintf('2/2. Esecuzione Accelerated Particle Swarm Optimization...\n');
[best_pos_apso, best_fit_apso, history_apso] = APSO(obiettivo, n_agents, max_iter, bounds, dim);

% --- 4. Visualizzazione Risultati Finali in Console ---------------------
fprintf('\n====================================================\n');
fprintf('         RISULTATI FINALI DI OTTIMIZZAZIONE         \n');
fprintf('====================================================\n');
fprintf('ALGORITMO ABC:\n');
fprintf(' Best Fitness: %e\n', best_fit_abc);
fprintf(' Minimo trovato in: x = %f, y = %f\n\n', best_pos_abc(1), best_pos_abc(2));

fprintf('ALGORITMO APSO:\n');
fprintf(' Best Fitness: %e\n', best_fit_apso);
fprintf(' Minimo trovato in: x = %f, y = %f\n', best_pos_apso(1), best_pos_apso(2));
fprintf('====================================================\n');

% --- 5. Grafico di Confronto Convergenza (scala logaritmica) -------------
% Nota: la Ackley ha minimo teorico f=0, quindi per la scala logaritmica
% (log(0) non e' definito) sostituiamo eventuali zeri con un epsilon minimo.
eps_plot = 1e-12;
history_abc_plot  = max(history_abc,  eps_plot);
history_apso_plot = max(history_apso, eps_plot);

figure;
semilogy(history_abc_plot, 'r', 'LineWidth', 2); hold on;
semilogy(history_apso_plot, 'b', 'LineWidth', 2);
grid on;

title('Confronto: ABC vs APSO (Ackley)');
legend('ABC', 'APSO', 'Location', 'northeast');
xlabel('Iterazioni');
ylabel('Best Fitness');
ax = gca;
ax.FontSize = 11;