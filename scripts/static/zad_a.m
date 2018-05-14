% MODI - Projekt 2 - Zadanie 36 
% Autor: Jakub Sikora
% Skrypt wykonuje zadanie 1, podpunkt a

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

% Zaznaczenie danych na wykresie
for i=1:200
plot(u(i),y(i), '.b')
hold on
end

% Przygotowanie wykresu do prezentacji
grid on
grid minor
title('Statyczne dane pomiarowe')
xlabel('Sterowanie u');
ylabel('Wyjœcie procesu y');

% Wyjdz z folderu scripts
folder = pwd();
cd('../')
cd('../')

% Stwórz folder na wykresy jeœli jeszcze nie istnieje
if(exist('figures', 'dir') == 0)
    mkdir('figures');
end
cd('figures')

if(exist('stat', 'dir') == 0)
    mkdir('stat');
end
cd('stat')

% Zapis wykresu do pliku
set(gcf, 'Units','Inches');
pos = get(gcf, 'Position');
set(gcf, 'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize', [pos(3), pos(4)])
print(gcf, 'dane_overall','-dpdf','-r400');
hold off;

% Powrot do folderu scripts
cd(folder)