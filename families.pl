%padres
father("Tomás García Pérez", "7 de Mayo de 1960", "Profesor", 60).
father("José Pérez Ruiz", "6 de Marzo de 1963", "Pintor", 120).

%madres
mother("Luisa Gálvez Pérez", "12 de Mayo de 1964", "Médica", 90).
mother("Ana López Ruiz", "10 de Marzo de 1962", "Médica", 90).

%hijos
children("Juan García López", "5 de Enero de 1980", "Estudiante", 0).
children("María García López", "12 de Abril de 1992", "Estudiante", 0).
children("Juan Luis Pérez Pérez", "5 de Febrero de 1990", "Estuidante", 0).
children("María José Pérez Pérez", "12 de Junio de 1992", "Estudiante", 0).
children("José María Pérez Pérez", "12 de Julio de 1994", "Estudiante", 0).

%familias
family("Tomás García Pérez", "Ana López Ruiz", ["Juan García López", "María García López"]).
family("José Pérez Ruiz", "Luisa Gálvez Pérez", ["Juan Luis Pérez Pérez", "María José Pérez Pérez", "José María Pérez Pérez"]).


longitud([], 0).
longitud([_|Resto], Longitud) :-
    longitud(Resto, LongitudResto),
    Longitud is LongitudResto + 1.
%2.
% Predicado para verificar si una familia tiene un número específico de hijos
num_childrens(Num, Father, Mother) :-
  family(Father, Mother, Childrens),
  longitud(Childrens, Lenght),
  Lenght =:= Num.

num_childrens(Num) :-
  num_childrens(Num, Father, Mother) -> 
  write("La familia formada por "), write(Father),
  write(" y "), write(Mother),
  write(" tiene "), write(Num), write("hijos");
  write("No hay familias con "), write(Num), write(" hijos").

% ¿existe familia sin hijos?
% ?- num_childrens(0).
% ¿existe familia con un hijo?
% ?- num_childrens(1).
% ¿existe familia con dos hijos?
% ?- num_childrens(2).
% ¿existe familia con tres hijos?
% ?- num_childrens(3).
% ¿existe familia con cuatro hijos.?
% ?- num_childrens(4).

% 3. Buscar los nombres de los padres de familia con tres hijos.
% ?- num_childrens(3).

% 4
% Predicado para verificar si una familia está casada
married(Father, Mother) :-
  family(Father, Mother, _).

married_man(Father) :-
  married(Father, Mother) ->
  write(Father), write(" y "), write(Mother), write(" están casados");
  write("No está casado").

% Tomás García Pérez está casado
% ?- married_man("Tomás García Pérez").
% ?- married_man("John Doe").

%5
married_men :-
  married(Father, Mother),
  write(Father), write(" está casado con "), write(Mother), nl, ln.
married_men :- true.

% ?- married_men.

%6
married_woman(Mother) :-
  married(Father, Mother) ->
  write(Mother), write(" y "), write(Father), write(" están casados");
  write("No está casada").
 
% Luisa Gálvez Pérez estara casada
% ?- married_woman("Luisa Gálvez Pérez").
% ?- married_woman("Jane Doe").

%7
married_women :-
  married(Father, Mother),
  write(Mother), write(" está casada con "), write(Father), nl, ln.
% ?- married_women.

%8 Determinar el nombre de todas las mujeres casadas que trabajan.
mother_working(Mother) :-
  mother(Mother, _, Profession, _),
  family(_,Mother,_),
  Profession \= "Estudiante".
  
list_mother_working :- 
  mother_working(Mother),
    write(Mother), write(" es una mujer casada que trabaja"), nl, ln.
% ?- list_mother_working.

%9.Definir la relación hijo(X) que se verifique si X figura en alguna lista de hijos.
hijo(X) :-
  family(_, _, ListaHijos),
  member(X, ListaHijos) -> 
    write("Es un hijo"); 
    write("No es un hijo").
%?- hijo("Juan García López").

% 10.Preguntar por los hijos.
hijos :-
  family(_, _, ListaHijos),
  member(X, ListaHijos),
  write(X), write(" es un hijo."),
  nl, ln.
% ?- hijos.

% 11.Definir la relación persona(X) que se verifique si X es una persona existente
% en la base de datos.
persona(X) :-
  father(X, _, _, _).
persona(X) :-
  mother(X, _, _, _).
persona(X) :-
  children(X, _, _, _).

existe(X) :-
  persona(X) -> 
  write("Es una persona existente en la base de datos"); 
  write("No es una persona existente en la base de datos").
% ?- existe("Tomás García Pérez").

% 12. Consulta para obtener los nombres y apellidos de todas las personas existentes
% ?- persona(X), write(X), nl, ln.

% 16.Definir la relación sueldo(X,Y) que se verifique si el sueldo de la persona X es Y.
sueldo(X, Y) :- father(X, _, _, Y).
sueldo(X, Y) :- mother(X, _, _, Y).

sueldo(X, Y) :- father(X, _, _, Y).
sueldo(X, Y) :- mother(X, _, _, Y).

% ?- sueldo("Tomás García Pérez", Salario), write(Salario).

% 18.Definir la relación total(L,Y) de forma que si L es una lista de personas,
% entonces Y es la suma de los sueldos de las personas de la lista L.

total([], 0).
total([Persona | Resto], Suma) :-
  sueldo(Persona, Salario), 
  total(Resto, SumaResto), 
  Suma is Salario + SumaResto. 

% ?- total(["Tomás García Pérez", "José Pérez Ruiz"], Suma), write(Suma).

% 20.Calcular los ingresos totales de cada familia.

ingresos_familia(0, 0, 0). 
ingresos_familia(Padre, Madre, Ingresos) :-
  sueldo(Padre, SalarioPadre), 
  sueldo(Madre, SalarioMadre), 
  Ingresos is SalarioPadre + SalarioMadre.

consulta_ingresos_familias :-
  family(Padre, Madre, Hijos),
  ingresos_familia(Padre, Madre, Ingresos),
  write("Familia: "), write(Padre), write(" y "), 
  write(Madre), write(", Ingresos totales: "), write(Ingresos), 
  nl, ln.
  
?- consulta_ingresos_familias.
