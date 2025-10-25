% ==================== МОИ ВЕРСИИ СТАНДАРТНЫХ ПРЕДИКАТОВ ====================

% 1. Длина списка
my_length([], 0).
my_length([_|T], N) :- 
    my_length(T, N1), 
    N is N1 + 1.

% 2. Принадлежность элемента списку
my_member(X, [X|_]).
my_member(X, [_|T]) :- my_member(X, T).

% 3. Конкатенация списков
my_append([], L, L).
my_append([H|T], L, [H|R]) :- my_append(T, L, R).

% 4. Удаление элемента из списка
my_remove(X, [X|T], T).
my_remove(X, [H|T], [H|R]) :- 
    X \= H, 
    my_remove(X, T, R).

% 5. Перестановки списка
my_permute([], []).
my_permute(List, [H|Perm]) :- 
    my_remove(H, List, Rest), 
    my_permute(Rest, Perm).

% 6. Подсписки
my_sublist(S, L) :- 
    my_append(_, T, L), 
    my_append(S, _, T).

% ==================== ЗАДАНИЕ 1: УДАЛЕНИЕ ТРЕХ ПОСЛЕДНИХ ЭЛЕМЕНТОВ ====================

% Способ 1: С использованием стандартных предикатов
remove_last_three_standard(List, Result) :-
    length(List, Len),
    Len >= 3,
    PrefixLen is Len - 3,
    length(Result, PrefixLen),
    append(Result, _, List).

% Способ 2: С использованием моих предикатов
remove_last_three_my(List, Result) :-
    my_length(List, Len),
    Len >= 3,
    remove_n_from_start(List, Len - 3, Result).

% Вспомогательный предикат: взять первые N элементов
remove_n_from_start(_, 0, []).
remove_n_from_start([H|T], N, [H|R]) :-
    N > 0,
    N1 is N - 1,
    remove_n_from_start(T, N1, R).

% ==================== ЗАДАНИЕ 2: ПРОВЕРКА УПОРЯДОЧЕННОСТИ ПО ВОЗРАСТАНИЮ ====================

% Способ 1: С использованием стандартных предикатов
is_sorted_standard([]).
is_sorted_standard([_]).
is_sorted_standard([X,Y|T]) :-
    X =< Y,
    is_sorted_standard([Y|T]).

% Способ 2: С использованием моих предикатов
is_sorted_my([]).
is_sorted_my([_]).
is_sorted_my([X,Y|T]) :-
    X =< Y,
    is_sorted_my([Y|T]).