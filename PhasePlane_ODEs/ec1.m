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

% %% ODE45 CON EL SISTEMA DE ECUACIONES
% %condiciones iniciales en el vector x0=[v0,k0]
% x0=[180,625];%[V0,K0]
% tf=200; %tiempo final, tf
% f=@(t,x) [-lam1*x(1)*log(x(1)/x(2));-lam2*x(2)+b*x(1)-d*x(2)*x(1)^(2/3)];
% [t,x]=ode45(f,[0,tf],x0);
% plot(t,x)
% grid on
% xlabel('t')
% ylabel('V,K');
% title('Volumen y capacidad de carga en función del tiempo, sin fármaco')
% fig1=figure;
% %plot(x(:,1),x(:,2))
% %hold on

% %% ODE45 CON EL SISTEMA DE ECUACIONES CON FÁRMACO
% %condiciones iniciales en el vector x0=[v0,k0]
% x0=[180,625];
% tf=200; %tiempo final, tf
% %f=@(t,x) [-lam1*x(1)*log(x(1)/x(2))*(1-ec1c(t)*0.7/(0.8+ec1c(t)));-lam2*x(2)+b*x(1)-d*x(2)*x(1)^(2/3)];%citotóxico
% %f=@(t,x) [-lam1*x(1)*log(x(1)/x(2))*(1-30.74*0.7/(0.8+30.74));-lam2*x(2)+b*x(1)-d*x(2)*x(1)^(2/3)]
% %f=@(t,x) [-lam1*x(1)*log(x(1)/x(2));-lam2*x(2)+b*x(1)-d*x(2)*x(1)^(2/3)-e*x(2)*ec1c(t)];%antiangiogénico
% f=@(t,x) [-lam1*x(1)*log(x(1)/x(2));-lam2*x(2)+b*x(1)-d*x(2)*x(1)^(2/3)-e*x(2)*30.74];
% %f=@(t,x) [-lam1*x(1)*log(x(1)/x(2))*(1-ec1c(t)*1.2/(0.8+ec1c(t)));-lam2*x(2)+b*x(1)-d*x(2)*x(1)^(2/3)-e*x(2)*ec1c(t)];%ambos
% [t,x]=ode45(f,[0,tf],x0);
% x(length(x),1)
% plot(t,x)
% xlabel('\it{t}')
% ylabel(['\it{V, K}']);
% title('Volume (\it{V}) \rm{and charge capacity} (\it{K}) \rm{when 30.74 mg/kg of Angiostatin is applied.}')
% legend('V','K')
% fig1=figure;

%% ODE45 CON EL SISTEMA AUTÓNOMO SIN FÁRMACO
%condiciones iniciales del volumen en el vector x0
y0=[625]; 
vf=20000; %cap carga final, kf
fg=@(x,y) [(-lam2*y(1)+b*x-d*y(1)*x^(2/3)-e*y(1)*30.74)/(-lam1*x*log(x/y(1)))];%a partir de 9.38 en adelante falla
[x,y]=ode45(fg,[180,vf],y0);%empiezo por una capacidad de carga superior al volumen inicial
plot(x,y)
grid on
xlabel('V')
ylabel('K');
title('\it{V} \rm{as a function of} \it{K} \rm{when 20.74 mg/kg of a cytotoxic drug is applied}')
grid off
fig2=figure
%por el carácter asintótico del punto crítico la estabilidad NO se alcanza
%a partir de Ve=Ke (17000 aprox)

% %% PLANO DE FASES (queda mejor con el paquete PhasePlane)
% %tamaño de la gráfica
% y1 = linspace(1,20,20);
% y2 = linspace(1,20,20);
% [xx,yy] = meshgrid(y1,y2);
% u = ones(size(xx));
% v = ones(size(xx));
% t=0;
% for i = 1:numel(xx)
%     Yprime = f(t,[xx(i); yy(i)]);
%     u(i) = Yprime(1);
%     v(i) = Yprime(2);
% end
% quiver(xx,yy,u,v,'r'); figure(gcf)
% title('Plano de fases del sistema')
% hold on
% plot(y,x)
