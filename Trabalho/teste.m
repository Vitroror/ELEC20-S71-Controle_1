clear all
close all
clc

%TESTE: Controlador de atraso de fase
s = tf('s');
sys = (10*5)/(s*(s+5)*(0.1*s+5));
K = 11;
phi = 50 + 7;
zpk(sys)
margin(K*sys)
alph = 10^(15.7/20);
tau = 1/(0.1*2.85);
D = K * (tau*s+1)/(alph*tau*s+1);
margin(D*sys)
figure(2)
step(feedback(D*sys,1))
stepinfo(feedback(D*sys,1))
