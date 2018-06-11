% MODI - Projekt 2 - Zadanie 36 
% Autor: Jakub Sikora
% Skrypt wykonuje zadanie 2, podpunkt b

% Przed rozpoczêciem nale¿y uruchomiæ skrypt zad_a.m 

how_many = 7;
poly_deg = 7; 
coeffs{how_many, poly_deg} = [];
err_ucz_arx = zeros(how_many,poly_deg);
err_ucz_oe = zeros(how_many,poly_deg);
err_wer_arx = zeros(how_many,poly_deg);
err_wer_oe = zeros(how_many,poly_deg);

for deg = 1:poly_deg
    for lvl=1:how_many
        na = lvl; % zaleznosc od poprzednich wyjsc
        nb = lvl; % zaleznosc od poprzednich sterowan
        P = 2000;

        % Generacja macierzy M
        Y = y_ucz(nb+1:P);
        M_u = zeros(P - nb, nb*deg);
        M_y = zeros(P - na, na*deg);
        
        for j=nb+1:P
            for i=1:nb
                for k=1:deg
                    M_u(j, (i-1)*deg + k) = power(u_ucz(j - i),k);
                end
            end
        end
        
        for j=na+1:P
            for i=1:na
                for k=1:deg
                    M_y(j, (i-1)*deg + k) = power(y_ucz(j - i),k);
                end
            end
        end
        
        M = [M_u(nb+1:P,:), M_y(nb+1:P,:)];

        % Obliczenie wspó³czynników
        w = M\Y;
        coeffs{lvl,deg} = w;
        
        % Model ARX - zbior uczacy
        y_mod = zeros(P,1);
        
        for j=nb+1:P
            for i=1:nb
                for k=1:deg
                    y_mod(j) = y_mod(j) + w((i-1)*deg + k)*power(u_ucz(j - i),k);
                end
            end
        end
        
        for j=na+1:P
            for i=1:na
                for k=1:deg
                    y_mod(j) = y_mod(j) + w(nb*deg + (i-1)*deg + k)*power(y_ucz(j - i),k);
                end
            end
        end
                   
        % Generacja wykresu
        err_ucz_arx(lvl,deg) = sum((y_mod - y_ucz).^2);

        figure
        t = linspace(0,2000,length(Y));
        hold on
        grid on
        grid minor
        title(strcat('Model ARX - dane ucz¹ce, rz¹d dynamiki = ',num2str(lvl), ', st. = ', num2str(deg), ', b³¹d = ', num2str(err_ucz_arx(lvl,deg))));
        xlabel('Czas dyskretny k');
        ylabel('Wyjœcie procesu y');
        plot(t, y_mod(na+1:P), 'r')
        plot(t, Y, 'b')
        legend('Wyjœcie modelu y_{mod}[k]', 'Wyjœcie procesu y[k]', 'Location', 'southeast')
        hold off
        print_figure(strcat('nonlindyn_arx_ucz_', num2str(lvl), '_deg_', num2str(deg)));
        close
    
        
        % Model OE - zbior uczacy
        y_mod = zeros(P,1);
        
        for j=nb+1:P
            for i=1:nb
                for k=1:deg
                    y_mod(j) = y_mod(j) + w((i-1)*deg + k)*power(u_ucz(j - i),k);
                end
            end
        end
        
        for j=na+1:P
            for i=1:na
                for k=1:deg
                    y_mod(j) = y_mod(j) + w(nb*deg + (i-1)*deg + k)*power(y_mod(j - i),k);
                end
            end
        end
        
        % Generacja wykresu
        err_ucz_oe(lvl,deg) = sum((y_mod - y_ucz).^2);
        
        figure
        hold on
        plot(t, y_mod(na+1:P), 'r')
        plot(t, Y, 'b')
        grid on
        grid minor
        title(strcat('Model OE - dane ucz¹ce, rz¹d dynamiki = ', num2str(lvl), ', st. =', num2str(deg), ', b³¹d = ', num2str(err_ucz_oe(lvl,deg))));
        xlabel('Czas dyskretny k');
        ylabel('Wyjœcie procesu y');
        legend('Wyjœcie modelu y_{mod}[k]', 'Wyjœcie procesu y[k]', 'Location', 'southeast')
        hold off
        print_figure(strcat('nonlindyn_oe_ucz_', num2str(lvl), '_deg_', num2str(deg)));
        close
        
        % Model ARX - zbior weryfikuj¹cy
        y_mod = zeros(P,1);
        
        for j=nb+1:P
            for i=1:nb
                for k=1:deg
                    y_mod(j) = y_mod(j) + w((i-1)*deg + k)*power(u_wer(j - i),k);
                end
            end
        end
        
        for j=na+1:P
            for i=1:na
                for k=1:deg
                    y_mod(j) = y_mod(j) + w(nb*deg + (i-1)*deg + k)*power(y_wer(j - i),k);
                end
            end
        end
                   
        % Generacja wykresu
        err_wer_arx(lvl,deg) = sum((y_mod - y_wer).^2);

        figure
        t = linspace(0,2000,length(Y));
        hold on
        grid on
        grid minor
        title(strcat('Model ARX - dane weryfikuj¹ce, rz¹d dynamiki = ',num2str(lvl), ', st. = ', num2str(deg), ', b³¹d = ', num2str(err_wer_arx(lvl,deg))));
        xlabel('Czas dyskretny k');
        ylabel('Wyjœcie procesu y');
        plot(t, y_mod(na+1:P), 'r')
        plot(t, y_wer(na+1:P), 'b')
        legend('Wyjœcie modelu y_{mod}[k]', 'Wyjœcie procesu y[k]', 'Location', 'southeast')
        hold off
        print_figure(strcat('nonlindyn_arx_wer_', num2str(lvl), '_deg_', num2str(deg)));
        close
        
        % Model OE - zbior weryfikujacy
        y_mod = zeros(P,1);
        
        for j=nb+1:P
            for i=1:nb
                for k=1:deg
                    y_mod(j) = y_mod(j) + w((i-1)*deg + k)*power(u_wer(j - i),k);
                end
            end
        end
        
        for j=na+1:P
            for i=1:na
                for k=1:deg
                    y_mod(j) = y_mod(j) + w(nb*deg + (i-1)*deg + k)*power(y_mod(j - i),k);
                end
            end
        end
        
        % Generacja wykresu
        err_wer_oe(lvl,deg) = sum((y_mod - y_wer).^2);
        
        figure
        hold on
        plot(t, y_mod(na+1:P), 'r')
        plot(t, y_wer(na+1:P), 'b')
        grid on
        grid minor
        title(strcat('Model OE - dane weryfikuj¹ce, rz¹d dynamiki = ', num2str(lvl), ', st =', num2str(deg), ', b³¹d = ', num2str(err_wer_oe(lvl,deg))));
        xlabel('Czas dyskretny k');
        ylabel('Wyjœcie procesu y');
        legend('Wyjœcie modelu y_{mod}[k]', 'Wyjœcie procesu y[k]', 'Location', 'southeast')
        hold off
        print_figure(strcat('nonlindyn_oe_wer_', num2str(lvl), '_deg_', num2str(deg)));
        close
    end
end
save '../../data/dynamic_nonlinear_coeffs.mat' coeffs
save '../../data/dynamic_nonlinear_errors.mat' err_ucz_arx err_ucz_oe err_wer_arx err_wer_oe
