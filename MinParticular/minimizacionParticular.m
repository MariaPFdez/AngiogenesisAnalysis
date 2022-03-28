%MINIMIZACIÓN DE LA INTEGRAL DE LA DIFERENCIA AL CUADRADO DE LA CONCENTRACIÓN DE FÁRMACO CON DOSIS IGUALES 
%RECIBIDAS EN TIEMPOS EQUIDISTANTES Y UNA CONCENTRACIÓN CONSTANTE 'IDEAL'
clear all
clc

global Tf
global cd
global dmin
global dmax
global D
global lambda
global N

Tf=30;%último día en el que se ven los efectos
dmin=10;%cantidad de fármaco mínima que se puede administrar
dmax=30;%cantidad de fármaco máximo que se puede administrar
D=300;%cantidad total de fármaco administrado
lambda=0.38;%el factor de la exponencial decreciente
j=0;
k=0;
fval=zeros(length(D/dmax:1:D/dmin),1);

%% PLOTEO EL N QUE MINIMIZA LA FUNCIÓN PARA CADA CD
% vecN=zeros(21,1);
% for cd=10:1:30
%      j=0;
%      k=k+1;
%      for N=D/dmin:-1:D/dmax
%         x0=[0.9,0.9,dmin,dmin];%x=[delta,deltainicial,conccarga,conccte];
%         fun=@(x) optisqPart(x)-2*cd*optilinPart(x)+cd^2*Tf;%función ya integrada a minimizar
%         A=[N-2 1 0 0;0 0 1 N-1];b=[Tf*0.999;D];Aeq=[];beq=[];%no hay condiciones lineales
%         lb=[0.3,0.3,dmin,dmin];%valores mínimos de delta, deltainicial, conccarga y conccte
%         ub=[Tf,Tf,dmax,dmax];%valores máximos de delta, deltainicial, conccarga y conccte
%         options=optimset('TolCon',eps,'TolX', eps,'TolFun',eps,'MaxIter',1e12,'MaxFunEvals',1e12);%establezco valores de tolerancias y número de iteraciones
%         [x,fval(length(fval)-j,1)]=fmincon(fun,x0,A,b,Aeq,beq,lb,ub,[],options);
%         if j>1
%             if fval(length(fval)-j,1)>fval(length(fval)-j+1,1)
%                 vecN(k)=N+1;
%                 break
%             end
%         end
%         j=j+1;
%     end
% end
% %vecN=[12,13,14,15,16,18,19,20,21,22,23,24,25,27,28,28,28,28,28,28,28];
% plot([10:1:30],vecN,'.'),xlabel('Cd (mg/kg)'),ylabel('N (nº dosis)')
% hold on %EL N ÓPTIMO AUMENTA A MEDIDA QUE LO HACE CD



% TOMO UN VECTOR X, UN CD Y SU N ÓPTIMO (OBTENCIÓN DE GRÁFICAS)
N=D/dmax;
cd=20;
x0=[0.9,0.9,dmin,dmin];%x=[delta,deltainicial,conccarga,conccte];
fun=@(x) optisqPart(x)-2*cd*optilinPart(x)+cd^2*Tf;%función ya integrada a minimizar
A=[N-2 1 0 0;0 0 1 N-1];b=[Tf*0.999;D];Aeq=[];beq=[];%no hay condiciones lineales
lb=[0.3,0.3,dmin,dmin];%valores mínimos de delta, deltainicial, conccarga y conccte
ub=[Tf,Tf,dmax,dmax];%valores máximos de delta, deltainicial, conccarga y conccte
options=optimset('TolCon',eps,'TolX', eps,'TolFun',eps,'MaxIter',1e12,'MaxFunEvals',1e12);%establezco valores de tolerancias y número de iteraciones
[x,fval,exitflag,output]=fmincon(fun,x0,A,b,Aeq,beq,lb,ub,[],options);
x2=round(x,2);
fval2=fun(x2);
for i=0:1:N-2 %para no tomar la primera concentración que suele ser distinta
    %utilizo el eps por tener una heaviside en cada x2(i)
    min(i+1)=ec1cPart(x2(2)+i*x2(1)-eps,x2);%valor de la concentración en cada mínimo
    max(i+1)=ec1cPart(x2(2)+i*x2(1)+10*eps,x2);%valor de la concentración en cada máximo
end
minimum=round(mean(min),2); %calculo un valor mínimo de la concentración
maximum=round(mean(max),2); %calculo un valor máximo de la concentración
concentracionPart(x2)%representación de la concentración frente al tiempo para el vector obtenido