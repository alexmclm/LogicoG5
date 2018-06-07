queMira(juan,got).
queMira(juan,himym).
queMira(juan,futurama).
queMira(nico,starWars).
queMira(maiu,starWars).
queMira(maiu,onePiece).
queMira(maiu,got).
queMira(nico,got).
queMira(gaston,hoc).

populares(got).
populares(hoc).
populares(starWars).

quiereVer(juan,hoc).
quiereVer(aye,got).
quiereVer(gaston,himym).

capitulosPorTemporada(got,3,12).
capitulosPorTemporada(got,2,10).
capitulosPorTemporada(himym,1,23).
capitulosPorTemporada(drHouse,8,16).

/*no se implemento los episodios de mad men por que en este paradigma tomamos las cosas ciertas que pertenece a nuestro universo
idem para alf */

/* PUNTO 2*/
/*COSAS IMPORTANTES QUE PASO EN LAS SERIES*/
paso(futurama,2,3,muerte(seymourDiera)).
paso(starWars,10,9,muerte(emperor)).
paso(starWars,1,2,relacion(parentesco, anakin, rey)).
paso(starWars,3,2,relacion(parentesco, vader, luke)).
paso(himym,1,1,relacion(amorosa, ted, robin)).
paso(himym,4,3,relacion(amorosa, swarley, robin)).
paso(got,4,5,relacion(amistad, tyrion, dragon)).

/*SPOILEO A OTRA PERSONA! */
leDijo(gaston, maiu, got, relacion(amistad, tyrion, dragon)).
leDijo(nico, maiu, starWars, relacion(parentesco, vader, luke)).
leDijo(nico, juan, got, muerte(tyrion)).
leDijo(aye, juan, got, relacion(amistad, tyrion, john)).
leDijo(aye, maiu, got, relacion(amistad, tyrion, john)).
leDijo(aye, gaston, got, relacion(amistad, tyrion, dragon)).

/*PUNTO 3*/
leSpoileo(Persona1,Persona2,Serie):- 
