%FICHERO PARA VER EL GRÁFICO DE LA CONCENTRACIÓN
function concentracionPart(x)
global Tf
global cd
n=100000;%numero de puntos
con=zeros(1,n);%creamos la variable de la concentración
i=1;%contador
for t=linspace(0,Tf+0.001,n)%para que se vea el pico de la concentración en caso de que una dosis se aplique en Tf
    con(i)=ec1cPart(t,x);%llamamos a la función en cada uno de los tiempos
    i=i+1;
end
t=linspace(0,Tf,n);%creamos la variable del tiempo
plot(t,con,'-r',t,cd*ones(1,n),'-b'),xlabel('Time (days)'),ylabel('Concentration (mg/kg)')%ploteamos ambas cosas
%cuanta menor sea la diferencia entre los puntos de t, más precisa se verá
%la función en el escalón (entre 1 y 1.01 puede haber hasta dos puntos de
%diferencia en la concentración según los datos usados)
end
