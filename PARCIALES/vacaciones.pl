%1
viaja(dodain,pehuenia).
viaja(dodain,sanMartin).
viaja(dodain,esQuel).
viaja(dodain,sarmiento).
viaja(dodain,camarones).
viaja(dodain,playasDoradas).

viaja(alf,bariloche).
viaja(alf,sanMartin).
viaja(alf,elBolson).

viaja(nico,marDelPlata).

viaja(vale,calafate).
viaja(vale,elBolson).

viaja(martu,Lugar):-
    viaja(nico,Lugar).
viaja(martu,Lugar):-
    viaja(alf,Lugar).


%2
atraccion(esQuel,parqueNacional("losAlerces")).
atraccion(esQuel,excursion("trochita")).
atraccion(esQuel,excursion("trevelin")).

atraccion(pehuenia,cerro("bateaMahuida",2000)).
atraccion(pehuenia,cuerpoAgua("moquehue",si_pescar,14)).
atraccion(pehuenia,cuerpoAgua("alumine",si_pescar,19)).

atraccion(marDelPlata,playa(2)).

atraccionCopada(cerro(_,Altura)):-
    Altura > 2000.
atraccionCopada(cuerpoAgua(_,si_pescar,_)).
atraccionCopada(cuerpoAgua(_,_,Temperatura)):-
    Temperatura > 20.
atraccionCopada(playa(DiferenciaMarea)):-
    DiferenciaMarea < 5.
atraccionCopada(excursion(Nombre)):-
    string_length(Nombre, CantidadLetras),
    CantidadLetras > 7.
atraccionCopada(parqueNacional(_)).

persona(Persona):-
    distinct(Persona,viaja(Persona,_)).

%vacacionesCopadas(Persona):- 
%    persona(Persona),
%    forall(viaja(Persona, Lugar), (atraccion(Lugar, Atraccion), atraccionCopada(Atraccion))).
    
vacacionesCopadas(Persona) :-
    persona(Persona),
    findall(Lugar, viaja(Persona, Lugar), Lugares),
    forall(member(Lugar, Lugares), (atraccion(Lugar, Atraccion), atraccionCopada(Atraccion))).


%3
noSeCruzaron(Persona1,Persona2):-
    persona(Persona1),
    persona(Persona2),
    findall(Lugar, viaja(Persona1, Lugar), Lugares1),
    findall(Lugar, viaja(Persona2, Lugar), Lugares2),
    not((member(Lugar, Lugares1), member(Lugar, Lugares2))).

%4
costoDeVida(sarmiento,100).
costoDeVida(esQuel,150).
costoDeVida(pehuenia,180).
costoDeVida(sanMartin,150).
costoDeVida(camarones,135).
costoDeVida(playasDoradas,170).
costoDeVida(bariloche,140).
costoDeVida(calafate,240).
costoDeVida(elBolson,145).
costoDeVida(marDelPlata,140).

destinoGasolero(Lugar):-
    costoDeVida(Lugar,Costo),
    Costo < 160.

vacacionesGasoleras(Persona):-
    persona(Persona),
    findall(Lugar, viaja(Persona, Lugar), Lugares),
    forall(member(Lugar, Lugares), (destinoGasolero(Lugar))).

%5
itinerario(Persona,Itinerario):-persona(Persona),
    findall(Lugar, viaja(Persona, Lugar), Lugares),
    permutar(Lugares,Itinerario).

permutar([], []).
permutar(Lugares,[Lugar|Itinerario]):-member(Lugar,Lugares),
    sacar(Lugar,Lugares,RestoLugares),
    permutar(RestoLugares,Itinerario).

sacar(_, [], []).
sacar(Lugar,[Lugar|Lugares],Lugares).
sacar(Lugar,[OtroLugar|Lugares],[OtroLugar|Resto]):-
    Lugar \= OtroLugar,
    sacar(Lugar,Lugares,Resto).

