clear all
clc
%MINIMIZACIÓN DE LA INTEGRAL DE LA DIFERENCIA ENTRE LA CONCENTRACIÓN DEL
%FÁRMACO EN CASO GENERAL (CON VARIABLES N, T_1...,T_N,D_1,...,D_N) Y UNA CONCENTRACIÓN IDEAL
global Tf dmin dmax D lambda N
format short e
Tf=30;%último día en el que se ven los efectos
dmin=10;%cantidad de fármaco mínima que se puede administrar
dmax=30;%cantidad de fármaco máximo que se puede administrar
D=300;%cantidad total de fármaco administrado
lambda=0.38;%el factor de la exponencial decreciente

%% PLOTEO EL N QUE MINIMIZA LA FUNCIÓN PARA CADA CD (ME DA TAMBIÉN INFO TANTO DE LOS X COMO DE LOS J EN CADA CASO)
len=length(2:1:floor(D/dmin));
j=0;
fval=sparse(len,1);
for N=2:floor(D/dmin)
    j=j+1;
    x0=[linspace(1,30,N-1),D*ones(1,N)/N];%x=[t=(0,t1,...,tN-1),d=(d1,...,dN)];
    fun=@(x) optisqCd(x)-optilinCd(x);%función ya integrada a minimizar
    A=sparse(N-1,2*N-1); %condiciones lineales de desigualdad
    A(1:N-1,1:N-1)=diag(ones(N-1,1))+diag(-ones(N-2,1),1);A(N-1,N:2*N-1)=ones(N,1);A(N-1,N-1)=0;
    b=-0.3*ones(N-1,1);b(N-1,1)=D;
    Aeq=[];beq=[];%no hay condiciones lineales de igualdad
    lb=[0.3,zeros(1,N-2),dmin*ones(1,N)];%valores mínimos de los tiempos y las dosis administradas
    ub=[Tf*ones(1,N-2),0.999*Tf,dmax*ones(1,N)];%valores máximos de los tiempos y las dosis administradas (tomo t1=0 por simplicidad, haciendo que sus cotas superior
    % e inferior sean nulas)
    options=optimset('TolCon',eps,'TolX', eps,'TolFun',eps,'MaxIter',1e12,'MaxFunEvals',1e12);
    [y,fval(j,1)]=fmincon(fun,x0,A,b,Aeq,beq,lb,ub,[],options);%el mínimo valor de la función se obtiene para x
    ti=[0,y(1:N-1)];%vector de tiempos en los que se administra la dosis
    di=y(N:2*N-1);%cantidad de fármaco administrado en cada caso
    cdopt=0;
    for i=1:1:N
        suma=(di(i)*(1-exp(lambda*(ti(i)-Tf))));
        cdopt=cdopt+suma;
    end
    cdoptimo(j,2)=cdopt/(Tf*lambda);
    cdoptimo(j,1)=N;
end
color="#FF1D87";
plot(2:floor(D/dmin),fval,'.','MarkerSize',10,'Color',color),title('\it{J_{c_d^{min}}^N} \rm{minimum values for different number of doses}'),xlabel('\it{N} \rm{(nº doses)}'),ylabel('Objective function of (\it{P_{1,c_d^{min}}^N}), \it{J_{c_d^{min}}^N}')
hold on
% la primera columna es la N y la segunda el cd óptimo en cada caso
cdoptimo

%% TOMO UN VECTOR X, UN CD Y SU N ÓPTIMO (OBTENCIÓN DE GRÁFICAS)
%vamos a asumir que la primera dosis se aplica en tiempo 0, y no la vamos a
%añadir como incógnita.
N=20;
x0=[linspace(0.3,30,N-1),20*ones(1,N)];%x=[t=(t1,...,tN),d=(d1,...,dN)];
fun=@(x) optisqCd(x)-optilinCd(x);%función ya integrada a minimizar
A=sparse(N-1,2*N-1); %condiciones lineales de desigualdad
A(1:N-1,1:N-1)=diag(ones(N-1,1))+diag(-ones(N-2,1),1);A(N-1,N:2*N-1)=ones(N,1);A(N-1,N-1)=0;
b=-0.3*ones(N-1,1);b(N-1,1)=D;
Aeq=[];beq=[];%no hay condiciones lineales de igualdad
lb=[0.3,zeros(1,N-2),dmin*ones(1,N)];%valores mínimos de los tiempos y las dosis administradas
ub=[Tf*ones(1,N-2),0.999*Tf,dmax*ones(1,N)];%valores máximos de los tiempos y las dosis administradas (tomo t1=0 por simplicidad, haciendo que sus cotas superior
% e inferior sean nulas)
options=optimset('TolCon',eps,'TolX', eps,'TolFun',eps,'MaxIter',1e12,'MaxFunEvals',1e12);
[x,fval,exitflag,output]=fmincon(fun,x0,A,b,Aeq,beq,lb,ub,[],options);%el mínimo valor de la función se obtiene para x
x2=round(x,2)
fval2=fun(x2)
concentracionCd(x2,'-r') %para plotear el resultado
hold on

%% CÁLCULO DEL CD ÓPTIMO
ti=[0,x2(1:N-1)];%vector de tiempos en los que se administra la dosis
di=x2(N:2*N-1);%cantidad de fármaco administrado en cada caso
cdopt=0;
for i=1:1:N
    suma=(di(i)*(1-exp(lambda*(ti(i)-Tf))));
    cdopt=cdopt+suma;
end
cdopt=cdopt/(Tf*lambda)
