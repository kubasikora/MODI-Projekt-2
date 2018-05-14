% MODI - Projekt 2 - Zadanie 36 
% Autor: Jakub Sikora
% Skrypt wykonuje zadanie 1, podpunkt c

% UWAGA - Przed rozpocz�ciem pracy uruchomi� skrypt zad_b.m

% Poszukiwana funkcja y = w1 * u + w0

% Wektor wyj�� Y
Y = y_ucz;

% Macierz M
M(:,1) = ones(1,100);
M(:,2) = u_ucz;

% Policzenie wektora wsp�czynnik�w
w = M\Y;

% Odpowiedz modelu 
u_mod = linspace(-1, 1, 200); 
y_mod = w(2).*u_mod + w(1); 

ucz_error = norm(M*w - y_ucz)^2;

% Wykres uzyskanego modelu na tle danych ucz�cych
figure 
plot(u_mod, y_mod, '-r');
hold on
for i=1:100
    plot(u_ucz(i),y_ucz(i), '.b')
end

% Przygotowanie wykresu do prezentacji
grid on
grid minor
title(strcat('Model liniowy na tle danych ucz�cych, b��d �r. kwadr = ', num2str(ucz_error)));
xlabel('Sterowanie u');
ylabel('Wyj�cie procesu y');
legend('Model liniowy', 'Dane ucz�ce')
print_figure('lin_mod_ucz_comp')
hold off

wer_error = norm(M*w - y_wer)^2;

% Wykres uzyskanego modelu na tle danych weryfikuj�cych
figure 
plot(u_mod, y_mod, '-r');
hold on
for i=1:100
    plot(u_wer(i),y_wer(i), '.b') 
end

% Przygotowanie wykresu do prezentacji
grid on
grid minor
title(strcat('Model liniowy i zbi�r weryfikuj�cy, b��d �r. kwadr = ', num2str(wer_error)))
xlabel('Sterowanie u');
ylabel('Wyj�cie procesu y');
legend('Model liniowy', 'Dane weryfikuj�ce')
print_figure('lin_mod_wer_comp')
hold off

if(w(1) > 0)
sep = '+';
else sep = ' ';
end
disp(strcat('Posta� modelu liniowego:  y =', num2str(w(2)), '*u ', sep, num2str(w(1))))

% Wykres model(dane)
figure 
hold on
for i=1:100
    plot(y(i), y_mod(i), '.b') 
end

% Przygotowanie wykresu do prezentacji
grid on
grid minor
title('Por�wnanie odpowiedzi modelu do danych rzeczywistych')
xlabel('Dane statyczna procesu y');
ylabel('Odpowied� modelu y_mode');
print_figure('lin_mod_od_danych')
hold off
