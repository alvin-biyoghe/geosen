A=[-2 1 0 ; 1 -2 1 ; 0 1 -2]
u=0.1 //viscosité
k= 0.08 //conductivité thermique
U= 3.0 //vitesse maximum du fluide
B=[-U^2*u/(4*k);0;-U^2*u/(4*k)-5]
t=inv(A)*B
T=[0;t;5]
plot2d (T)
xtitle( 'variation de la température d un fluide visqueux lors d un écoulement entre deux plaques', 'hauteur H', 'Température du fluide en degrés celcius')
