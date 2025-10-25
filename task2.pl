% ==================== РЕШЕНИЕ ЗАДАНИЙ ====================

:- ensure_loaded(database).

% ==================== ЗАДАНИЕ 1: ТАБЛИЦА ГРУПП И СРЕДНИЙ БАЛЛ ====================

group_avg_grade(GroupID, AvgGrade) :-
    findall(Grade, 
           (students(StudentID, GroupID, _), grades(StudentID, _, Grade)), 
           Grades),
    sum_list(Grades, Sum),
    length(Grades, Count),
    AvgGrade is Sum / Count.

groups_avg_grades_table :-
    write('===================='), nl,
    write('Группа | Средний балл'), nl,
    write('-------------------'), nl,
    group_avg_grade(101, Avg1), format(' 101    | ~1f', [Avg1]), nl,
    group_avg_grade(102, Avg2), format(' 102    | ~1f', [Avg2]), nl,
    group_avg_grade(103, Avg3), format(' 103    | ~1f', [Avg3]), nl,
    group_avg_grade(104, Avg4), format(' 104    | ~1f', [Avg4]), nl,
    write('===================='), nl.

% ==================== ЗАДАНИЕ 2: СТУДЕНТЫ, НЕ СДАВШИЕ ЭКЗАМЕН ПО ПРЕДМЕТУ ====================

failed_students(Subject, StudentName) :-
    grades(StudentID, Subject, 2),
    students(StudentID, _, StudentName).

failed_by_subject_table :-
    write('===================='), nl,
    write('Не сдавшие по предметам'), nl,
    write('===================='), nl, nl,
    
    write('Математика: '),
    findall(Name, failed_students('Математика', Name), MathFailed),
    (MathFailed = [] -> write('нет'); write(MathFailed)),
    nl,
    
    write('Физика: '),
    findall(Name, failed_students('Физика', Name), PhysicsFailed),
    (PhysicsFailed = [] -> write('нет'); write(PhysicsFailed)),
    nl,
    
    write('Программирование: '),
    findall(Name, failed_students('Программирование', Name), ProgFailed),
    (ProgFailed = [] -> write('нет'); write(ProgFailed)),
    nl,
    write('===================='), nl.

% ==================== ЗАДАНИЕ 3: КОЛИЧЕСТВО НЕ СДАВШИХ ПО ГРУППАМ ====================

failed_count_in_group(GroupID, Count) :-
    findall(StudentID, 
           (students(StudentID, GroupID, _), grades(StudentID, _, 2)), 
           FailedStudents),
    sort(FailedStudents, UniqueFailed),
    length(UniqueFailed, Count).

failed_by_group_table :-
    write('===================='), nl,
    write('Группа | Не сдавшие'), nl,
    write('-------------------'), nl,
    failed_count_in_group(101, Count1), format(' 101    | ~w', [Count1]), nl,
    failed_count_in_group(102, Count2), format(' 102    | ~w', [Count2]), nl,
    failed_count_in_group(103, Count3), format(' 103    | ~w', [Count3]), nl,
    failed_count_in_group(104, Count4), format(' 104    | ~w', [Count4]), nl,
    write('===================='), nl.
