clear;
clf();
// Ce programme cree un signal sinusoidal 1D qui contient 
// deux periodes T1 et T2, d'amplitudes respectives A1 et A2 :
//
// sig(t) = A1 sin(2*pi*t/T1) + A2 sin(2*pi*t/T2).
//
//  Creation du signal
sismo= read('RealSismoAlu.dat',-1,2)
t = sismo(:,1);	// temps discretise.
N = max(size(t));       // Nombre de points du signal;
dt = (t(N)-t(1))/(N-1);		// pas d'echantillonage.
sig = sismo(:,2); //2eme colonne

scf(0);    
style=[1];
plot2d(t,sig,style);xtitle('SIGNAL ORIGINAL DISCRET','TEMPS','SIGNAL');
style=[1];
plot2d(t,sig,style);   

// Transformation de Fourier
Tsig= fft(sig,-1)// Tsig : T.F. de sig
mTsig=abs(Tsig)// mTsig: spectre d'amplitude de Tsig
// frequence : tableau des frequences discretes de sig
for n=1:N/2+1
    frequence(n)=(n-1)/(N*dt)
end
for n=N/2+1:N
    frequence(n)=((n-1)-N)/(N*dt)
end

//...


scf(1); 
xsetech([0. 0. 1. 0.5]);
plot2d(frequence,mTsig); xtitle('SPECTRES','FREQUENCES','spectre d''amplitude');
xsetech([0. 0.5 1. 0.5]);
plot2d(mTsig); xtitle(' ','INDICES','spectre d''amplitude');

// Filtrage de la frequence correspondant a la periode T2.
// CONSTRUIRE : 
for i=1:N
    if frequence(i)<(-3.e6)| frequence(i) > 3.e6 then,
        filtre(i)=0;
    else,
        filtre(i)=1;
        end
end
TsigF= Tsig.*filtre// TsigF : T.F. du signal filtre
sigF=fft(TsigF,1)
sigF=real(sigF)// sigF  : signal filtre.
//...


scf(0);
plot2d(t,sigF,[2]);xtitle('SIGNAL FILTRE','temps','signal');   

