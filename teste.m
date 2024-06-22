clear all
close all
clc

%Questão 1: Análise de Malha Aberta
% declarando o sistema
s = tf('s');
sys = (2)/(s*(s+2));
K = 10;
zpk(sys)
margin(K*sys)