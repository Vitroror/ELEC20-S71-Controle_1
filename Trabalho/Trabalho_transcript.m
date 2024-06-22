% ------------------------------------------------
% UNIVERSIDADE TECNOLOGICA FEDERAL DO PARANA
% DEPARTAMENTO ACADEMICO DE ELETRONICA
%
% CONTROLE 1 - TRABALHO FINAL
%
% FABIO ZHAO YUAN WANG - 
% VICTOR AUGUSTO DEL MONEGO - 2378345
%
% VALOR DE P = 5
% ------------------------------------------------

% comandos iniciais 
clear all
close all
clc

%Questão 1: Análise de Malha Aberta
% declarando o sistema
s = tf('s');
sys = (10*5)/(s*(s+5)*(0.1*s+5))
zpk(sys)

% polos e zeros
pole(sys)
%lugar das raízes

%Critério de estabilidade de routh Hurwitz
K = 1;
K_crit = 27.49;
sys_fb = feedback(K_crit*sys,1)
step(sys_fb)


%Constante de erro
%sistema é do tipo 0 (possui polo na origem)
Kp = dcgain(sys)
err = 1/(1 + Kp)








