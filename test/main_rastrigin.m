%TEST OK: test con ABC e APSO nel dominio continuo con la benchmark Rastrigin

clear; clc; close all;

% PARAMETRI DI TEST
dim = 2;
bounds = [-5.12, 5.12]; % Dominio Rastrigin
n_agents = 50;          % Stessa popolazione "nominale" per entrambi
iterations = 100;
limit = 15;             % Parametro Scout per ABC

% Funzione Obiettivo
f_obj = @Rastrigin;

% ESECUZIONE ABC 
[abc_sol, abc_fit, abc_hist] = ABC(f_obj, n_agents, iterations, bounds, dim);

% ESECUZIONE APSO (Il codice di Yang)
[pso_sol, pso_fit, pso_hist] = APSO(f_obj, n_agents, iterations, bounds, dim);

% RISULTATI A VIDEO
fprintf('ALGORITMO ABC\n');
fprintf('Best Fitness: %e\n', abc_fit);
fprintf('Minimo trovato in: x = %f, y = %f\n\n', abc_sol(1), abc_sol(2));
fprintf('ALGORITMO APSO\n');
fprintf('Best Fitness: %e\n', pso_fit);
fprintf('Minimo trovato in: x = %f, y = %f\n\n', pso_sol(1), pso_sol(2));


% GRAFICO
% Nota: Rastrigin ha minimo globale = 0, e semilogy non può rappresentare
% log(0). Si clippano le history con un epsilon minimo per evitare che
% la curva si interrompa silenziosamente vicino alla convergenza.
eps_floor = 1e-10;
abc_hist_plot = max(abc_hist, eps_floor);
pso_hist_plot = max(pso_hist, eps_floor);

figure;
semilogy(abc_hist_plot, 'r', 'LineWidth', 2); hold on;
semilogy(pso_hist_plot, 'b', 'LineWidth', 2);
grid on;
title('Confronto: ABC vs APSO (Rastrigin)');
xlabel('Iterazioni');
ylabel('Best Fitness');
legend('ABC', 'APSO');