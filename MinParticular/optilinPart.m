%CÁLCULO DE LA INTEGRAL DE C(T) MEDIANTE SUMAS (PROCEDIMIENTO ANALÍTICO)
function con=optilinPart(x)
format long e
global Tf
global lambda
global N
ti=[0 x(2):x(1):(N-2)*x(1)+x(2)];%vector de tiempos en los que se administra la dosis
di=[x(3) x(4)*ones(1,N-1)];%cantidad de fármaco administrado en cada caso
con=0;%se comienza sin concentración
%EXPRESIÓN OBTENIDA A MANO DESARROLLANDO LAS INTEGRALES
for i=1:1:N
    suma=di(i)*(1-exp(lambda*(ti(i)-Tf)))/lambda;
    con=con+suma;
end
end