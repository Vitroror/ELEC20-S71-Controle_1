clear all
close all
clc

%TESTE: Controlador de atraso de fase
% s = tf('s');
% sys = (10*5)/(s*(s+5)*(0.1*s+5));
% K = 11;
% phi = 50 + 7;
% zpk(sys)
% margin(K*sys)
% alph = 10^(15.7/20);
% tau = 1/(0.1*2.85);
% D = K * (tau*s+1)/(alph*tau*s+1);
% figure(2)
% margin(D*sys);
% figure(3)
% step(feedback(D*sys,1))
% stepinfo(feedback(D*sys,1))

%TESTE: controlador de alocação de polos
s = tf('s');
sys = (10*5)/(s*(s+5)*(0.1*s+5))
rlocus(sys)
grid on;
hold on;
% Polos desejados
polos_desejados = [-20 + 34.64i, -20 - 34.64i];
plot(real(polos_desejados), imag(polos_desejados), 'rx', 'MarkerSize', 10, 'LineWidth', 2)

A = [0 1 0 ; 0 0 1 ; 0 -25 -5.5];
B = [0 ; 0 ; 1];
C = [50 0 0];

P = [-20+1i*34.64 -20-1i*34.64 -50 ];
K= place(A,B,P);
I=eye(size(A));
MJ=C*inv(-A+B*K)*B;
J=1/MJ;
controller=ss(A-B*K, B*J,C,[]);
figure(2)
step(controller)
hold on;
grid on;
stepinfo(controller)
damp(controller)