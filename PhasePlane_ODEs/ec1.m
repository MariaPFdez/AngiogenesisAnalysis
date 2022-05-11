%% ECUACIÓN 1: TUMOR+ANGIOGENESIS
%V' = -lam1*V*log(V/K)
%K'= -lam2*K+b*V-d*K*V^(2/3)

global tf
%Inicializo las variables (artículo)
lam1=0.192;
lam2=0; 
b=5.85;
d=0.00873; %pto critico del artículo, V=K=17346.52
%e=1.3;%para el fármaco TNP
%e=0.66;%para el fármaco Endostatina
e=0.15;%para el fármaco Angiostatina

%% ODE45 CON EL SISTEMA DE ECUACIONES
%condiciones iniciales en el vector x0=[v0,k0]
x0=[180,625];%[V0,K0]
tf=2000; %tiempo final, tf
f=@(t,x) [-lam1*x(1)*log(x(1)/x(2));-lam2*x(2)+b*x(1)-d*x(2)*x(1)^(2/3)-e*x(2)*ec1c(t)];
[t,x]=ode45(f,[0,tf],x0);
plot(t,x(:,2),'Color','#bc98f3')
hold on 
grid off
plot(t,x(:,1),'Color','#d1052a')
xlabel('\it{t} \rm{(days)}')
ylabel('\it{V, K} \rm{(mm^3)}');
legend('K','V')
title('\it{V} \rm{y} \it{K} \rm{en función del tiempo, con dosis de} \it{d_i}= \rm{20 mg/kg}')
fig1=figure;
% plot(x(:,1),x(:,2))
% hold on

%% ODE45 CON EL SISTEMA DE ECUACIONES CON FÁRMACO
%condiciones iniciales en el vector x0=[v0,k0]
x0=[180,625];
tf=5000; %tiempo final, tf
%f=@(t,x) [-lam1*x(1)*log(x(1)/x(2))*(1-ec1c(t)*0.7/(0.8+ec1c(t)));-lam2*x(2)+b*x(1)-d*x(2)*x(1)^(2/3)];%citotóxico
%f=@(t,x) [-lam1*x(1)*log(x(1)/x(2))*(1-30.74*0.7/(0.8+30.74));-lam2*x(2)+b*x(1)-d*x(2)*x(1)^(2/3)]
f=@(t,x) [-lam1*x(1)*log(x(1)/x(2));-lam2*x(2)+b*x(1)-d*x(2)*x(1)^(2/3)-e*x(2)*ec1c(t)];%antiangiogénico
[t1,x1]=ode45(f,[0,tf],x0);
f=@(t,x) [-lam1*x(1)*log(x(1)/x(2));-lam2*x(2)+b*x(1)-d*x(2)*x(1)^(2/3)-e*x(2)*15.32];
%f=@(t,x) [-lam1*x(1)*log(x(1)/x(2))*(1-ec1c(t)*1.2/(0.8+ec1c(t)));-lam2*x(2)+b*x(1)-d*x(2)*x(1)^(2/3)-e*x(2)*ec1c(t)];%ambos
[t,x]=ode45(f,[0,tf],x0);
f=@(t,x) [-lam1*x(1)*log(x(1)/x(2));-lam2*x(2)+b*x(1)-d*x(2)*x(1)^(2/3)-e*x(2)*25.32];
[t2,x2]=ode45(f,[0,tf],x0);
x(length(x),1)
plot(t,x(:,1))
hold on
plot(t1,x1(:,1))
hold on
plot(t2,x2(:,1))
xlabel('\it{t}')
ylabel(['\it{V}']);
title('Volume (\it{V}) \rm{when c_{min}, c_{max} and c(t) if Treatment 2 is applied.}')
legend('c_{min}','c(t)','c_{max}')
fig1=figure;

%% ODE45 CON EL SISTEMA AUTÓNOMO SIN FÁRMACO
%condiciones iniciales del volumen en el vector x0
y0=[625]; 
vf=20000; %cap carga final, kf
fg=@(x,y) [(-lam2*y(1)+b*x-d*y(1)*x^(2/3)-e*y(1)*20.74)/(-lam1*x*log(x/y(1)))];%a partir de 9.38 en adelante falla
[x,y]=ode45(fg,[180,vf],y0);%empiezo por una capacidad de carga superior al volumen inicial
plot(x,y)
grid on
xlabel('V')
ylabel('K');
title('\it{K} \rm{as a function of} \it{V} \rm{when 20.74 mg/kg of Angiostatin drug is applied}')
grid off
fig2=figure
%por el carácter asintótico del punto crítico la estabilidad NO se alcanza
%a partir de Ve=Ke (17000 aprox)


