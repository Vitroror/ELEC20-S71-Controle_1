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
K = 4.53;
%margem máxima usando a margem desejada
phi = 50 + 5;
%diagrama de Bode do sistema descompensado
figure(1)
margin(sys)

%determinação dos parâmetros de fase
alph = 10^(5/20);
tau = 1/(0.1*3.03);
z = 1/tau;
p = 1/alph*tau;

%Sistema compensado com controlador de atraso de fase
figure(2)
D = K*(s+z)/(s+p);
margin(D*sys)

%teste de sobressalto
figure(3)
step(feedback(D*sys,1))
stepinfo(feedback(D*sys,1))
