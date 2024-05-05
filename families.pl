%padres
father('Tomás García Pérez', '7 de Mayo de 1960', 'Profesor', 60).
father('José Pérez Ruiz', '6 de Marzo de 1963', 'Pintor', 120).

%madres
mother('Luisa Gálvez Pérez', '12 de Mayo de 1964', 'Médica', 90).
mother('Ana López Ruiz', '10 de Marzo de 1962', 'Médica', 90).

%hijos
children('Juan García López', '5 de Enero de 1980', 'Estudiante', 0).
children('María García López', '12 de Abril de 1992', 'Estudiante', 0).
children('Juan Luis Pérez Pérez', '5 de Febrero de 1990', 'Estuidante', 0).
children('María José Pérez Pérez', '12 de Junio de 1992', 'Estudiante', 0).
children('José María Pérez Pérez', '12 de Julio de 1994', 'Estudiante', 0).

%familias
family('Tomás García Pérez', 'Ana López Ruiz', ['Juan García López', 'María García López']).
family('José Pérez Ruiz', 'Luisa Gálvez Pérez', ['Juan Luis Pérez Pérez', 'María José Pérez Pérez', 'José María Pérez Pérez']).


% Predicado para verificar si una familia tiene un número específico de hijos
num_childrens(Num, Father, Mother) :-
  family(Father, Mother, Childrens),
  length(Childrens, Num).

num_childrens(Num) :-
  num_childrens(Num, Father, Mother) -> 
  format('La familia formada por ~w y ~w tiene ~d hijos.~n', [Father, Mother, Num]); 
  format('No hay familias con ~d hijos', [Num]).

% Predicado para verificar si una familia está casada
married(Father, Mother) :-
  family(Father, Mother, _).

man_married(Father) :-
  married(Father, Mother) ->
  format('~w y ~w están casados ~n', [Father, Mother]); 
  format('~w no está casado ~n', [Father]). 

woman_married(Mother) :-
  married(Father, Mother) ->
  format('~w y ~w están casados ~n', [Father, Mother]); 
  format('~w no está casada ~n', [Mother]). 

mother_working(Mother) :-
  mother(Mother, _, Profession, _),
  woman_married(Mother),
  Profession \= 'Estudiante'.
  
list_mother_working :- 
  mother_working(Mother),
    write(Mother), write(' es una mujer casada que trabaja'), nl, fail.

list_mother_working :- true.

hijo(X) :-
  family(_, _, ListaHijos),
  member(X, ListaHijos) -> 
    format('~w es un hijo.~n', [X]); 
    format('~w no es un hijo.~n', [X]).

persona(X) :-
  father(X, _, _, _).
persona(X) :-
  mother(X, _, _, _).
persona(X) :-
  children(X, _, _, _).

existe(X) :-
  persona(X) -> 
  write('Es una persona existente en la base de datos'); 
  write('No es una persona existente en la base de datos').

sueldo(X, Y) :- father(X, _, _, Y).
sueldo(X, Y) :- mother(X, _, _, Y).

% Definición de la relación total(L, Y)
total([], 0). % Caso base: la suma de una lista vacía es 0.
total([Persona | Resto], Suma) :-
  sueldo(Persona, Salario), % Obtiene el salario de la persona.
  total(Resto, SumaResto),  % Calcula la suma del resto de la lista.
  Suma is Salario + SumaResto. % Calcula la suma total.

% Calcula los ingresos totales de una familia
ingresos_familia([], 0). % Caso base: la suma de una lista vacía es 0.
ingresos_familia([Padre, Madre | Hijos], Ingresos) :-
  sueldo(Padre, SalarioPadre), % Obtiene el salario del padre.
  sueldo(Madre, SalarioMadre), % Obtiene el salario de la madre.
  total(Hijos, IngresosHijos), % Calcula la suma de los ingresos de los hijos.
  Ingresos is SalarioPadre + SalarioMadre + IngresosHijos. % Calcula la suma total de ingresos de la familia.

% Consulta los ingresos totales de cada familia
consulta_ingresos_familias :-
  family(Padre, Madre, Hijos),
  ingresos_familia([Padre, Madre | Hijos], Ingresos),
  write('Familia: '), write(Padre), write(' y '), write(Madre), write(', Ingresos totales: '), write(Ingresos), nl,
  fail. % Fuerza el backtracking para encontrar más soluciones
consulta_ingresos_familias. % Termina la consulta

% Ejemplo de uso:

%2.
% ¿existe familia sin hijos?
%?- num_childrens(0).

% ¿existe familia con un hijo?
%?- num_childrens(1).

% ¿existe familia con dos hijos?
%?- num_childrens(2).

% ¿existe familia con tres hijos?
% 3. Buscar los nombres de los padres de familia con tres hijos.
%?- num_childrens(3).

% ¿existe familia con cuatro hijos.?
%?- num_childrens(4).

%4.
% Tomás García Pérez está casado
% ?- man_married('Tomás García Pérez').
% ?- man_married('John Doe').

%6
% Luisa Gálvez Pérez estara casada
%?- woman_married('Luisa Gálvez Pérez').
%?- woman_married('Jane Doe').

%8 Determinar el nombre de todas las mujeres casadas que trabajan.
%?- list_mother_working.

%9.Definir la relación hijo(X) que se verifique si X figura en alguna lista de hijos.
% ?- hijo('Juan García López').

% 11.Definir la relación persona(X) que se verifique si X es una persona existente
% en la base de datos.
% ?- existe('Tomás García Pérez').

% Consulta para obtener los nombres y apellidos de todas las personas existentes
% ?- persona(X), format('~w~n', [X]), fail.

% 16.Definir la relación sueldo(X,Y) que se verifique si el sueldo de la persona X es Y.
% ?- sueldo('Tomás García Pérez', Salario), write(Salario).

% 18.Definir la relación total(L,Y) de forma que si L es una lista de personas,
% entonces Y es la suma de los sueldos de las personas de la lista L.
% ?- total(['Tomás García Pérez', 'José Pérez Ruiz'], Suma), write(Suma).

% 20.Calcular los ingresos totales de cada familia.
?- consulta_ingresos_familias.