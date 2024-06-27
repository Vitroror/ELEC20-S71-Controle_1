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
figure(1)
margin(sys)

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
Cont1 = Kp + Ki/s + Kd*s;

%fechamento da malha
sys_cont1 = feedback(Cont1*sys, 1);
sys_fb = feedback(sys, 1);
sys_crit_fb = feedback(sys*(Kr), 1);

%comparação entre os PIDS será feita nessa figura
figure(2)
step(sys_cont1, "red")
hold on
stepinfo(sys_cont1)

%por este método, podemos ver que o
%overshooting e o tempo de assentamento
%não foram cumpridas.

%vamos para mais tentativas com diferentes ajustes

%Parâmetros tabelados da tabela de Ziegler-Nichols ajustados para
%sobressinal reduzido
Kp2 = Kr/3;
Ki2 = Kp/(0.5*Tu);
Kd2 = Kp*Tu/3;
Cont2 = Kp2 + Ki2/s + Kd2*s;

%tentando novamente...
sys_cont2 = feedback(Cont2*sys, 1);
step(sys_cont2, "green")

%mais uma tentativa, agora ajustando todos os ganhos mais precisamente
Kp3 = 0.2*Kr;
Ki3 = Kp/(0.5*Tu);
Kd3 = Kp*Tu/3;
Cont3 = Kp3 + Ki3/s + Kd3*s;

sys_cont3 = feedback(Cont3*sys, 1);
step(sys_cont3, "blue")

%até agora o melhor controlador é o em verde.
%Ajustando os ganhos arbitráriamente, temos outro

Cont4 = Kp + 0.01*(Ki)/s + 2.3*Kd*s;
sys_cont4 = feedback(Cont4*sys, 1);
step(sys_cont4, "yellow")
%comparação gráfica das duas malhas fechadas
%PID <- azul
%controlador ex3 <- vermelho
figure(3)
step(sys_cont4, "blue")
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
stepinfo(sys_cont4)
stepinfo(controller)