% Drop-Wave function plot
clear; clc; close all;

% Dominio della funzione
x = -5.12:0.05:5.12;
y = -5.12:0.05:5.12;
[X, Y] = meshgrid(x, y);

% Definizione della funzione Drop-Wave
% f(x,y) = -(1 + cos(12*sqrt(x^2+y^2))) / (0.5*(x^2+y^2) + 2)
R = sqrt(X.^2 + Y.^2);
Z = -(1 + cos(12*R)) ./ (0.5*(X.^2 + Y.^2) + 2);

% Plot 3D (surf)
figure;
surf(X, Y, Z, 'EdgeColor', 'none');
colormap(jet);
colorbar;
xlabel('x_1');
ylabel('x_2');
zlabel('f(x_1, x_2)');
title('Drop-Wave Function');
shading interp;
view(-30, 30);

% Plot 2D (contour) - opzionale, utile per vedere i livelli
figure;
contourf(X, Y, Z, 50, 'LineColor', 'none');
colormap(jet);
colorbar;
xlabel('x_1');
ylabel('x_2');
title('Drop-Wave Function - Contour Plot');
axis equal;