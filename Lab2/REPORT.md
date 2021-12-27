#№ Отчет по лабораторной работе №2
## по курсу "Логическое программирование"

## Решение логических задач

### студент: Москвин А. А.

## Результат проверки

| Преподаватель     | Дата         |  Оценка       |
|-------------------|--------------|---------------|
| Сошников Д.В. |              |               |
| Левинская М.А.|              |               |

> *Комментарии проверяющих (обратите внимание, что более подробные комментарии возможны непосредственно в репозитории по тексту программы)*


## Введение

Два наиболее распространённых способа решения логических задач - это полный перебор решений и метод исключения. В первом способе перебираются все возможные варианты, а также для различных значений проверяется истинность остальных высказываний. Второй же способ предполагает, что мы можем сразу попытаться определить противоречащие друг другу случаи и отсечь их, благодаря чему сузить количество возможных вариантов.
Сама структура логических задач построена на высказываниях, которые достаточно легко переносятся на логику предикатов, с которой и работает Prolog. Благодаря чему достаточно описать все высказывания из задачи, а Prolog выведет для нее все решения, если такие имеются.

## Задание

Вариант 17:
В семье Семеновых пять человек: муж, жена, их сын, сестра мужа и отец жены. Все они работают. Один инженер, другой юрист, третий слесарь, четвертый экономист, пятый учитель. Вот что еще известно о них. Юрист и учитель не кровные родственники. Слесарь хороший спортсмен. Он пошел по стопам экономиста и играет в футбол за сборную завода. Инженер старше жены своего брата, но моложе, чем учитель. Экономист старше, чем слесарь. Назовите профессии каждого члена семьи Семеновых.

## Принцип решения

Сначала данные по задаче я перевёл в логику предикатов: определил пол (male или female),
```prolog
male("husband").
male("son").
male("father_of_wife").
female("wife").
female("sister_of_husband").
```
потом определил предикат `playFootball(X)` (т.к. по условию задачи сказано, что в футбол играет только мужчина, то 
```prolog
playFootball(X) :- male(X).
```
После этого определил список ближайших (т.е. кровных) родственников:
```prolog
kinship("son", "sister_of_husband").
kinship("son", "husband").
kinship("son", "wife").
kinship("son", "father_of_wife").
kinship("husband", "sister_of_husband").
kinship("wife", "father_of_wife").
```
Известные данные о старшинстве членов семьи я определил с помощью предиката `older`:
```prolog
older("father_of_wife", "wife").
older("father_of_wife", "son").
older("wife", "son").
older("husband", "son").
older("sister_of_husband", "wife").
```
### Исходный код файла:
```prolog
male("husband").
male("son").
male("father_of_wife").
female("wife").
female("sister_of_husband").

playFootball(X) :- male(X).

hasBrother("sister_of_husband").

kinship("son", "sister_of_husband").
kinship("son", "husband").
kinship("son", "wife").
kinship("son", "father_of_wife").
kinship("husband", "sister_of_husband").
kinship("wife", "father_of_wife").

closeRelative(X, Y) :-
	kinship(X, Y); kinship(Y, X).

older("father_of_wife", "wife").
older("father_of_wife", "son").
older("wife", "son").
older("husband", "son").
older("sister_of_husband", "wife").

solve() :-
	permutation(["husband", "wife", "son", "sister_of_husband", "father_of_wife"], [Engineer, Lawyer, Locksmith, Economist, Teacher]),

	hasBrother(Engineer),
	not(closeRelative(Lawyer, Teacher)),
	playFootball(Locksmith),
	playFootball(Economist),
	not(older(Engineer, Teacher)),
	older(Economist, Locksmith),

	write("Engineer is "), write(Engineer), nl,
	write("Lawyer is "), write(Lawyer), nl,
	write("Locksmith is "), write(Locksmith), nl,
	write("Economist is "), write(Economist), nl,
	write("Teacher is "), write(Teacher), nl.
```
## Выводы

Сформулируйте *содержательные* выводы по лабораторной работе. Чему она вас научила? Над чем заставила задуматься? Помните, что несодержательные выводы -
самая частая причина снижения оценки за лабораторную.




