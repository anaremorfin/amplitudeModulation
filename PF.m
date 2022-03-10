clear all

%mensaje senoidal
%mensaje=3*cos(10000.*2.*pi.*t);
%sound(mensaje)

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

[f,g]=size(mensaje1);

ts=1/Fs1;
t=ts/10:ts/10:f*ts/10;

mensaje1(:,1)=[];
mensaje2(:,1)=[];

%sound(mensaje2, Fs1)
%figure(1), plot(t,mensaje2,'b')
%pause

trasmisor1=cos(1610000.*2.*pi.*t);
trasmisor2=cos(1790000.*2.*pi.*t);

aire1=(mensaje1').*trasmisor1;
aire2=(mensaje2').*trasmisor2;

aire=aire1+aire2;
%escoger una opcion
%opcion=1610000;

opcion=1610000;

receptor=cos(opcion.*2.*pi.*t);
demodulada=aire.*receptor;

%Filtro
n=[1];
d=[0.00000001 1];
[final, x]=lsim(n,d,demodulada,t);
figure(2), plot(t,final,'r')
grid on
sound(final, Fs1)

%exportar archivo
filename = 'signalOut.ogg';
audiowrite(filename,final,Fs1);

%frecuencia
fre1=fft(final);
f=linspace(0,Fs1,length(fre1));
fre1=abs(fre1(1:fix(end/2)));
f=f(1:fix(end/2));
fre1=2*fre1/661501;
figure(3),plot (f, fre1)
grid on
clear f
