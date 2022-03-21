%FICHERO QUE INTRODUCE LA FUNCIÓN CONCENTRACIÓN
function con=ec1cGen(t,x)
global N
global lambda
ti=x(1:N);%vector de tiempos en los que se administra la dosis
di=x(N+1:2*N);%cantidad de fármaco administrado en cada caso
con=0;%al principio no hay ningún fármaco
for i=2:1:N
    if t<=ti(i) && t>ti(i-1)
        con=[di(1:i-1)].*exp(-lambda.*(t.*ones(1,i-1)-[ti(1:i-1)]));%calculo a la vez todos los elementos del sumatorio en forma de vector
        con=sum(con);%sumo las componentes del vector
        return
    else
        i=i+1;
    end
end
%lo que ocurre una vez deja de administrarse el fármaco
if t>ti(N)
    con=[di(1:N)].*exp(-lambda.*(t.*ones(1,N)-[ti(1:N)]));%calculo a la vez todos los elementos del sumatorio en forma de vector
    con=sum(con);%sumo las componentes del vector
end
end