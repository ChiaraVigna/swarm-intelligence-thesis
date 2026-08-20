% =========================================================================
% Funzione di Benchmark: Drop-Wave
% Confronto ABC (Artificial Bee Colony) vs APSO (Adaptive PSO)
% =========================================================================

% Il fitness restituito sarà vicino e non inferiore a -1
% Il fitness è semplicemente il valore che la funzione obiettivo

clear; clc; close all;

% PARAMETRI DI TEST
n_agents    = 50; 
max_iter = 100;    % Numero di iterazioni
dim      = 2;      % Dimensione del problema (x, y)

bounds = [-5.12, 5.12]; % Dominio di Drop-wave

% Definizione della funzione Drop-Wave
% Formula: f(x) = - (1 + cos(12*sqrt(x1^2 + x2^2))) / (0.5*(x1^2 + x2^2) + 2)
f_obj = @(x) drop_wave(x);

fprintf('--- Inizio Sperimentazione su Funzione di Drop-Wave ---\n\n');

% Esecuzione ABC 
fprintf('1/2. Esecuzione Artificial Bee Colony...\n');
[best_pos_abc, best_fit_abc, history_abc] = ABC(f_obj, n_agents, max_iter, bounds, dim);

% Esecuzione APSO
fprintf('2/2. Esecuzione Adaptive Particle Swarm Optimization...\n');
[best_pos_apso, best_fit_apso, history_apso] = APSO(f_obj, n_agents, max_iter, bounds, dim);

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

% --- 5. Grafico di Confronto Convergenza ---------------------------------
figure;
plot(history_abc, 'r', 'LineWidth', 2); hold on;
plot(history_apso, 'b', 'LineWidth', 2);
grid on;

title('Confronto: ABC vs APSO (Drop-Wave)');
legend('ABC', 'APSO', 'Location', 'northeast');
xlabel('Iterazioni');
ylabel('Best Fitness');
ax = gca;
ax.FontSize = 11;


