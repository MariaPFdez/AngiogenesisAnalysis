%CÁLCULO DE LA INTEGRAL DE C(T) MEDIANTE SUMAS (PROCEDIMIENTO ANALÍTICO)
function con=optilinCd(x)
global Tf lambda N
ti=[0,x(1:N-1)];%vector de tiempos en los que se administra la dosis
di=x(N:2*N-1);%cantidad de fármaco administrado en cada caso
con=0;%se comienza sin concentración
%EXPRESIÓN OBTENIDA CON EL CÁLCULO DE LAS INTEGRALES
for i=1:1:N
    suma=(di(i)*(1-exp(lambda*(ti(i)-Tf))));
    con=con+suma;
end
con=con^2/(lambda^2*Tf);
end