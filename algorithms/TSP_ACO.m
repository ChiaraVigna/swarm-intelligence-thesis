% ACO discreto - versione semplice per il Traveling Salesman Problem (TSP)
% Segue lo pseudocodice: Objective f(x_ij), evaporazione gamma,
% loop su n nodi, generazione soluzioni, aggiornamento feromone,
% ricerca del best corrente.

% La risoluzione del Problema del Commesso Viaggiatore (TSP) è stata sviluppata in ambiente MATLAB 
% prendendo come riferimento il lavoro di Maquin (2024). 
% La struttura di base dell'algoritmo sono stati successivamente integrati, personalizzati e 
% riadattati dall'autore per le specifiche esigenze della campagna sperimentale condotta in questa tesi.

% Script basato sul lavoro originale di Didier Maquin (2024), “TSP2024”, MATLAB Central File Exchange

% Nelle varie simulazioni condotte sono stati opportunamente modificati gli iper-partametri alpha, beta e gamma

clear; clc; close all;

% Dati del problema: coordinate delle citta' (nodi) 
rng(1); % per riproducibilita'
n = 15; % numero di nodi (citta')
coords = rand(n,2)*100; % coordinate casuali

% Matrice delle distanze s(i,j) che rappresenta f(x_ij)
S = zeros(n,n);
for i = 1:n
    for j = 1:n
        S(i,j) = norm(coords(i,:) - coords(j,:));
    end
end
S(S==0) = eps; % evita divisioni per zero sulla diagonale

% Parametri ACO
nAnts     = 30; % numero di formiche
maxIter   = 100; % numero iterazioni massime
alpha = 2;  % parametro che controlla il peso del ferormone
beta = 2; % parametro che controlla l'influenza della distanza
gamma     = 0.5; % tasso di evaporazione del feromone
Q         = 1; % iperparametro costante per il rilascio di feromone

% Inizializzazione feromone
phi = ones(n,n); % phi_ij iniziale (vettore di tutti uni)
D = 1 ./ S; % informazione euristica (desiderabilità dello stesso percorso. Più è vicino = più è attraente)

bestLength = inf;
bestRoute  = [];
bestHistory = zeros(maxIter,1);

% Ciclo principale
for iter = 1:maxIter

    allRoutes  = zeros(nAnts, n);
    allLengths = zeros(nAnts, 1);

    % for loop over all ants (equivalente al "for loop over nodes" tipico di TSP)
    % per ogni formica k si parte da un nodo casuale
    for k = 1:nAnts

        % Genera una nuova soluzione per la formica k
        route = zeros(1,n);
        visited = false(1,n);

        start = randi(n);
        route(1) = start;
        visited(start) = true;

        for step = 2:n
            curr = route(step-1);

            % Probabilita' di transizione verso i nodi non visitati
            p = zeros(1,n);
            for j = 1:n
                if ~visited(j) % se false, se j non è ancora stato visitato
                    p(j) = (phi(curr,j)^alpha) * (D(curr,j)^beta);
                end
            end
            p = p / sum(p);

            % Selezione del prossimo nodo tramite roulette wheel
            nextNode = randSelect(p);

            route(step) = nextNode;
            visited(nextNode) = true;
        end

        % Calcolo della lunghezza totale del tour
        L = 0;
        for step = 1:n-1
            % somma le distanze tra città consecutive nel percorso trovato dalla formica 
            L = L + S(route(step), route(step+1));
        end
        % alla fine aggiunge la distanza di ritorno dall'ultima città alla prima (il commesso viaggiatore deve tornare al punto di partenza)
        L = L + S(route(n), route(1));   % torna al nodo di partenza

        allRoutes(k,:)  = route;
        allLengths(k)   = L;
    end
    % end for formiche 

    % Deposito del ferormone
    % Per ogni formica (non solo la migliore), si percorre di nuovo il suo tour e si deposita feromone (deltaPhi) su ogni arco attraversato
    deltaPhi = zeros(n,n); % deltaPhi inizializzato a 0
    for k = 1:nAnts
        route = allRoutes(k,:);
        L = allLengths(k);
        for step = 1:n-1
            a = route(step); b = route(step+1);
            % il feromone viene depositato simmetricamente perchè grafo non orientato
            deltaPhi(a,b) = deltaPhi(a,b) + Q/L;
            deltaPhi(b,a) = deltaPhi(b,a) + Q/L;
        end
        a = route(n); b = route(1);
        deltaPhi(a,b) = deltaPhi(a,b) + Q/L;
        deltaPhi(b,a) = deltaPhi(b,a) + Q/L;
    end

    % Update del feromone phi_ij <- (1-gamma)*phi_ij + delta_phi_ij
    phi = (1 - gamma) * phi + deltaPhi;

    % Tracciamento del migliore 
    % Trova la formica con il tour più corto di questa iterazione
    [minL, idx] = min(allLengths);
    if minL < bestLength
        bestLength = minL;
        bestRoute  = allRoutes(idx,:);
    end
    bestHistory(iter) = bestLength;

    fprintf('Iterazione %3d - Migliore lunghezza: %.3f\n', iter, bestLength);
end
% end while ciclo principale


% Output dei risultati
fprintf('\nMiglior percorso trovato (lunghezza = %.3f):\n', bestLength);
disp(bestRoute);

figure;
subplot(1,2,1);
plot(bestHistory, 'LineWidth', 1.5);
xlabel('Iterazione'); ylabel('Lunghezza migliore');
title('Convergenza ACO'); grid on;

subplot(1,2,2);
routeCoords = coords([bestRoute, bestRoute(1)], :);
plot(routeCoords(:,1), routeCoords(:,2), 'o-', 'LineWidth', 1.5);
hold on;
plot(coords(:,1), coords(:,2), 'k.', 'MarkerSize', 15);
title('Percorso migliore (TSP)');
xlabel('x'); ylabel('y'); axis equal; grid on;



% Funzione ausiliaria: selezione roulette wheel
function idx = randSelect(p)
    cumP = cumsum(p); %calcola la somma cumulativa del vettore probabilità
    r = rand(); % genera un numero casuale tra 0 e 1
    idx = find(cumP >= r, 1, 'first'); % trova il primo indice dove la somma cumulativa supera r
end