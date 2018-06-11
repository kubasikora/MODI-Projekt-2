% MODI - Projekt 2 - Zadanie 36 
% Autor: Jakub Sikora
% Skrypt wykonuje zadanie 2, podpunkt a

% Przejdz do folderu data
folder = pwd();
cd('../')
cd('../')
cd('data')

% Zaladuj plik z danymi
load danedynucz36.txt
load danedynwer36.txt

% Powrot do folderu scripts
cd(folder)

t = linspace(1,2000,2000);


% Separacja sygnalow
u_ucz = danedynucz36(1:2000,1);
y_ucz = danedynucz36(1:2000,2);


% Zaznaczenie sterowania na wykresie
figure 
hold on;
plot(t, u_ucz, 'b')

% Przygotowanie wykresu do prezentacji
grid on
grid minor
title('Sygna� steruj�cy ucz�cy')
xlabel('Czas dyskretny k');
ylabel('Sygna� steruj�cy');

print_figure('dane_dyn_ucz_u')
hold off;
close
% Zaznaczenie wyjscia na wykresie
figure 
hold on;
plot(t, y_ucz, 'b')

% Przygotowanie wykresu do prezentacji
grid on
grid minor
title('Sygna� wyj�ciowy ucz�cy')
xlabel('Czas dyskretny k');
ylabel('Wyj�cie procesu y');

print_figure('dane_dyn_ucz_y')
hold off;
close

% Wykres wspolny
figure 
hold on;
plot(t, u_ucz, 'b', t, y_ucz, 'r')

% Przygotowanie wykresu do prezentacji
grid on
grid minor
title('Dane ucz�ce');
legend('Sygna� steruj�cy u[k]', 'Sygna� wyj�ciowy y[k]')
xlabel('Czas dyskretny k');
ylabel('Wyj�cie procesu y/ Sygna� steruj�cy u');

print_figure('dane_dyn_ucz_both')
hold off;
close

%%%% Dane weryfikujace

% Separacja sygnalow
u_wer = danedynwer36(1:2000,1);
y_wer = danedynwer36(1:2000,2);

% Zaznaczenie sterowania na wykresie
figure 
hold on;
plot(t, u_wer, 'b')

% Przygotowanie wykresu do prezentacji
grid on
grid minor
title('Sygna� steruj�cy weryfikuj�cy')
xlabel('Czas dyskretny k');
ylabel('Sygna� steruj�cy');

print_figure('dane_dyn_wer_u')
hold off;
close

% Zaznaczenie wyjscia na wykresie
figure 
hold on;
plot(t, y_wer, 'b')

% Przygotowanie wykresu do prezentacji
grid on
grid minor
title('Sygna� wyj�ciowy weryfikuj�cy')
xlabel('Czas dyskretny k');
ylabel('Wyj�cie procesu y');

print_figure('dane_dyn_wer_y')
hold off;
close

% Wykres wspolny
figure 
hold on;
plot(t, u_wer, 'b', t, y_wer, 'r');

% Przygotowanie wykresu do prezentacji
grid on
grid minor
title('Dane weryfikuj�ce');
legend('Sygna� steruj�cy u[k]', 'Sygna� wyj�ciowy y[k]')
xlabel('Czas dyskretny k');
ylabel('Wyj�cie procesu y/ Sygna� steruj�cy u');

print_figure('dane_dyn_wer_both')
hold off;
close