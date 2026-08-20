% Script MATLAB per la visualizzazione della funzione Rastrigin (2D e 3D)

clear; clc; close all;

% 1. Definizione del grigliato (dominio standard [-5.12, 5.12])
x = linspace(-5.12, 5.12, 200);
y = linspace(-5.12, 5.12, 200);
[X, Y] = meshgrid(x, y);

% 2. Calcolo della funzione Rastrigin per D = 2
% f(x,y) = 20 + (x^2 - 10*cos(2*pi*x)) + (y^2 - 10*cos(2*pi*y))
Z = 20 + (X.^2 - 10*cos(2*pi*X)) + (Y.^2 - 10*cos(2*pi*Y));

% 3. Creazione della figura
figure('Name', 'Visualizzazione Funzione Rastrigin', 'Color', 'w', 'Position', [100, 100, 1100, 500]);

% --- SUBPLOT 1: Grafico 3D (Surface plot + Contour proiettato) ---
subplot(1, 2, 1);
surfc(X, Y, Z, 'EdgeColor', 'none');
colormap jet;
shading interp;
colorbar;

hold on;
% Evidenzia l'ottimo globale in (0,0)
plot3(0, 0, 0, 'r*', 'MarkerSize', 12, 'LineWidth', 2);

title('Superficie 3D - Rastrigin');
xlabel('x_1'); ylabel('x_2'); zlabel('f(x_1, x_2)');
grid on;
view([-37.5, 30]); % Angolo di visuale ottimale

% --- SUBPLOT 2: Mappa di livello 2D (Contour plot) ---
subplot(1, 2, 2);
contourf(X, Y, Z, 30, 'LineColor', 'none');
colormap jet;
colorbar;

hold on;
% Evidenzia l'ottimo globale
plot(0, 0, 'rp', 'MarkerSize', 12, 'MarkerFaceColor', 'r');

title('Curve di Livello 2D (Contour)');
xlabel('x_1'); ylabel('x_2');
axis square;
grid on;