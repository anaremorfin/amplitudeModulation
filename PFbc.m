clear all

%Leer archivos de audio
filename1='audio_toto.mpeg';
filename2='audio_rey.mpeg';
[y,Fs1] = audioread(filename1);
samp=[1,15*Fs1];
clear y Fs1
[y,Fs2] = audioread(filename2);
samp=[15*Fs2,30*Fs2];
clear y Fs2
[mensaje1,Fs1] = audioread(filename1, samp);
[mensaje2,Fs2] = audioread(filename2, samp);

%Variables del tiempo
[f,g]=size(mensaje1);
ts=1/Fs1;
t=ts/10:ts/10:f*ts/10;

%Quitar columna
mensaje1(:,1)=[];
mensaje2(:,1)=[];

%Modulación
trasmisor1=cos(1610000.*2.*pi.*t);
trasmisor2=cos(1790000.*2.*pi.*t);

aire1=(mensaje1').*trasmisor1;
aire2=(mensaje2').*trasmisor2;

%Multiplex
aire=aire1+aire2;

%Escoger frecuencia
opcion=1610000;

%Demodulación
receptor=cos(opcion.*2.*pi.*t);
demodulada=aire.*receptor;

%Filtro
n=[1];
d=[0.00001 1];
[final, x]=lsim(n,d,demodulada,t);
sound(final, Fs1)

%Exportar archivo
filename = 'signalOut.ogg';
audiowrite(filename,final,Fs1);

%Mostrar graficas
%tiempo
figure(1), plot(t,aire,'b')
grid on
%frecuencia
fre1=fft(aire);
f=linspace(0,Fs1,length(fre1));
fre1=abs(fre1(1:fix(end/2)));
f=f(1:fix(end/2));
fre1=2*fre1/661501;
figure(2),plot (f, fre1, 'g')
grid on
