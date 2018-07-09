/*********************************************** Base ****************************************************** */
queMira(juan,got).
queMira(juan,himym).
queMira(juan,futurama).
queMira(nico,starWars).
queMira(maiu,starWars).
queMira(maiu,onePiece).
queMira(maiu,got).
queMira(nico,got).
queMira(gaston,hoc).
queMira(pedro, got).

populares(got).
populares(hoc).
populares(starWars).

quiereVer(juan,hoc).
quiereVer(aye,got).
quiereVer(gaston,himym).

%serie,Temporada,Capitulo
capitulosPorTemporada(got,3,12).
capitulosPorTemporada(got,2,10).
capitulosPorTemporada(himym,1,23).
capitulosPorTemporada(drHouse,8,16).

/*no se implemento los episodios de mad men por el principio de universo cerrado,
que dice que solo se declaran las cosas verdaderas, lo mismo es para Alf */

/* PUNTO 2*/
/*COSAS IMPORTANTES QUE PASO EN LAS SERIES*/
% serie,Temporada,Capitulo,LoquePaso
paso(futurama,2,3,muerte(seymourDiera)).
paso(starWars,10,9,muerte(emperor)).
paso(starWars,1,2,relacion(parentesco,anakin,rey)).
paso(starWars,3,2,relacion(parentesco,vader,luke)).
paso(himym,1,1,relacion(amorosa,ted,robin)).
paso(himym,4,3,relacion(amorosa,swarley,robin)).
paso(got,4,5,relacion(amistad,tyrion,dragon)).

/*SPOILEO A OTRA PERSONA! */
leDijo(gaston, maiu, got, relacion(amistad, tyrion, dragon)).
leDijo(nico, maiu, starWars, relacion(parentesco, vader, luke)).
leDijo(nico, juan, got, muerte(tyrion)).
leDijo(aye, juan, got, relacion(amistad, tyrion, john)).
leDijo(aye, maiu, got, relacion(amistad, tyrion, john)).
leDijo(aye, gaston, got, relacion(amistad, tyrion, dragon)).
leDijo(nico, juan, futurama, muerte(seymourDiera)).
leDijo(pedro, aye, got, relacion(amistad, tyrion, dragon)).
/*no agregue lo ultimo porque dice que no es cierto*/

/*serie, temporada, capitulo, palabrasClave*/
plotTwist(got, 3, 2, palabrasClave(suenio, sinPiernas)).
plotTwist(got, 3, 12, palabrasClave(fuego, boda)).
plotTwist(superCampeones, 9, 9, palabrasClave(suenio, coma, sinPiernas)).
plotTwist(drHouse, 8, 7, palabrasClave(coma, pastillas)).

/*Relacion de amistad*/
% esAmigo,PeroEsteNoEsSuAmigo
amigo(nico, maiu).
amigo(maiu, gaston).
amigo(maiu, juan).
amigo(juan, aye).

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
televidenteResponsable(Persona):-serieQueVeOPlaneaVer(Persona,_),
                                 not(leSpoileo(Persona,_,_)).
  %forall(serieQueVeOPlaneaVer(Persona,_),not(leSpoileo(Persona,_,_))).
/*
serieQueVeOPlaneaVer(Persona,Serie),
not(leSpoileo(Persona,_,Serie)).
*/

/* PUNTO 6 */
vieneZafando(PersonaASpoilear,Serie):- serieQueVeOPlaneaVer(PersonaASpoilear,Serie),
                              esPopularOPasaCosasFuertes(Serie),
                              not(leSpoileo(_,PersonaASpoilear,Serie)).
esPopularOPasaCosasFuertes(Serie):- populares(Serie).
esPopularOPasaCosasFuertes(Serie):- pasoCosasFuertesEnSusTemporadas(Serie).

pasoCosasFuertesEnSusTemporadas(Serie):-
    capitulosPorTemporada(Serie,Temporada,_),
    forall(capitulosPorTemporada(Serie,Temporada,_), sucesoFuerteTemporada(Serie,Temporada)).
%me habia olvidado la inversibilidad!

sucesoFuerteTemporada(Serie,Temporada):- paso(Serie,Temporada,_,muerte(_)).
sucesoFuerteTemporada(Serie,Temporada):- paso(Serie,Temporada,_,relacion(parentesco,_,_)).
sucesoFuerteTemporada(Serie,Temporada):- paso(Serie,Temporada,_,relacion(amorosa,_,_)).

/* *************************************** PARTE 2 ******************************************************* */
/* PUNTO 1*/
malaGente(Persona):-
  persona(Persona),
  forall(leDijo(Persona,_,_,_),leSpoileo(Persona,_,_)).

persona(Persona):- serieQueVeOPlaneaVer(Persona,_).
/*
malaGente(Persona):-
  %persona(Persona),
  leSpoileo(Persona,_,Serie),
  not(queMira(Persona,Serie)).
*/
/* PUNTO 2
fuerte(PlotTwist):- paso(_,_,_,muerte()).
fuerte(PlotTwist):- paso(_,_,_,relacion(amorosa,_,_)).
fuerte(PlotTwist):- paso(_,_,_,relacion(parentesco,_,_)).

fuerte(PlotTwist):-
  paso()
  esCliche(PlotTwist),
*/
/* PUNTO 3*/
% creo que debe ser de 2 predicados, ya que sino a la hora de consultar no podria decirle que starWars
esPopular(Serie):-
  popularidad(Serie,CantidadPopularidad),
  popularidad(starWars,CantidadPopularidadStarWars),
  CantidadPopularidad >= CantidadPopularidadStarWars.

popularidad(Serie,CantidadPopularidad):-
  cantidadQueMiranSerie(Serie,CantidadEspectadores),
  cantidadQueHablanDeLaSerie(Serie,CantidadSpoileros),
  CantidadPopularidad is CantidadEspectadores * CantidadSpoileros.

cantidadQueMiranSerie(Serie,CantidadEspectadores):-
  findall(Persona,queMira(Persona,Serie),Personas),
  length(Personas,CantidadEspectadores).

cantidadQueHablanDeLaSerie(Serie,CantidadPosiblesSpoileros):-
  findall(Persona,leDijo(Persona,_,Serie,_),Personas),
  length(Personas,CantidadPosiblesSpoileros).

esPopular(hoc).
%ya que lo aclara, independientemente del calculo, es popu!
/* PUNTO 4 */
fullSpoil(PersonaSpoilera,PersonaSpoileada):-
  leSpoileo(PersonaSpoilera,PersonaSpoileada,_),
  noSonLosMismos(PersonaSpoilera,PersonaSpoileada).

fullSpoil(PersonaSpoilera,PersonaSpoileada):-
  %leSpoileo(AmigoDelSegundo,PersonaSpoileada),
  amigo(ElAmigoDelSegundo,PersonaSpoilera),
  fullSpoil(ElAmigoDelSegundo,PersonaSpoilera).

noSonLosMismos(PersonaSpoilera,PersonaSpoileada):- PersonaSpoilera \= PersonaSpoileada.
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
  leDijo(aye, maiu, got, relacion(amistad,tyrion,john)).
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
test(aye_no_es_televidente_responsable,nondet):- /* problema con el test en aye!*/
  televidenteResponsable(aye).
test(maiu_es_televidente_responsable,nondet):-
  televidenteResponsable(maiu).
test(nico_no_es_televidente_responsable,fail):-
  televidenteResponsable(nico).
test(gaston_no_es_televidente_responsable,fail):-
  televidenteResponsable(gaston).
:- end_tests(punto5).

/* **** PUNTO 6 *****/

:- begin_tests(punto6).
test(maiu_no_viene_zafando,fail):-
  vieneZafando(maiu,_).
test(juan_viene_zafando_himym,nondet):-
 vieneZafando(juan,himym).
test(juan_viene_zafando_got,nondet):-
   vieneZafando(juan,got).
test(juan_viene_zafando_hoc,nondet):-
  vieneZafando(juan,hoc).
test(nico_zafa_con_StarWars,nondet):-
  vieneZafando(Persona,starWars),
  Persona == nico.
:- end_tests(punto6).

/* ******************************************** TEST PARTE 2 *******************************************/
/* PUNTO 1*/
:- begin_tests(parte2_punto1).
test(gaston_es_malaGente,nondet):-
  malaGente(gaston).
test(nico_es_MalaGente,nondet):-
  malaGente(nico).
test(pedro_noEsMalaGente,fail):-
  not(malaGente(pedro)).
:- end_tests(parte2_punto1).

/* PUNTO 2
:- begin_tests(parte2_punto2).
test(la_muerte_SeymourDiera_esFuerte,nondet):-
  fuerte(muerte(seymourDiera)).
test(muerte_emperor_esFuerte,nondet):-
  fuerte(muerte(emperor)).
test(relacion_parentesco_anakin_y_Rey_esFueret,nondet):-
  fuerte(relacion(parentesco,vader,luke)).
test(relacion_amorosa_ted_robin_esFuerte,nondet):-
  fuerte(relacion(amorosa, ted, robin)).
test(relacion_amorosa_swarley_robin_esFuerte,nondet):-
  fuerte(relacion(amorosa, swarley, robin)).
test(plotTwist_conPalabras_fuego_y_Boda_enGoT_esFuerte,nondet):-
*/
/* PUNTO 3 */
:- begin_tests(parte2_punto3).
test(starWars_esPopular,nondet):-
  esPopular(starWars).
test(got_esPopular,nondet):-
  esPopular(got).
test(hoc_esPopular,nondet):-
  esPopular(hoc).
:- end_tests(parte2_punto3).

/* PUNTO 4*/
:- begin_tests(parte2_punto4).
test(nico_hizo_fullSpoil_a_Aye,nondet):-
  fullSpoil(nico,aye).
test(nico_hizo_fullSpoil_a_Juan,nondet):-
  fullSpoil(nico,juan).
test(nico_hizo_fullSpoil_a_Maiu,nondet):-
  fullSpoil(nico,maiu).
test(nico_hizo_fullSpoil_a_Gaston,nondet):-
  fullSpoil(nico,gaston).
test(gaston_hizo_fullspoil_a_maiu,nondet):-
  fullSpoil(gaston,maiu).
test(gaston_hizo_fullspoil_a_juan,nondet):-
  fullSpoil(gaston,juan).
test(gaston_hizo_fullspoil_a_Aye,nondet):-
  fullSpoil(gaston,aye).
test(maiu_no_hizo_fullspoil_a_Nadie,fail):-
  fullSpoil(miau,_).
:- end_tests(parte2_punto4).
