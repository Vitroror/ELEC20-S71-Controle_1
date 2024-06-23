% ------------------------------------------------
% UNIVERSIDADE TECNOLOGICA FEDERAL DO PARANA
% DEPARTAMENTO ACADEMICO DE ELETRONICA
%
% CONTROLE 1 - TRABALHO FINAL
%
% FABIO ZHAO YUAN WANG - 2358310
% VICTOR AUGUSTO DEL MONEGO - 2378345
% 
% QUESTÃO 2 - CONTROLADOR DE MARGEM DE FASE
%
% VALOR DE P = 5
% ------------------------------------------------

clear all
close all
clc

%declarando o sistema
s = tf('s');
sys = (10*5)/(s*(s+5)*(0.1*s+5));

%ganho arbitrário
K = 11;
%margem máxima usando a margem desejada
phi = 50 + 7;

zpk(sys)

%diagrama de Bode do sistema descompensado
figure(1)
margin(K*sys)

%determinação dos parâmetros de fase
alph = 10^(15.7/20);
tau = 1/(0.1*2.85);

%Sistema compensado com controlador de atraso de fase
figure(2)
D = K * (tau*s+1)/(alph*tau*s+1);
margin(D*sys)

%teste de sobressalto
figure(3)
step(feedback(D*sys,1))
stepinfo(feedback(D*sys,1))
