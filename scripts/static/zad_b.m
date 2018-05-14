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

% Wykres danych ucz�cych
figure
for i=1:100
plot(u_ucz(i),y_ucz(i), '.r')
hold on
end

% Przygotowanie wykresu do prezentacji
grid on
grid minor
title('Zbi�r danych ucz�cych')
xlabel('Sterowanie u');
ylabel('Wyj�cie procesu y');

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
title('Zbi�r danych weryfikuj�cych')
xlabel('Sterowanie u');
ylabel('Wyj�cie procesu y');

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
title('Por�wnanie zbior�w ucz�cego i weryfikuj�cego')
xlabel('Sterowanie u');
ylabel('Wyj�cie procesu y');
legend('Zbi�r ucz�cy', 'Zbi�r weryfikuj�cy');

print_figure('dane_comp')
hold off