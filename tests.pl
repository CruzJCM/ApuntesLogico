:-include(solucion).

:- begin_tests(tests_trabajo_practico).

test("civilizacion que es popular.", set(Civilizacion=[romanos])) :- 
    civilizacionPopular(Civilizacion).

test("civilizacion que es popular.", fail) :- 
    civilizacionPopular(incas).

test("tecnologia con alcance global", set(Tecnologia==[herreria])) :- 
    alcanceGlobal(Tecnologia).

test("civilizacion que es lider", set(Civilizacion==[romanos])) :- 
    civilizacionLider(Civilizacion).

test("unidad con mas vida de un jugador", set(Maximo==[90])) :- 
    unidadConMayorVida(ana, Maximo).

test("unidad con mas vida de un jugador", set(Maximo==[100])) :- 
    unidadConMayorVida(beto, Maximo).

test("unidad le gana a otra") :- 
    leGana(campeon(100), campeon(95)).

test("unidad no le gana a otra", fail, set(Unidad2==[jinete(caballo)])) :- 
    leGana(campeon(100), Unidad2).

test("jugador puede sobrevivir a un asedio", set(Jugador==[beto])) :- 
    sobreviveAsedio(Jugador).

test("jugador puede desarrollar tecnologia", set(Jugador=[ana])) :- 
    puedeDesarrollar(Jugador, fundicion).

test("jugador puede desarrollar tecnologia", set(Jugador=[ana,beto,carola,dimitri])) :- 
    puedeDesarrollar(Jugador, molino).

:- end_tests(tests_trabajo_practico). 