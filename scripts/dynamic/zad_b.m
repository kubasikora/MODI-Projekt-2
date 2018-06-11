% MODI - Projekt 2 - Zadanie 36 
% Autor: Jakub Sikora
% Skrypt wykonuje zadanie 2, podpunkt b

% Przed rozpoczêciem nale¿y uruchomiæ skrypt zad_a.m 


how_many = 10;
coeffs = [];
err_ucz_arx = zeros(how_many);
err_ucz_oe = zeros(how_many);
err_wer_arx = zeros(how_many);
err_wer_oe = zeros(how_many);

for lvl=1:how_many
    na = lvl; % zaleznosc od poprzednich wyjsc
    nb = lvl; % zaleznosc od poprzednich sterowan
    P = 2000;

    % Generacja macierzy M
    Y = y_ucz(nb+1:P);
    M = zeros(P - nb, nb + na);

    for i=nb:(-1):1
        for j=1:(P-nb)
            M(j,i) = u_ucz(nb + j - i);
        end
    end


    for i=nb+na:(-1):nb+1
        for j=1:(P-na)
            M(j,i) = y_ucz(na + j - i + nb);
        end
    end

    % Obliczenie wspó³czynników
    w = M\Y;
    coeffs{lvl} = w;
    
    % Model ARX
    y_mod = zeros(P,1);

    for k=nb+1:P
        for i=nb:(-1):1
            y_mod(k) = y_mod(k) + w(nb-i+1)*u_ucz(k-nb+i-1);
        end
        for i=na:(-1):1
            y_mod(k) = y_mod(k) + w(nb+na-i+1)*y_ucz(k-nb+i-1);  
        end
    end

    err_ucz_arx(lvl) = sum((y_mod - y_ucz).^2);

    figure
    t = linspace(0,2000,length(Y));
    hold on
    grid on
    grid minor
    title(strcat('Model ARX - dane ucz¹ce, Rz¹d dynamiki = ', num2str(lvl), ', B³¹d = ', num2str(err_ucz_arx(lvl))));
    xlabel('Czas dyskretny k');
    ylabel('Wyjœcie procesu y');
    plot(t, y_mod(na+1:P), 'r')
    plot(t, Y, 'b')
    legend('Wyjœcie modelu y_{mod}[k]', 'Wyjœcie procesu y[k]', 'Location', 'southeast')
    hold off
    print_figure(strcat('lindyn_arx_ucz_', num2str(lvl)));
    close
    
    % Model OE
    y_mod = zeros(P,1);

    for k=nb+1:P
        for i=nb:(-1):1
            y_mod(k) = y_mod(k) + w(nb-i+1)*u_ucz(k-nb+i-1);
        end
        for i=na:(-1):1
            y_mod(k) = y_mod(k) + w(nb+na-i+1)*y_mod(k-nb+i-1);  
        end
    end
    
    err_ucz_oe(lvl) = sum((y_mod - y_ucz).^2);

    figure
    hold on
    plot(t, y_mod(na+1:P), 'r')
    plot(t, Y, 'b')
    grid on
    grid minor
    title(strcat('Model OE - dane ucz¹ce, rzad dynamiki = ', num2str(lvl), ',B³¹d = ', num2str(err_ucz_oe(lvl))));
    xlabel('Czas dyskretny k');
    ylabel('Wyjœcie procesu y');
    legend('Wyjœcie modelu y_{mod}[k]', 'Wyjœcie procesu y[k]', 'Location', 'southeast')
    hold off
    print_figure(strcat('lindyn_oe_ucz_', num2str(lvl)));
    close

    % Model ARX
    y_mod = zeros(P,1);

    for k=nb+1:P
        for i=nb:(-1):1
            y_mod(k) = y_mod(k) + w(nb-i+1)*u_wer(k-nb+i-1);
        end
        for i=na:(-1):1
            y_mod(k) = y_mod(k) + w(nb+na-i+1)*y_wer(k-nb+i-1);  
        end
    end

    err_wer_arx(lvl) = sum((y_mod - y_wer).^2);

    figure
    t = linspace(0,2000,length(Y));
    hold on
    plot(t, y_mod(na+1:P), 'r')
    plot(t, y_wer(na+1:P), 'b')
    grid on
    grid minor
    title(strcat('Model ARX - dane weryfikuj¹ce, rzad = ', num2str(lvl), ', B³¹d = ', num2str(err_wer_arx(lvl))));  
    xlabel('Czas dyskretny k');
    ylabel('Wyjœcie procesu y');
    legend('Wyjœcie modelu y_{mod}[k]', 'Wyjœcie procesu y[k]', 'Location', 'southeast')
    hold off
    print_figure(strcat('lindyn_arx_wer_', num2str(lvl)));
    close
    
    % Model OE
    y_mod = zeros(P,1);

    for k=nb+1:P
        for i=nb:(-1):1
            y_mod(k) = y_mod(k) + w(nb-i+1)*u_wer(k-nb+i-1);
        end
        for i=na:(-1):1
            y_mod(k) = y_mod(k) + w(nb+na-i+1)*y_mod(k-nb+i-1);  
        end
    end

    err_wer_oe(lvl) = sum((y_mod - y_wer).^2);

    figure
    hold on
    plot(t, y_mod(na+1:P), 'r')
    plot(t, y_wer(na+1:P), 'b')
    grid on
    grid minor
    title(strcat('Model OE - dane weryfikuj¹ce, rzad dynamiki = ', num2str(lvl), ', B³¹d = ', num2str(err_wer_oe(lvl))));    
    xlabel('Czas dyskretny k');
    ylabel('Wyjœcie procesu y');
    legend('Wyjœcie modelu y_{mod}[k]', 'Wyjœcie procesu y[k]', 'Location', 'southeast')
    hold off
    print_figure(strcat('lindyn_oe_wer_', num2str(lvl)));
    close
end
save '../../data/dynamic_linear_coeffs.mat' coeffs
save '../../data/dynamic_linear_errors.mat' err_ucz_arx err_ucz_oe err_wer_arx err_wer_oe