// Differences-finies equation d'onde acoustique 1D.
//
//Programme de differences-finies pour l'equation d'ondes 
//acoustiques en une dimension.
//Les C. L. consistent simplement a maintenir a zero la pression
//aux deux extremites de la grille.

N = 100;           // Nombre de noeuds dans la grille.
L= 1; //longueur du tuyau (m)
C =345;		    // Celerite des ondes. (m/s)
Ca =0.7;    // celerité adimensionnelle
Ca2=Ca^2,  // celérité adimenssionelle au carré
dx = L/(N-1); 		    // Pas d'espace (m)
dy= L/(N-1);         //Pas d'espace (m)
dt =Ca/C*dx;		    // Pas de temps (s)
duree =L/2*C ;		    // duree de la simulation (s)
maxit = int(L/(2*C*dt)) + 1;    // nombre de pas de temps

// Conditions initiales :

P = zeros(N,N);
Pp = zeros(N,N);
Pf = zeros(N,N);

// Sources :

ix0 =int(N/2);		// position de la source (indice dans la grille)
iy0=int(N/2);      // position de la source (colonne dans la grille)
x0 = L/2;		// position de la source (en metres).
y0= L/2;      // position de la source (en metres)
amp = 10000;			// amplitude des sources (Pa)
dureeS = duree          // duree de la source vibratoire (s).
ws = 1500 ;		// frequence d'une source vibratoire (Hz).

             //////////////////////
             // Boucle en temps  //
             //////////////////////

for it = (1:maxit);

// Source vibratoire au milieu de la grille:
  temps = (it-1) * dt;
  P(int(N/2),int(N/2)) = amp * sin(ws*temps) / 2.;

// Algorithme de D.F. :

for ix=2:N-1; 
    for iy=2:N-1;
    Pf(ix,iy)=Pp(ix,iy)-2*P(ix,iy)+Ca2*(P(ix+1,iy)+P(ix-1,iy)-2*P(ix,iy)+P(ix,iy+1)+P(ix,iy-1)-2*P(ix,iy))
    end;
end

// Conditions aux limites :

Pf(:,1) = 0;
Pf(1,:)=0;
Pf(N,:)=0;
Pf(:,N)=0;

// mises a jour :
Pp=P
P=Pf
// visualisation
x = dx * [1:N]
y= dy* [1:N] 
    grayplot(x,y,Pf);

end

 


