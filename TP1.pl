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
esSpoiler(Serie,Spoiler):- paso(Serie,_,_,Spoiler).
/*se puede hacer preguntas existenciales e individuales */

/*PUNTO 4*/
leSpoileo(Persona,PersonaSpoileada,Serie):- leDijo(Persona,PersonaSpoileada,Serie,Spoiler),
                                            esSpoiler(Serie,Spoiler),
                                            serieQueVeOPlaneaVer(PersonaSpoileada,Serie).
serieQueVeOPlaneaVer(PersonaSpoileada,Serie):-queMira(PersonaSpoileada,Serie).
serieQueVeOPlaneaVer(PersonaSpoileada,Serie):-quiereVer(PersonaSpoileada,Serie).

/* PUNTO 5 */
/*televidenteResponsable(Persona):- serieQueVeOPlaneaVer(Persona,_),
                                  not(leSpoileo(Persona,_,_)).
                                  */
televidenteResponsable(Persona):- serieQueVeOPlaneaVer(Persona,_),
                              %    leSpoileo(Persona,_,_),
                                  not(leSpoileo(Persona,_,_)).

  %forall(serieQueVeOPlaneaVer(Persona,_),not(leSpoileo(Persona,_,_))).
  televidentes(Persona):-queMira(Persona,_).
  televidentes(Persona):-quiereVer(Persona,_).
/*
serieQueVeOPlaneaVer(Persona,Serie),
not(leSpoileo(Persona,_,Serie)).
*/
/* arreglar este punto, esta molestando! */

/* PUNTO 6 */
vieneZafando(Persona,Serie):- serieQueVeOPlaneaVer(Persona,Serie),
                              populares(Serie),
                              paso(Serie,_,_,_),
                              not(leSpoileo(Persona,_,Serie)).

/*no probe este punto*/

/*********************************************** TEST ****************************************************** */
:- begin_tests(punto1).
test(juanMira_himymFuturamaGot, nondet) :-
  queMira(juan,got),
  queMira(juan,himym),
  queMira(juan,futurama).
test(nicoMira_starWars, nondet) :-
  queMira(nico,starWars).
test(maiuMira_starWars_onePiece_got, nondet) :-
  queMira(maiu,starWars),
  queMira(maiu,onePiece),
  queMira(maiu,got).
test(nicoMira_got, nondet) :-
  queMira(nico,got).
test(gastonMira_houseOfCards, nondet) :-
  queMira(gaston,hoc).
:- end_tests(punto1).
:- begin_tests(punto1b).
test(juan_planea_ver_hoc, nondet):-
  quiereVer(juan,hoc).
test(aye_planea_ver_got, nondet):-
  quiereVer(aye,got).
test(gaston_planea_ver_himym,nondet):-
  quiereVer(gaston,himym).
:- end_tests(punto1b).
/* *** PUNTO2 *****/
:- begin_tests(punto2).
test(muerte_seymourDiera,nondet):-
  paso(futurama,2,3,muerte(seymourDiera)).
test(muerte_emperor,nondet):-
  paso(futurama,2,3,muerte(seymourDiera)).
test(relacion_parentesco_anakin_y_Rey,nondet):-
  paso(starWars,1,2,relacion(parentesco, anakin, rey)).
test(relacion_parentesco_vader_luke,nondet):-
  paso(starWars,3,2,relacion(parentesco, vader, luke)).
test(relacion_amorosa_ted_robin,nondet):-
  paso(himym,1,1,relacion(amorosa, ted, robin)).
test(relacion_amorosa_swarley_robin,nondet):-
  paso(himym,4,3,relacion(amorosa, swarley, robin)).
test(relacion_amistad_tyrion_dragon,nondet):-
  paso(got,4,5,relacion(amistad, tyrion, dragon)).
:- end_tests(punto2).

:- begin_tests(punto2b).
test(leDijo_relacion_amistad_tyrion_dragon,nondet):-
  leDijo(gaston, maiu, got, relacion(amistad, tyrion, dragon)).
test(leDijo_relacion_parentesco_vader_luke,nondet):-
  leDijo(nico, maiu, starWars, relacion(parentesco, vader, luke)).
test(leDijo_muerte_tyrion,nondet):-
  leDijo(nico, juan, got, muerte(tyrion)).
test(leDijo_relacion_amistad_tyrion_john,nondet):-
  leDijo(aye, juan, got, relacion(amistad, tyrion, john)).
test(leDijo_relacion_amistad_tyrion_john,nondet):-
  leDijo(aye, maiu, got, relacion(amistad, tyrion, john)).
test(leDijo_relacion_amistad_tyrion_dragon,nondet):-
  leDijo(aye, gaston, got, relacion(amistad, tyrion, dragon)).

/* **** PUNTO 3 ***/
:- begin_tests(punto3).
test(esVerdadQueEmperorDeStarWarsEsSpoiler, nondet) :-
  esSpoiler(starWars,muerte(emperor)).
test(la_muerte_de_pedro_no_esSpoiler_en_Starwars, fail) :-
  esSpoiler(starWars,muerte(pedro)).
test(la_muerte_de_pedro_no_esSpoiler_en_Starwars, fail) :-
  esSpoiler(starWars,muerte(pedro)).
test(la_relacion_de_parentesco_entre_anakin_y_ElRey_esSpoiler_Starwars, nondet) :-
  esSpoiler(starWars,relacion(parentesco,anakin,rey)).
test(no_es_cierto_que_la_relacion_de_lavezzi_y_anakin_sea_Spoiler_Starwars, fail):-
  esSpoiler(starWars,relacion(padre,anakin,lavezzi)).
:- end_tests(punto3).

/**** PUNTO4 *** */
:- begin_tests(punto4).
test(gaston_le_dijo_a_maiu_spoiler_got,nondet) :-
  leSpoileo(gaston,maiu,got).
test(nico_le_dijo_a_maiu_spoiler_StarWars,nondet) :-
  leSpoileo(nico,maiu,starWars).
:- end_tests(punto4).

/***** PUNTO 5 **** */
:- begin_tests(punto5).
test(juan_es_televidente_responsable,nondet):-
  televidenteResponsable(juan).
test(aye_es_televidente_responsable,nondet):- /* problema con el test en aye!*/
  televidenteResponsable(aye).
test(maiu_es_televidente_responsable,nondet):-
  televidenteResponsable(maiu).
test(nico_no_es_televidente_responsable,fail):-
  televidenteResponsable(nico).
test(gaston_no_es_televidente_responsable,fail):-
  televidenteResponsable(gaston).
:- end_tests(punto5).

/* **** PUNTO 6 *****/
