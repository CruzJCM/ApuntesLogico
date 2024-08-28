%1
atiende(dodain,lunes,9,15).
atiende(dodain,miercoles,9,15).
atiende(dodain,viernes,9,15).

atiende(lucas,martes,10,20).

atiende(juanC,sabados,18,22).
atiende(juanC,domingos,18,22).

atiende(juanFdS,jueves,10,20).
atiende(juanFdS,viernes,12,20).

atiende(leoC,lunes,14,18).
atiende(leoC,miercoles,14,18).

atiende(martu,miercoles,23,24).

atiende(vale,Dia,HorarioInicio,HorarioFinal):-
    atiende(dodain,Dia,HorarioInicio,HorarioFinal).
atiende(vale,Dia,HorarioInicio,HorarioFinal):-
    atiende(juanC,Dia,HorarioInicio,HorarioFinal).

%Por principio de universo cerrado lo que no este agregado a la base de conocimientos es falso.

%Lo mismo, al ser al fin y al cabo algo desconocido, no lo agregamos y resulta falso.

%2
%persona(Persona):-
%    distinct(Persona,atiende(Persona,_,_,_)).

quienAtiende(Dia,Horario,Persona):-
    atiende(Persona,Dia,HorarioInicio,HorarioFinal),
    between(HorarioInicio, HorarioFinal, Horario).


%3
foreverAlone(Persona,Dia,Horario):-
    quienAtiende(Dia,Horario,Persona),
    not((
        quienAtiende(Dia,Horario,OtraPersona),
        Persona \= OtraPersona
    )).


%4
posibilidadesAtencion(Dia,Personas):-
    findall(Persona,distinct(Persona,quienAtiende(Dia,_,Persona)),PersonasPosibles),
    combinar(PersonasPosibles,Personas).

combinar([],[]).
combinar([Persona|PersonasPosibles],[Persona|Personas]):-
    combinar(PersonasPosibles,Personas).
combinar([_|PersonasPosibles],Personas):-
    combinar(PersonasPosibles,Personas).

% Qué conceptos en conjunto resuelven este requerimiento
% - findall como herramienta para poder generar un conjunto de soluciones que satisfacen un predicado
% - mecanismo de backtracking de Prolog permite encontrar todas las soluciones posibles


%5
venta(dodain, dia(lunes), fecha(10, 8), [golosinas(1200), cigarrillos([jockey]),golosinas(50)]).
venta(dodain, dia(miercoles), fecha(12, 8), [bebidas(true, 8),bebidas(false, 1), golosinas(10)]).
venta(martu, dia(miercoles), fecha(12, 8), [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).
venta(lucas, dia(martes), fecha(11, 8), [golosinas(600)]).
venta(lucas, dia(martes), fecha(18, 8), [bebidas(false, 2), cigarrillos([derby])]).

ventaImportante(golosinas(Dinero)):-
    Dinero > 100.

ventaImportante(cigarrillos(Marcas)):-
    length(Marcas, Cantidad),
    Cantidad > 2.

ventaImportante(bebidas(true,_)).
ventaImportante(bebidas(_,Cantidad)):-
    Cantidad > 5.

vendedor(Vendedor):-
    venta(Vendedor, _, _, _).

vendedorSuertudo(Vendedor):-
    distinct(Vendedor,vendedor(Vendedor)),
    forall(venta(Vendedor, _, _,[Venta|_]),ventaImportante(Venta)).