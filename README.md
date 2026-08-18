# Nature-Inspired Metaheuristics & Swarm Intelligence
Questo repository contiene il codice sorgente, gli esperimenti e i benchmark sviluppati per la tesi di laurea:  
**"Swarm Intelligence: Analisi Comparativa di Algoritmi Metaeuristici ispirati dalla Natura"**


**Laureanda:** Chiara Vigna
**Relatore:** Prof. Mirco Rampazzo
**Anno Accademico:** 2025/2026
**Corso di Laurea:** Ingegneria Informatica

---
## Panoramica del progetto
**Descrizione:** Codice sorgente e algoritmi di Swarm Intelligence per la tesi.

### Algoritmi Implementati
* Accelerated Particle Swarm Optimization (APSO)
* Ant Colony Optimization (ACO)
* Artificial Bee Colony (ABC)

## Struttura
```text
swarm-intelligence-thesis/
│
├── algorithms/
│   ├── apso.m               % Accelerated Particle Swarm Optimization
│   ├── abc.m                % Artificial Bee Colony
│   └── aco_tsp.m            % Ant Colony Optimization per TSP (completo e autonomo)
│
├── benchmarks/
│   ├── rastrigin.m          % Funzione benchmark Rastrigin
│   ├── ackley.m             % Funzione benchmark Ackley
│   └── drop_wave.m          % Funzione benchmark Drop-Wave
│
├── plots/
│   ├── plot_rastrigin.m     % Grafico/superficie 3D della funzione Rastrigin
│   ├── plot_ackley.m        % Grafico/superficie 3D della funzione Ackley
│   └── plot_drop_wave.m     % Grafico/superficie 3D della funzione Drop-Wave
│
├── test/
│   ├── main_rastrigin.m     % Test e confronto algoritmi su Rastrigin
│   ├── main_ackley.m        % Test e confronto algoritmi su Ackley
│   └── main_drop_wave.m     % Test e confronto algoritmi su Drop-Wave
│
├── .gitignore               % File per ignorare i file temporanei MATLAB
└── README.md                % Guida rapida all'esecuzione
```

## Riferimenti Bibliografici

Gli algoritmi e le funzioni di test implementati fanno riferimento ai seguenti lavori:

- **APSO:** Zhan, Z. H., et al. (2009). *Adaptive particle swarm optimization*. IEEE Transactions on Systems, Man, and Cybernetics.
- **ABC:** Karaboga, D., & Basturk, B. (2007). *A powerful and efficient algorithm for numerical function optimization: artificial bee colony (ABC) algorithm*. Journal of Global Optimization.
- **ACO (TSP):** Dorigo, M., & Gambardella, L. M. (1997). *Ant colony system: a cooperative learning approach to the traveling salesman problem*. IEEE Transactions on Evolutionary Computation.
- **Benchmark Functions:** Jamil, M., & Yang, X. S. (2013). *A literature survey of benchmark functions for global optimisation problems*. International Journal of Mathematical Modelling and Numerical Optimisation.
