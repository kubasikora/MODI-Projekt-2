% MODI - Projekt 2 - Zadanie 36 
% Autor: Jakub Sikora
% Skrypt wykonuje zadanie 1, podpunkt b

% Przejdz do folderu data
folder = pwd();
cd('../')
cd('../')
cd('data')

% Zaladuj plik z danymi
load danestat36.txt

% Powrot do folderu scripts
cd(folder)

% Separacja sygnalow
u = danestat36(1:200,1);
y = danestat36(1:200,2);

% Podzial na zbior uczacy i zbior weryfikujacy
u_ucz = u(1:2:199);
u_wer = u(2:2:200);

y_ucz = y(1:2:199);
y_wer = y(2:2:200);

% Wykres danych ucz¹cych
figure
for i=1:100
plot(u_ucz(i),y_ucz(i), '.r')
hold on
end

% Przygotowanie wykresu do prezentacji
grid on
grid minor
title('Zbiór danych ucz¹cych')
xlabel('Sterowanie u');
ylabel('Wyjœcie procesu y');

print_figure('dane_ucz')
hold off


% Wykres danych weryfikujacych
figure 
for i=1:100
plot(u_wer(i),y_wer(i), '.b')
hold on
end

% Przygotowanie wykresu do prezentacji
grid on
grid minor
title('Zbiór danych weryfikuj¹cych')
xlabel('Sterowanie u');
ylabel('Wyjœcie procesu y');

print_figure('dane_wer')
hold off

% Porownanie zestawu uczacego i weryfikujacego
figure
for i=1:100
plot(u_wer(i),y_wer(i), '.b')
plot(u_ucz(i),y_ucz(i), '.r')
hold on
end

% Przygotowanie wykresu do prezentacji
grid on
grid minor
title('Porównanie zbiorów ucz¹cego i weryfikuj¹cego')
xlabel('Sterowanie u');
ylabel('Wyjœcie procesu y');
legend('Zbiór ucz¹cy', 'Zbiór weryfikuj¹cy');

print_figure('dane_comp')
hold off