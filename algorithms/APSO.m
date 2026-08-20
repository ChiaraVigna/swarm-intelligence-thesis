% APSO
% Accelerated Particle Swarm Optimization (APSO), una variante semplificata pensata a scopo didattico. 
% Il PSO "canonico" di Kennedy & Eberhart (1995) — ha una struttura diversa, L'APSO converge più rapidamente
% ma è più soggetto a convergenza prematura su ottimi locali, perché non c'è memoria individuale (pbest) 
% a contrastare l'attrazione verso il best globale — tutte le particelle collassano verso lo stesso punto 
% molto più in fretta.

function [best_sol, best_fit, history] = APSO(f_obj, n_particles, iterations, bounds, dim)
    % Accelerated Particle Swarm Optimization (Yang, 2008)
    % Adattamento a n dimensioni della versione didattica pso_simpledemo.m

    lb = bounds(1);
    ub = bounds(2);
    range = ub - lb;

    % PARAMETRI (come nel libro)
    beta = 0.5;        % velocità di convergenza (0=lento, 1=veloce)
    gamma_decay = 0.7; % fattore di decadimento di alpha nel tempo

    % INIZIALIZZAZIONE
    pos = lb + range * rand(n_particles, dim);

    best_fit = inf;
    best_sol = zeros(1, dim);
    history = zeros(iterations, 1);

    for t = 1:iterations

        % alpha decresce nel tempo: alpha = gamma^t
        alpha = gamma_decay^t;

        % VALUTAZIONE 
        fit = zeros(n_particles, 1);
        for i = 1:n_particles
            fit(i) = f_obj(pos(i,:));
        end

        [iter_best, idx] = min(fit);
        if iter_best < best_fit
            best_fit = iter_best;
            best_sol = pos(idx,:);
        end

        % MOVIMENTO: x_new = x*(1-beta) + gbest*beta + alpha*(rand-0.5) 
        for i = 1:n_particles
            pos(i,:) = pos(i,:) .* (1 - beta) + best_sol .* beta ...
                       + alpha * range * (rand(1, dim) - 0.5);
        end

        % CONTROLLO BORDI
        pos = max(min(pos, ub), lb);

        history(t) = best_fit;
    end
end