% USE UTF-8

:- set_prolog_flag(encoding, utf8).
:-['two.pl'].

% 2.1 Напечатать средний балл для каждого предмета.

% Список предметов
subjects(List) :- setof(Subject, A^B^C^grade(A, B, Subject, C), List).

% Сумма(list, sum_of_elements).
sum([], 0).
sum([Head|Tail], Sum) :- sum(Tail, Sum1), Sum is Sum1 + Head.

% Среднее значение(list, average_value_of_elements).
average(List, Average) :- sum(List, Sum), length(List, Length), Average is Sum / Length.

% Получить средний балл N для предмета S.(subject, average_grade). - 
get_average_grade(Subject, Number) :- findall(Mark, grade(_, _, Subject, Mark), List), 
                                      average(List, Number).

% Напечатать средний балл для каждого предмета
print_average_grades(Subject, Average) :- subjects(Subjects), member(Subject, Subjects), 
                                          get_average_grade(Subject, Average).



% 2.2 Для каждой группы, найти количество не сдавших студентов

% Напечатать количество не сдавших студентов для каждой группы
print_failed_exam(Group, Number) :- setof(Student, A^grade(Group, Student, A, 2), List), 
                                    length(List, Number).



% 2.3 Найти количество не сдавших студентов для каждого из предметов

% Поиск количества студентов (N), не сдавших предмет S.
failed_subject(Subject, Number) :- findall(Student, grade(_, Student, Subject, 2), List), 
                                   length(List, Number).

% Напечатать список всех предметов и количество несдавших его студентов
print_failed_subject(Subject, Number) :- subjects(Subjects), member(Subject, Subjects), 
                                                  failed_subject(Subject, Number).