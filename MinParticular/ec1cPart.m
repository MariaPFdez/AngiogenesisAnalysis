%FICHERO QUE INTRODUCE LA FUNCIÓN CONCENTRACIÓN PARA OBTENER EL VALOR EN
%CADA TIEMPO
function con=ec1cPart(t,x)
global lambda
global N
ti=[0 x(2):x(1):(N-2)*x(1)+x(2)];%tiempos en los que se aplica el fármaco, equiespaciados
di=[x(3) x(4)*ones(1,N-1)];%cantidad de dosis que se aplica cada vez
con=0;%al principio no hay ningún fármaco
for i=2:1:N
    if t<=ti(i) && t>ti(i-1)
        con=[di(1:i-1)].*exp(-lambda*(t.*ones(1,i-1)-[ti(1:i-1)]));%calculo a la vez todos los elementos del sumatorio en forma de vector
        con=sum(con);%sumo las componentes del vector
        return
    else
        i=i+1;
    end
end
%lo que ocurre una vez deja de administrarse el fármaco
if t>ti(N)
    con=[di(1:N)].*exp(-lambda*(t.*ones(1,N)-[ti(1:N)]));%calculo a la vez todos los elementos del sumatorio en forma de vector
    con=sum(con);%sumo las componentes del vector
end
end