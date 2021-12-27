% Первая часть задания - предикаты работы со списками

% Стандартные предикаты:

 % Предикат получения длины списка.
my_length([], 0). 
my_lenght([_|Tail], N) :- my_lenght(Tail, N1), 
                        N is N1 + 1.

% Предикат проверки принадлежности элемента X списку List.
my_member(Head, [Head|_]).
my_member(X, [_|Tail]) :- my_member(X, Tail).

% Объединение списков List1 и List2. Результат List3.
my_append([], List2, List2).
my_append([Head | Tail1], List2, [Head | Tail3]) :- my_append(Tail1, List2, Tail3).

% Предикат удаления элемента X из списка List.
my_remove(X,[X|T],T).
my_remove(X,[H|T],[H|Y]) :- my_remove(X,T,Y).

% Предикат проверки перестановки списка
my_permute([],[]).
my_permute(X,[H|T1]) :-
  my_remove(H,X,T),
  my_permute(T,T1).

% Предикат проверки подсписка
my_sublist(Sub, List) :-
	my_append(_, L2, List),
	my_append(Sub, _, L2).



% Подсчет числа вхождений N заданного элемента X в список List (без стандартных предикатов)
count_entry(_,[],0).
count_entry(X,[X | Tail], N) :-
	count_entry(X, Tail , N1),
	N is N1 + 1, !.
count_entry(X, [_ | Tail], N) :-
	count_entry(X, Tail, N).

% Вычисление максимального элемента (без стандартных предикатов)
max(X,[X | Tail]) :-
	maxhelp(X, Tail), !.
max(MAX, [_ | Tail]) :-
	max(MAX, Tail). 

% Подсчет числа вхождений N заданного элемента X в список List
std_count_entry(_, [], 0).
std_count_entry(X, List, N) :-
	my_remove(A, List, NEW),
	A = X,
	std_count_entry(X, NEW, N1),
	N is N1 + 1, !.
std_count_entry(X, List, N) :-
	my_remove(A, List, NEW),
	A \= X,
	std_count_entry(X, NEW, N).

% Вычисление максимального элемента
std_max(X, [X | Tail]) :- 
	maxhelp(X, Tail), !.
std_max(MAX, [X | Tail]) :-
	my_remove(X, [X | Tail], List),
	std_max(MAX, List).

% Предикат определения максимального элемента
maxhelp(X,[H | Tail]) :-
  X >= H,
  maxhelp(X, Tail).
maxhelp(_, []).