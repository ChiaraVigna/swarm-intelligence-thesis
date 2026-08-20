% plot di ackely

[X, Y] = meshgrid(-32:0.5:32, -32:0.5:32);
Z = zeros(size(X));

for i = 1:size(X,1)
    for j = 1:size(X,2)
        Z(i,j) = ackley([X(i,j), Y(i,j)]);
    end
end

figure(2);
surf(X, Y, Z);
shading interp; % Rende i colori sfumati
colormap jet;   % Usa colori caldi per le vette e freddi per le valli
colorbar;
title('Superficie della Funzione di Ackley');
xlabel('x'); ylabel('y'); zlabel('f(x,y)');
