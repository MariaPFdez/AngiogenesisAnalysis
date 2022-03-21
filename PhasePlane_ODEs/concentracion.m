%FICHERO PARA PROBAR EL GRÁFICO DE LA CONCENTRACIÓN
global tf
n=100000;%numero de puntos
con=zeros(1,n);%creamos la variable de la concentración
i=1;%contador
for t=linspace(0,tf-2,n)
    con(i)=ec1c(t);%llamamos a la función en cada uno de los tiempos
    i=i+1;
end
t=linspace(0,tf-2,n);%creamos la variable del tiempo
plot(t,con,'-r')%ploteamos ambas cosas
%cuanta menor sea la diferencia entre los puntos de t, más precisa se verá
%la función en el escalón (entre 1 y 1.01 puede haber hasta dos puntos de
%diferencia en la concentración según los datos usados)
