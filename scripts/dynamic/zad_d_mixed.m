% MODI - Projekt 2 - Zadanie 36 
% Autor: Jakub Sikora
% Skrypt wykonuje zadanie 2, podpunkt d, wyrazy mieszane

% Przed rozpoczêciem nale¿y uruchomiæ skrypt zad_d.m 

err_ucz_arx = zeros(2,1);
err_ucz_oe = zeros(2,1);
err_wer_arx = zeros(2,1);
err_wer_oe = zeros(2,1);

P = 2000;
na = 2;
nb = 2;
deg = 2;

for na=2:7
nb = na;
deg = na;
% Generacja macierzy M
Y = y_ucz(nb+1:P);
M_u = zeros(P - nb, nb*deg);
M_y = zeros(P - na, na*deg);
M_m = zeros(P - na, 2);

for j=nb+1:P
    for i=1:nb
        for k=1:deg
            M_u(j, (i-1)*deg + k) = power(u_ucz(j - i),k);
            M_y(j, (i-1)*deg + k) = power(y_ucz(j - i),k);
        end
    end
end

for j=na+1:P
    M_m(j, 1) = y_ucz(j - 1)*u_ucz(j-1);
    M_m(j, 2) = y_ucz(j - 2)*u_ucz(j-2);
end

M = [M_u(nb+1:P,:), M_y(nb+1:P,:), M_m(nb+1:P,:)];
w = M \ Y;

% Model ARX - zbior uczacy
y_mod = zeros(P,1);
for j=nb+1:P
    for i=1:nb
        for k=1:deg
            y_mod(j) = y_mod(j) + w((i-1)*deg + k)*power(u_ucz(j - i),k);
            y_mod(j) = y_mod(j) + w(nb*deg + (i-1)*deg + k)*power(y_ucz(j - i),k);
        end
    end
    y_mod(j) = y_mod(j) + w(9)*u_ucz(j-1)*y_ucz(j-1) + w(10)*u_ucz(j-2)*y_ucz(j-2);
end


% Generacja wykresu
err_ucz_arx(nb-1) = sum((y_mod - y_ucz).^2);

figure
t = linspace(0,2000,length(Y));
hold on
grid on
grid minor
title(strcat('Model ARX - dane ucz¹ce, model z wyrazami mieszanymi, b³¹d = ', num2str(err_ucz_arx(nb-1))));
xlabel('Czas dyskretny k');
ylabel('Wyjœcie procesu y');
plot(t, y_mod(na+1:P), 'r')
plot(t, Y, 'b')
legend('Wyjœcie modelu y_{mod}[k]', 'Wyjœcie procesu y[k]', 'Location', 'southeast')
hold off
print_figure(strcat('nonlin_mix_dyn_arx_coeff_', num2str(nb-1)));
close

% Model OE - zbior uczacy
y_mod = zeros(P,1);

for j=nb+1:P
    for i=1:nb
        for k=1:deg
            y_mod(j) = y_mod(j) + w((i-1)*deg + k)*power(u_ucz(j - i),k);
            y_mod(j) = y_mod(j) + w(nb*deg + (i-1)*deg + k)*power(y_mod(j - i),k);
        end
    end
    y_mod(j) = y_mod(j) + w(9)*u_ucz(j-1)*y_ucz(j-1) + w(10)*u_ucz(j-2)*y_ucz(j-2);
end

% Generacja wykresu
err_ucz_oe(nb-1) = sum((y_mod - y_ucz).^2);

figure
hold on
plot(t, y_mod(na+1:P), 'r')
plot(t, Y, 'b')
grid on
grid minor
title(strcat('Model OE - dane ucz¹ce, model z wyrazami mieszanymi, b³¹d = ', num2str(err_ucz_oe(nb-1))));
xlabel('Czas dyskretny k');
ylabel('Wyjœcie procesu y');
legend('Wyjœcie modelu y_{mod}[k]', 'Wyjœcie procesu y[k]', 'Location', 'southeast')
hold off
print_figure(strcat('nonlin_mix_dyn_oe_coeff_', num2str(nb-1)));
close

% Model ARX - zbior weryfikuj¹cy
y_mod = zeros(P,1);

for j=nb+1:P
    for i=1:nb
        for k=1:deg
            y_mod(j) = y_mod(j) + w((i-1)*deg + k)*power(u_wer(j - i),k);
            y_mod(j) = y_mod(j) + w(nb*deg + (i-1)*deg + k)*power(y_wer(j - i),k);
        end
    end
    y_mod(j) = y_mod(j) + w(9)*u_ucz(j-1)*y_mod(j-1) + w(10)*u_ucz(j-2)*y_mod(j-2);
end

% Generacja wykresu
err_wer_arx(nb-1) = sum((y_mod - y_wer).^2);

figure
t = linspace(0,2000,length(Y));
hold on
grid on
grid minor
title(strcat('Model ARX - dane weryfikuj¹ce, model z wyrazami mieszanymi, b³¹d = ', num2str(err_wer_arx(nb-1))));
xlabel('Czas dyskretny k');
ylabel('Wyjœcie procesu y');
plot(t, y_mod(na+1:P), 'r')
plot(t, y_wer(na+1:P), 'b')
legend('Wyjœcie modelu y_{mod}[k]', 'Wyjœcie procesu y[k]', 'Location', 'southeast')
hold off
print_figure(strcat('nonlin_mix_dyn_arx_wer_coeff_', num2str(nb-1)));close

% Model OE - zbior weryfikujacy
y_mod = zeros(P,1);

for j=nb+1:P
    for i=1:nb
        for k=1:deg
            y_mod(j) = y_mod(j) + w((i-1)*deg + k)*power(u_wer(j - i),k);
            y_mod(j) = y_mod(j) + w(nb*deg + (i-1)*deg + k)*power(y_mod(j - i),k);
        end
    end
    y_mod(j) = y_mod(j) + w(9)*u_ucz(j-1)*y_mod(j-1) + w(10)*u_ucz(j-2)*y_mod(j-2);
end

% Generacja wykresu
err_wer_oe(nb-1) = sum((y_mod - y_wer).^2);

figure
hold on
plot(t, y_mod(na+1:P), 'r')
plot(t, y_wer(na+1:P), 'b')
grid on
grid minor
title(strcat('Model OE - dane weryfikuj¹ce, model z wyrazami mieszanymi, b³¹d = ', num2str(err_ucz_arx(nb-1))));
xlabel('Czas dyskretny k');
ylabel('Wyjœcie procesu y');
legend('Wyjœcie modelu y_{mod}[k]', 'Wyjœcie procesu y[k]', 'Location', 'southeast')
hold off
print_figure(strcat('nonlin_mix_dyn_oe_wer_coeff_', num2str(nb-1)));
close

end

save '../../data/dynamic_nonlinear_mixed_errors.mat' err_ucz_arx err_ucz_oe err_wer_arx err_wer_oe

