%CÁLCULO DE LA INTEGRAL DE C(T)^2 MEDIANTE SUMAS (PROCEDIMIENTO ANALÍTICO)
function con=optisqGen(x)
global Tf lambda N

ti=[0,x(1:N-1)];%vector de tiempos en los que se administra la dosis
di=x(N:2*N-1);%cantidad de fármaco administrado en cada caso
con1=0;%se comienza sin concentración en todos los sumatorios
con2=0;
con=0;
%EXPRESIONES OBTENIDAS CON EL CÁLCULO DE LAS INTEGRALES
for i=1:1:N
    sum1=di(i)^2*(1-exp(2*lambda*(ti(i)-Tf)));
    con1=sum1+con1;
    for k=i+1:1:N
        sum2=2*di(i)*di(k)*(exp(lambda*(ti(i)-ti(k)))-exp(lambda*(ti(i)+ti(k)-2*Tf)));
        con2=con2+sum2;
end
con=(con1+con2)/(2*lambda);
end