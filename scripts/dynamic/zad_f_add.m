% MODI - Projekt 2 - Zadanie 36 
% Autor: Jakub Sikora
% Skrypt wykonuje zadanie 1, podpunkt d

% UWAGA - Przed rozpoczêciem pracy nale¿y wyczyscic workspace'a i uruchomiæ skrypt zad_b.m

r = 4; % rzad modelu
load x
% Wektor wyjœæ Y
Y = x;
u_ucz = u_vect';
y_ucz = x;

M = zeros(200, r+1);
% Macierz M
for i=1:(r+1)
    M(:,i) = u_ucz.^(i-1);
end

% Policzenie wektora wspó³czynników
w = M\Y;

% Odpowiedz modelu 
u_mod = linspace(-1, 1, 200); 
y_mod = zeros(1,200);

% obliczenie wielomianu
for i=1:(r+1)
    y_mod = y_mod + w(i).*u_mod.^(i-1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Wykresy                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% obliczenie wielomianu
y_ucz_mod = zeros(200,1);
for i=0:r
    y_ucz_mod = y_ucz_mod + (u_ucz.^i).*w(i+1);
end

ucz_error = 0;
for i=1:100
    ucz_error = ucz_error + (y_ucz_mod(i) - y_ucz(i))^2;
end

% Wykres uzyskanego modelu na tle danych ucz¹cych
figure 
plot(u_mod, y_mod, '-r');
hold on
plot(u_ucz, y_ucz, '.b')

% Przygotowanie wykresu do prezentacji
grid on
grid minor
title(strcat('Model liniowy na tle danych ucz¹cych, b³¹d œr. kwadr = ', num2str(ucz_error)));
xlabel('Sterowanie u');
ylabel('Wyjœcie procesu y');
legend('Model liniowy', 'Dane ucz¹ce')
%print_figure(strcat('mod_ucz_comp_r_', num2str(r)))
hold off
