function [] = print_figure(name)
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
    set(gcf, 'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    print(gcf, name,'-dpdf','-r400');
    hold off;
    
    cd(folder) 
end

