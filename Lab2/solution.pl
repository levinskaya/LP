/*17 В семье Семеновых пять человек: husband, wife, их son, sister_of_husband и father_of_wife. Все они работают. 
Один инженер, другой юрист, третий слесарь, четвертый экономист, пятый учитель. 
Вот что еще известно о них. Юрист и учитель не кровные родственники. Слесарь хороший спортсмен. 
Он пошел по стопам экономиста и играет в футбол за сборную завода. 
Инженер старше жены своего брата, но моложе, чем учитель. 
Экономист старше, чем слесарь. Назовите профессии каждого члена семьи Семеновых. */

:- set_prolog_flag(encoding, utf8).

remove1(X, [X|T], T).
remove1(X, [Y|T], [Y|R]):-
	remove1(X, T, R).

permute1([],[]).
permute1(X, R):-
	remove1(Y, X, T),
	permute1(T, T1),
	R = [Y|T1].

closeRelative('husband', 'son').
closeRelative('son', 'husband').
closeRelative('wife', 'son').
closeRelative('son', 'wife').
closeRelative('husband', 'sister_of_husband').
closeRelative('sister_of_husband', 'husband').
closeRelative('wife', 'father_of_wife').
closeRelative('father_of_wife', 'wife').

child('husband', 'son').
child('wife', 'son').
child('father_of_wife', 'wife').

has_brother('sister_of_husband', 'husband').

wife('husband', 'wife').

older('husband', 'son').
older('wife', 'son').
older('father_of_wife', 'wife').
older('father_of_wife', 'son').

% Неизвестные данные
older('husband', 'wife').
older('husband', 'father_of_wife').
older('husband', 'sister_of_husband').
older('wife', 'husband').
older('wife', 'sister_of_husband').
older('sister_of_husband', 'husband').
older('sister_of_husband', 'wife').
older('sister_of_husband', 'father_of_wife').
older('sister_of_husband', 'son').
older('father_of_wife', 'husband').
older('father_of_wife', 'sister_of_husband').
older('son', 'sister_of_husband').

younger('husband', 'wife').
younger('husband', 'father_of_wife').
younger('husband', 'sister_of_husband').
younger('wife', 'husband').
younger('wife', 'sister_of_husband').
younger('sister_of_husband', 'husband').
younger('sister_of_husband', 'wife').
younger('sister_of_husband', 'father_of_wife').
younger('sister_of_husband', 'son').
younger('father_of_wife', 'husband').
younger('father_of_wife', 'sister_of_husband').
younger('son', 'sister_of_husband').

profession(_, 'engineer').
profession(_, 'lawyer').	
profession(_, 'locksmith').	
profession(_, 'economist').	
profession(_, 'teacher').

write_answer(X1, X2, X3, X4, X5):-
	write(X1), write(" - "), write("engineer"), nl,
	write(X2), write(" - "), write("lawyer"), nl,
	write(X3), write(" - "), write("locksmith"), nl,
	write(X4), write(" - "), write("economist"), nl,
	write(X5), write(" - "), write("teacher"), nl.

solve:-
	People = [X1, X2, X3, X4, X5],
	permute1(People, ['husband', 'wife', 'son', 'father_of_wife', 'sister_of_husband']),

	profession(X1, 'engineer'),	
	profession(X2, 'lawyer'),	
	profession(X3, 'locksmith'),	
	profession(X4, 'economist'),	
	profession(X5, 'teacher'),

	% Завязаны на профессиях
	has_brother(X1, XX1),
	wife(XX1, XX2),
	older(X1, XX2),
	not(closeRelative(X2, X5)),
	child(X4, X3),
	younger(X1, X5),
	older(X4, X3),
	write_answer(X1, X2, X3, X4, X5).