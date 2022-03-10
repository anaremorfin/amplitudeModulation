clear all
%Variables de tiempo
Fs1=44100;
ts=1/Fs1;
t=ts/10:ts/10:661501*ts/10;

%mensaje senoidal
mensaje=sin(10000.*2.*pi.*t);

%modulacion
trasmisor=cos(1610000.*2.*pi.*t);
aire=(mensaje).*trasmisor;

%demodulacion
receptor=cos(1610000.*2.*pi.*t);
demodulada=aire.*receptor;

%Filtro pasabajas
n=[1];
d=[0.000001 1];
[final, x]=lsim(n,d,demodulada,t);

%Mostrar graficas
%tiempo
figure(1), plot(t,final,'b')
grid on
%frecuencia
fre1=fft(final);
f=linspace(0,Fs1,length(fre1));
fre1=abs(fre1(1:fix(end/2)));
f=f(1:fix(end/2));
fre1=2*fre1/661501;
figure(2),plot (f, fre1, 'g')
grid on