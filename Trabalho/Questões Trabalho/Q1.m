% ------------------------------------------------
% UNIVERSIDADE TECNOLOGICA FEDERAL DO PARANA
% DEPARTAMENTO ACADEMICO DE ELETRONICA
%
% CONTROLE 1 - TRABALHO FINAL
%
% FABIO ZHAO YUAN WANG - 2358310
% VICTOR AUGUSTO DEL MONEGO - 2378345
% 
% QUESTÃO 1 - ANÁLISE DE MALHA ABERTA
%
% VALOR DE P = 5
% ------------------------------------------------

% comandos iniciais 
clear all
close all
clc

% declarando o sistema
s = tf('s');
sys = (10*5)/(s*(s+5)*(0.1*s+5))
zpk(sys)

% polos e zeros
pole(sys)
%lugar das raízes
figure(1);
rlocus(sys)
%Critério de estabilidade de routh Hurwitz
K = 1;
K_crit = 27.49;
sys_fb = feedback((K_crit)*sys,1)
figure(2)
step(sys_fb)


%Constante de erro
%sistema é do tipo 1 (possui polo na origem)
Ktst = K_crit/2
Kv = 10*Ktst*5/(5*5)
errv = 1/Kv

% Visto que Kv é proporcional ao Ktst, e
% Kv é inversamente proporcional ao errv
% então, o único jeito de reduzir o erro associado à
% metade é dobrando o Kv, isto é, temos de
% dobrar o Ktst. Portanto, se reduzimos o erro à metade
% temos de dobrar o Ktst (I). Tendo (I) em mente:

% Para controladores com Ktst<K_routh/2,
% ao dobrar o valor de Ktst, garantimos a estabilidade
% já que 2*Ktst<K_routh, e, de (I) 
% conseguimos reduzir o erro à metade.

% Para controladores com K_routh/2 < Ktst < K_routh, 
% ao dobrarmos Ktst, afim de reduzir a metade
% o erro associado, não garantimos a
% estabilidade, já que K_routh < 2*Ktst.










