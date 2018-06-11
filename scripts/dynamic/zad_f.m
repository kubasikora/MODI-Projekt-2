% MODI - Projekt 2 - Zadanie 36 
% Autor: Jakub Sikora
% Skrypt wykonuje zadanie 2, podpunkt f

% Przed rozpoczêciem nale¿y uruchomiæ skrypt zad_d.m 

a = coeffs{5,4};
count = 0;
x = zeros(200,1);
u_vect = linspace(-1,1,200);
for i=1:200
    u = u_vect(i);
    f = @(y)   (a(1) + a(5) + a(9) + a(13) + a(17))*u + ...
               (a(2) + a(6) + a(10) + a(14) + a(18))*u^2 + ...
               (a(3) + a(7) + a(11) + a(15) + a(19))*u^3 + ...
               (a(4) + a(8) + a(12) + a(16) + a(20))*u^4 + ...
               (a(21) + a(25) + a(29) + a(33) + a(37))*y + ...
               (a(22) + a(26) + a(30) + a(34) + a(38))*y^2 + ...
               (a(23) + a(27) + a(31) + a(35) + a(39))*y^3 + ...
               (a(24) + a(28) + a(32) + a(36) + a(40))*y^4;

   x(i) = fsolve(f, 0);
end

figure
hold on
plot(u_vect, x, 'b')
grid on
grid minor
title('Charakterystyka statyczna procesu');
xlabel('Sygna³ steruj¹cy u');
ylabel('Wyjœcie procesu y');
hold off
print_figure('chtyka_stat_mod_nielin');