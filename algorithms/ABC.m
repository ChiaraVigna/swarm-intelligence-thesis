% implementazione di ABC fedele allo schema canonico di Karaboga (2005) 

function [best_sol, best_fit, history] = ABC(f_obj, n_bees, iterations, bounds, dim)

    lb = bounds(1);
    ub = bounds(2);
    range = ub - lb;

    % In ABC, n_bees è diviso a metà: employed + onlooker
    % (numero di "food sources" = n_employed)
    n_employed = round(n_bees / 2);
    if n_employed < 2
        error('n_employed deve essere maggiore o uguale a 2 (serve almeno una seconda fonte k diversa da i)!');
    end
    limit = n_employed * dim;   % soglia di abbandono standard: SN * D

    % Inizializzazione food sources
    pop = lb + range * rand(n_employed, dim);
    fit = zeros(n_employed, 1);
    for i = 1:n_employed
        fit(i) = f_obj(pop(i,:));
    end

    trial = zeros(n_employed, 1);  % tiene il conto di quante volte una fonte è stata migliorata

    best_fit = inf;
    best_sol = zeros(1, dim);
    history = zeros(iterations, 1);

    for t = 1:iterations

        % FASE 1: EMPLOYED BEES 
        for i = 1:n_employed
            candidate = pop(i,:);

            % scegli dimensione j e sorgente k diversa da i da cui prendere spunto
            j = randi(dim);
            k = randi(n_employed);
            while k == i
                k = randi(n_employed);
            end

            phi = -1 + 2*rand;   % phi in [-1, 1]
            % Ogni ape employed genera un candidato modificando una sola coordinata j della propria 
            % soluzione, spostandosi lungo la direzione data da un'altra fonte k scelta a caso
            candidate(j) = pop(i,j) + phi * (pop(i,j) - pop(k,j));
            candidate = max(min(candidate, ub), lb);

            cand_fit = f_obj(candidate);

            % Selezione greedy 
            if cand_fit < fit(i) % se il candidato è migliore sostituisce la fonte resettando trial
                pop(i,:) = candidate;
                fit(i) = cand_fit;
                trial(i) = 0;
            else % altrimenti incrementa trial
                trial(i) = trial(i) + 1;
            end
        end

        % FASE 2: ONLOOKER BEES
        % Trasformazione fitness canonica (Karaboga & Basturk, 2007):
        %   fitness(x) = 1/(1+f(x))      se f(x) >= 0
        %   fitness(x) = 1 + |f(x)|      se f(x) < 0
        fitness_val = zeros(n_employed, 1);
        for i = 1:n_employed
            if fit(i) >= 0
                fitness_val(i) = 1 / (1 + fit(i));
            else
                fitness_val(i) = 1 + abs(fit(i));
            end
        end

        % probabilità con termine minimo 0.1 per non escludere mai una fonte
        prob = 0.9 * (fitness_val / max(fitness_val)) + 0.1;
        prob = prob / sum(prob);           % rinormalizza a somma 1
        cum = cumsum(prob);
        cum(end) = 1;                  


        count = 0;
        while count < n_employed
            r = rand;
            src = find(r <= cum, 1, 'first');   % sorgente selezionata

            candidate = pop(src,:);
            j = randi(dim);
            k = randi(n_employed);
            while k == src
                k = randi(n_employed);
            end

            phi = -1 + 2*rand;
            candidate(j) = pop(src,j) + phi * (pop(src,j) - pop(k,j));
            candidate = max(min(candidate, ub), lb);

            cand_fit = f_obj(candidate);

            if cand_fit < fit(src)
                pop(src,:) = candidate;
                fit(src) = cand_fit;
                trial(src) = 0;
            else
                trial(src) = trial(src) + 1;
            end

            count = count + 1;
        end

        % FASE 3: SCOUT BEES 
        [max_trial, idx] = max(trial);
        if max_trial > limit
            pop(idx,:) = lb + range * rand(1, dim);
            fit(idx) = f_obj(pop(idx,:));
            trial(idx) = 0;
        end

        % BEST UPDATE 
        % Ad ogni iterazione si controlla se la fonte migliore della popolazione batte 
        % best_fit, aggiornando best_sol solo in caso di miglioramento 
        [current_best, idx] = min(fit);
        if current_best < best_fit
            best_fit = current_best;
            best_sol = pop(idx,:);
        end

        history(t) = best_fit;

    end

end
