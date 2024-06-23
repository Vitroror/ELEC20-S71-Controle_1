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

%declarando o sistema
s=tf('s');
sys = (10*5)/(s*(s+5)*(0.1*s+5));

%ver a freq de cruzamento
margin(sys)
figure(1)

%frequência de cruzamento de fase obtida observando o gráfico
wcf = 15.8;

%achar o K utilizando G
G = -28.8;
K = 10^(-G/20);
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

%comparação dos sobrepassos de controladores
step(sys_crit_fb)
figure()
step(sys_fb, "red")
hold on
step(sys_fb_c)

