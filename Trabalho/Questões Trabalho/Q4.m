% ------------------------------------------------
% UNIVERSIDADE TECNOLOGICA FEDERAL DO PARANA
% DEPARTAMENTO ACADEMICO DE ELETRONICA
%
% CONTROLE 1 - TRABALHO FINAL
%
% FABIO ZHAO YUAN WANG - 2358310
% VICTOR AUGUSTO DEL MONEGO - 2378345
% 
% QUESTÃO 4 - CONTROLADOR PID
%
% VALOR DE P = 5
% ------------------------------------------------


clear all
close all
clc

%objetivo:
%atingir as especificações do exercicio anterior
%overshooting = 10.6%
%settling time = 0.161s
%Rise time = 0.052

%declarando o sistema
s=tf('s');
sys = (10*5)/(s*(s+5)*(0.1*s+5));

%Tentativa 1:
%ver a freq de cruzamento
margin(sys)
figure(1)

%frequência de cruzamento de fase obtida observando o gráfico
wcf = 15.8;

%achar o K utilizando G
G = -28.8;
K = 10^(-G/20);
%comparando com o K_routh, foi decidido utilizar 
%o próprio K_routh
Kr = 27.49;
Tu = 2*pi/wcf;

%Parâmetros tabelados da tabela de Ziegler-Nichols
Kp = 0.6*Kr;
Ki = 2*Kp/Tu;
Kd = Kp*Tu/8;
C = Kp + Ki/s + Kd*s;

%fechamento da malha
sys_fb_c = feedback(C*sys, 1);
sys_fb = feedback(sys, 1);
sys_crit_fb = feedback(sys*(Kr), 1);

%comparação entre a malha fechada do
%sistema sem o controlador (vermelho)
%e com o controlador

step(sys_fb, "red")
hold on
step(sys_fb_c)

%por este método, podemos ver que o
%overshooting e o tempo de assentamento
%não foram cumpridas.

%Por isso, decidimos criar um pseudo-PID
%e, das características do pseudo-PID
%achar uma expressão para um PID que
%tenha um comportamento prox do pseudo

%tentativa 2:
%utilizando controlSystemDesigner() e na
%tentativa e erro
%foi possível chegar na seguinte expressão
%para o pseudo-PID com as especificações desejadas:
%Cm = 0.0075205*(0.2*s+1)*(1+2*10^3*s)/(s*(1+0.001*s))
%utilizando Cm como base, foi possível projetar
% o seguinte PID:
a1 = 3.008*1000;
a2 = 15.04*1000;
a3 = 0.007521*1000;
b1 = 1000;

%a1, a2, a3, b1 são coeficientes dos polinomios
%do numerador e do denominador de Cm
%que quando escritos em termos de Kp, Ki, Kd:

Kpm = (-a3+a2*b1)/(b1^2);
Kim = a3/b1;
Kdm = (a3-a2*b1+a1*(b1^2))/(b1^3);

%daqui, equacionamos o PID:
Cm1 = Kpm + Kim/s + Kdm*s;
sys_fb_cm1 = feedback(Cm1*sys, 1);

%comparação gráfica das duas malhas fechadas
%PID <- azul
%controlador ex3 <- vermelho
figure()
step(sys_fb_cm1)
hold on

A = [0 1 0 ; 0 0 1 ; 0 -25 -5.5];
B = [0 ; 0 ; 1];
C = [50 0 0];
P = [-20+1i*34.64 -20-1i*34.64 -50.5 ];
K= place(A,B,P);
MJ=C*inv(-A+B*K)*B;
J=1/MJ;
controller=ss(A-B*K, B*J,C,[]);
step(controller, "red")
stepinfo(sys_fb_cm1)
stepinfo(controller)