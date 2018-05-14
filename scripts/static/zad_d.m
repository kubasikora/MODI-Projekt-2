% MODI - Projekt 2 - Zadanie 36 
% Autor: Jakub Sikora
% Skrypt wykonuje zadanie 1, podpunkt d

% UWAGA - Przed rozpoczêciem pracy uruchomiæ skrypt zad_b.m

r = 2; % rzad modelu

% Wektor wyjœæ Y
Y = y_ucz;

M = zeros(100, r+1);
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
y_ucz_mod = zeros(100,1);
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
for i=1:100
    plot(u_ucz(i),y_ucz(i), '.b')
end

% Przygotowanie wykresu do prezentacji
grid on
grid minor
title(strcat('Model liniowy na tle danych ucz¹cych, b³¹d œr. kwadr = ', num2str(ucz_error)));
xlabel('Sterowanie u');
ylabel('Wyjœcie procesu y');
legend('Model liniowy', 'Dane ucz¹ce')
print_figure(strcat('lin_mod_ucz_comp_r_', num2str(r)))
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% obliczenie wielomianu
y_wer_mod = zeros(100 ,1);
for i=0:r
    y_wer_mod = y_wer_mod + (u_wer.^i).*w(i+1);
end

wer_error = 0;
for i=1:100
    wer_error = wer_error + (y_wer_mod(i) - y_wer(i))^2;
end

% Wykres uzyskanego modelu na tle danych weryfikuj¹cych
figure 
plot(u_mod, y_mod, '-r');
hold on
for i=1:100
    plot(u_wer(i),y_wer(i), '.b') 
end

% Przygotowanie wykresu do prezentacji
grid on
grid minor
title(strcat('Model liniowy i zbiór weryfikuj¹cy, b³¹d œr. kwadr = ', num2str(wer_error)))
xlabel('Sterowanie u');
ylabel('Wyjœcie procesu y');
legend('Model liniowy', 'Dane weryfikuj¹ce')
print_figure(strcat('lin_mod_wer_comp_r_', num2str(r)))
hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Wykres model(dane)
figure 
hold on


% obliczenie wielomianu
y_comp = zeros(200,1);
for i=0:r
    y_comp = y_comp + (u.^i).*w(i+1);
end

for i=1:200
    plot(y_comp(i), y(i), '.b') 
end

% Przygotowanie wykresu do prezentacji
grid on
grid minor
title('Porównanie odpowiedzi modelu do danych rzeczywistych')
xlabel('Dane procesu');
ylabel('OdpowiedŸ modelu');
print_figure(strcat('lin_mod_od_danych_r_', num2str(r)));
hold off
