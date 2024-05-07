% Hechos
% Inventario de piezas
pieza_basica(llanta).
pieza_basica(radios).
pieza_basica(eje).
pieza_basica(manillar).
pieza_basica(sillin).
pieza_basica(traccion).
pieza_basica(plato).
pieza_basica(pedales).
pieza_basica(cadena).
pieza_basica(pinones).

% Definicion del ensamblaje de la bicicleta
ensamblaje(bicicleta, [rueda_delantera, cuadro, rueda_trasera]).
ensamblaje(rueda_delantera, [llanta, radios, eje]).
ensamblaje(cuadro, [manillar, sillin, traccion]).
ensamblaje(traccion, [eje, plato, pedales, cadena]).
ensamblaje(rueda_trasera, [llanta, radios, eje, pinones]).

%Reglas
% Procedimiento para obtener las piezas basicas de una parte
piezas_de(Parte, Piezas) :-
    ensamblaje(Parte, Piezas);
    obtener_piezas_basicas(Partes, Piezas).


obtener_piezas_basicas([], []).
obtener_piezas_basicas([Pieza|Resto], [Pieza|RestoPiezas]) :-
    pieza_basica(Pieza),
    obtener_piezas_basicas(Resto, RestoPiezas).
obtener_piezas_basicas([_|Resto], RestoPiezas) :-
    obtener_piezas_basicas(Resto, RestoPiezas).

% Preguntas para construir una determinada parte o toda la bicicleta
% ¿Cuales son las piezas basicas de la rueda delantera?
%?- piezas_de(rueda_delantera, Piezas), write(Piezas), nl.
% ¿Cuales son las piezas basicas del cuadro?
%?- piezas_de(cuadro, Piezas), write(Piezas), nl.
% ¿Cuales son las piezas basicas de la traccion?
%?- piezas_de(traccion, Piezas), write(Piezas), nl.
% ¿Cuales son las piezas basicas de la rueda trasera?
%?- piezas_de(rueda_trasera, Piezas), write(Piezas), nl.
% ¿Cuales son las piezas basicas para armar toda la bicicleta?
%?- piezas_de(bicicleta, Piezas), write(Piezas), nl.
