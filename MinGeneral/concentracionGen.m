%FICHERO PARA PROBAR EL GRÁFICO DE LA CONCENTRACIÓN
function concentracionGen(x,color)
global Tf cd N lambda dmin
n=100000;%numero de puntos
con=zeros(1,n);%creamos la variable de la concentración
i=1;%contador
for t=linspace(0,Tf+0.001,n)%para poder observar el pico de la concentración si se aplica la dosis en Tf
    con(i)=ec1cGen(t,x);%llamamos a la función en cada uno de los tiempos
    i=i+1;
end
t=linspace(0,Tf,n);%creamos la variable del tiempo
plot(t,con,'-','Color',color), hold on 
plot(t,cd*ones(1,n),'-','Color',"#5755FF"),xlabel('Time (days)'),ylabel('Concentration (mg/L)'),title(['Estimated and numerical concentration in the body when \it{c_d} = ' num2str(cd) ' \rm{mg/L}'])
%title([num2str(N) ' doses and a constant ideal concentration of ' num2str(cd)])%ploteamos ambas cosas
%title([num2str(N) ' doses with elimination rate of ' num2str(lambda) 'days^{-1}'])
%cuanta menor sea la diferencia entre los puntos de t, más precisa se verá
%la función en el escalón (entre 1 y 1.01 puede haber hasta dos puntos de
%diferencia en la concentración según los datos usados)
end
