% MODI - Projekt 2 - Zadanie 36 
% Autor: Jakub Sikora
% Skrypt wykonuje zadanie 1, podpunkt c

% UWAGA - Przed rozpoczêciem pracy uruchomiæ skrypt zad_b.m

% Poszukiwana funkcja y = w1 * u + w0

% Wektor wyjœæ Y
Y = y_ucz;

% Macierz M
M(:,1) = ones(1,100);
M(:,2) = u_ucz;

% Policzenie wektora wspó³czynników
w = M\Y;

% Postac modelu liniowego
disp(strcat('Postaæ modelu liniowego:  y =', num2str(w(2)), '*u + ', num2str(w(1))))

% Odpowiedz modelu 
u_mod = linspace(-1, 1, 200); 
y_mod = w(2).*u_mod + w(1); 

% obliczenie bledu dla zbioru uczacego
    % obliczenie odpowiedzi modelu dla czesci uczacej
    y_ucz_mod = w(2).*u_ucz + w(1);

    % obliczenie sumy bledow
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
print_figure('lin_mod_ucz_comp')
hold off

% obliczenie bledu dla zbioru weryfikujacego
    % obliczenie odpowiedzi modelu dla czesci weryfikujacej
    y_wer_mod = w(2).*u_wer + w(1);
    
    %obliczenie sumy bledow
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
print_figure('lin_mod_wer_comp')
hold off

y_c = zeros(200,1);
y_c = w(2).*u + w(1);

% Wykres model(dane)
figure 
hold on
for i=1:100
    plot(y_c(i), y(i), '.b') 
end

% Przygotowanie wykresu do prezentacji
grid on
grid minor
title('Porównanie odpowiedzi modelu do danych rzeczywistych')
xlabel('Dane statyczna procesu y');
ylabel('OdpowiedŸ modelu y_mode');
print_figure('lin_mod_od_danych')
hold off
