% ------------------------------------------------
% UNIVERSIDADE TECNOLOGICA FEDERAL DO PARANA
% DEPARTAMENTO ACADEMICO DE ELETRONICA
%
% CONTROLE 1 - TRABALHO FINAL
%
% FABIO ZHAO YUAN WANG - 2358310
% VICTOR AUGUSTO DEL MONEGO - 2378345
% 
% QUESTÃO 3 - CONTROLADOR POR ALOCAÇÃO DE POLOS
%
% VALOR DE P = 5
% ------------------------------------------------

clear all
close all
clc

%declaração do sistema
s = tf('s');
sys = (10*5)/(s*(s+5)*(0.1*s+5));

%lugar das raízes
rlocus(sys)
grid on;
hold on;

% Polos desejados
polos_desejados = [-20 + 34.64i, -20 - 34.64i];
plot(real(polos_desejados), imag(polos_desejados), 'rx', 'MarkerSize', 10, 'LineWidth', 2)

%matrizes na forma canônica de controlabilidade
A = [0 1 0 ; 0 0 1 ; 0 -25 -5.5];
B = [0 ; 0 ; 1];
C = [50 0 0];

%Operações matriciais para construção do sistema (slides aula 16)
P = [-20+1i*34.64 -20-1i*34.64 -50 ];
K= place(A,B,P);
I=eye(size(A));
MJ=C*inv(-A+B*K)*B;
J=1/MJ;

%controlador feito
controller=ss(A-B*K, B*J,C,[]);
figure(2)
step(controller)
hold on;
grid on;
stepinfo(controller)
damp(controller)