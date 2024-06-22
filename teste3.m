clear all
close all
clc

s=tf('s');
sys = (10*5)/(s*(s+5)*(0.1*s+5));
%ver a freq de cruzamento
margin(sys)
figure()
wcf = 15.8;
%achar o K utilizando G
G = -28.8;
%G = -20log(K)
K = 10^(-G/20)
Kr = 27.49;

Tu = 2*pi/wcf;

Kp = 0.6*Kr
Ki = 2*Kp/Tu
Kd = Kp*Tu/8
C = Kp + Ki/s + Kd*s

sys_fb_c = feedback(C*sys, 1);
sys_fb = feedback(sys, 1);
sys_crit_fb = feedback(sys*(Kr), 1);

step(sys_crit_fb)
figure()
step(sys_fb, "red")
hold on
step(sys_fb_c)

