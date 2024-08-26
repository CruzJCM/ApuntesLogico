%CIVILIZACIONES Y TECNOLOGIAS:------------------------------------------------

%Modelado de jugadores:
jugador(Jugador):- 
	eligioCivilizacion(Jugador, _).

%Modelado de civilizaciones:
civilizacion(Civilizacion):-
	eligioCivilizacion(_, Civilizacion).

eligioCivilizacion(ana, romanos).
eligioCivilizacion(beto, incas).
eligioCivilizacion(carola, romanos).
eligioCivilizacion(dimitri, romanos).
%No es necesario modelar a Elsa "no juega esta partida" porque es un hecho q se da por entendido q es falso, por no estar en la base de conocimientos
%Es por el Principio de Universo Cerrado.

%Modelado de tecnologias:
tecnologia(herreria).
tecnologia(forja).
tecnologia(emplumado).
tecnologia(laminas).
tecnologia(fundicion).
tecnologia(horno).
tecnologia(punzon).
tecnologia(malla).
tecnologia(placas).
tecnologia(molino).
tecnologia(collera).
tecnologia(arado).

%Tecnologias de Ana
desarrolloTecnologia(ana, herreria).
desarrolloTecnologia(ana, forja).
desarrolloTecnologia(ana, emplumado).
desarrolloTecnologia(ana, laminas).
%Tecnologias de Beto
desarrolloTecnologia(beto, herreria).
desarrolloTecnologia(beto, forja).
desarrolloTecnologia(beto, fundicion).
%Tecnologias de Carola
desarrolloTecnologia(carola, herreria).
%Tecnologias de Dimitri
desarrolloTecnologia(dimitri, herreria).
desarrolloTecnologia(dimitri, fundicion).

%En grupo:
expertoEnMetales(Jugador):-
	desarrolloTecnologia(Jugador, herreria),
	desarrolloTecnologia(Jugador, forja),
	(desarrolloTecnologia(Jugador, fundicion) ;
	eligioCivilizacion(Jugador, romanos)).

expertoEnMetales2(Jugador):-	
	distinct(Jugador, (
		desarrollo(Jugador, herreria),
		desarrollo(Jugador, forja),
		expertoEnMetalesEspecifico(Jugador)
		)
	).	  
expertoEnMetalesEspecifico(Jugador):-
	desarrollo(Jugador, fundicion).
expertoEnMetalesEspecifico(Jugador):-
	eligioCivilizacion(Jugador, romanos).

%Integrante 1:
civilizacionPopular(Civilizacion):-
	distinct(civilizacion(Civilizacion)),
	eligioCivilizacion(Jugador,Civilizacion),
	eligioCivilizacion(OtroJugador,Civilizacion),
	Jugador \= OtroJugador.

%Integrante 2:
alcanceGlobal(Tecnologia) :-
	distinct(tecnologia(Tecnologia)),
	not((jugador(Jugador), not(desarrolloTecnologia(Jugador, Tecnologia)))).

%Integrante 3:
desarrollo(Civilizacion, Tecnologia) :-
	eligioCivilizacion(Jugador, Civilizacion),
	desarrolloTecnologia(Jugador, Tecnologia).

civilizacionLider(Civilizacion) :-
	distinct(civilizacion(Civilizacion)),
	forall((desarrollo(OtraCivilizacion, Tecnologia), OtraCivilizacion \= Civilizacion), desarrollo(Civilizacion, Tecnologia)).

%UNIDADES:------------------------------------------------

%Modelado de unidades:
%Unidades de Ana
unidad(ana, jinete(caballo)).
unidad(ana, piquero(1, con_escudo)).
unidad(ana, piquero(2, sin_escudo)).
%Unidades de Beto
unidad(beto, campeon(100)).
unidad(beto, campeon(80)).
unidad(beto, piquero(1, con_escudo)).
unidad(beto, jinete(camello)).
%Unidades de Carola
unidad(carola, piquero(3, sin_escudo)).
unidad(carola, piquero(2, con_escudo)).
%Dimitri no tiene unidades

%Integrante 1:
sobreviveAsedio(Jugador):-
	distinct(jugador(Jugador)),
	findall(Jugador,unidad(Jugador,piquero(_,con_escudo)),AuxiliarPiquerosConEscudo),
	findall(Jugador,unidad(Jugador,piquero(_,sin_escudo)),AuxiliarPiquerosSinEscudo),
	length(AuxiliarPiquerosConEscudo, Cantidad1),
	length(AuxiliarPiquerosSinEscudo, Cantidad2),
	Cantidad1 > Cantidad2.

%Integrante 2:
leGana(jinete(_), campeon(_)).
leGana(campeon(_), piquero(_, _)).
leGana(piquero(_, _), jinete(_)).
leGana(jinete(camello), jinete(caballo)).

% leGana(campeon(Vida1), campeon(Vida2)):- Vida1 > Vida2.
% leGana(piquero(Nivel, TieneONoEscudo), piquero(OtroNivel, TieneONoEscudo2)):- 
% 	vidaUnidad(piquero(Nivel, TieneONoEscudo), Vida), 
% 	vidaUnidad(piquero(OtroNivel, TieneONoEscudo2), Vida2),
% 	Vida > Vida2.
% leGana(jinete(Animal), jinete(Animal2)):- 
% 	vidaUnidad(jinete(Animal), Vida), 
% 	vidaUnidad(jinete(Animal2), Vida2),
% 	Vida > Vida2.

leGana(Unidad, OtraUnidad):-
	vidaUnidad(Unidad, VidaUnidad),
	vidaUnidad(OtraUnidad, VidaOtraUnidad),
	VidaUnidad > VidaOtraUnidad.

enfrentamiento(Unidad, Unidad2):-
	leGana(Unidad, Unidad2).


%Integrante 3:
vidaUnidad(campeon(PuntosDeVida), PuntosDeVida).
vidaUnidad(jinete(caballo), 90).
vidaUnidad(jinete(camello), 80).
vidaUnidad(piquero(1, sin_escudo), 50).
vidaUnidad(piquero(2, sin_escudo), 65).
vidaUnidad(piquero(3, sin_escudo), 70).

vidaUnidad(piquero(Nivel, con_escudo), Vida):- vidaUnidad(piquero(Nivel, sin_escudo), Vida), Vida is Vida * 10 / 100.

unidadConMayorVida(Jugador, Maximo) :- 
	jugador(Jugador), 
	findall(Valor, (unidad(Jugador, Unidad), vidaUnidad(Unidad, Valor)), ListaNivelesDeVida), 
	max_member(Maximo, ListaNivelesDeVida).

%Modelado de arbol de habilidades:
tecnologiaPermite(herreria, forja).
tecnologiaPermite(herreria, emplumado).
tecnologiaPermite(herreria, laminas).
tecnologiaPermite(forja, fundicion).
tecnologiaPermite(fundicion, horno).
tecnologiaPermite(emplumado, punzon).
tecnologiaPermite(laminas, malla).
tecnologiaPermite(malla, placas).
tecnologiaPermite(molino, collera).
tecnologiaPermite(collera, arado).
%Dependencias
tieneDependencia(Tecnologia) :- tecnologiaPermite(_, Tecnologia).

%En grupo:
puedeDesarrollar(Jugador, Tecnologia) :-
	jugador(Jugador),
	tecnologia(Tecnologia),
	not(desarrolloTecnologia(Jugador, Tecnologia)),
	not(tieneDependencia(Tecnologia)).
puedeDesarrollar(Jugador, Tecnologia) :- 
	jugador(Jugador),
	tecnologia(Tecnologia),
	not(desarrolloTecnologia(Jugador, Tecnologia)),
	desarrolloTecnologia(Jugador, TecnologiaIntermedia), 
	tecnologiaPermite(TecnologiaIntermedia, Tecnologia).


%BONUS:------------------------------------------------
%Regla para obtener dependencias
dependencia(Dependencia, Tecnologia):-
	tecnologiaPermite(Dependencia, Tecnologia).

%Orden topológico para un conjunto de tecnologías
ordenValido(Tecnologias, Orden):-
    list_to_set(Tecnologias, TecnologiasSet),
    findall(Tec, (dependencia(_, Tec)), Dependencias),
    list_to_set(Dependencias, DependenciasSet),
    ordenamiento(TecnologiasSet, DependenciasSet, OrdenDesordenado),
    reverse(OrdenDesordenado, Orden).

%Encontrar un orden topológico
ordenamiento([], _, []).
ordenamiento(Nodos, Dependencias, [Nodo|OrdenRestante]):-
    select(Nodo, Nodos, NodosRestantes),
    \+ (dependencia(Nodo, OtroNodo), member(OtroNodo, NodosRestantes)),
    ordenamiento(NodosRestantes, Dependencias, OrdenRestante).

%Obtener tecnologías desarrolladas por un jugador
tecnologiasDesarrolladasPorJugador(Jugador, Tecnologias):-
    findall(Tecnologia, desarrolloTecnologia(Jugador, Tecnologia), ListaTecnologias),
    list_to_set(ListaTecnologias, Tecnologias).

%Obtener un orden válido de tecnologías desarrolladas por un jugador
ordenTecnologiasJugador(Jugador, Orden):-
    tecnologiasDesarrolladasPorJugador(Jugador, Tecnologias),
    ordenValido(Tecnologias, Orden).