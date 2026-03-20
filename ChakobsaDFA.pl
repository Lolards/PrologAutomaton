% Knowledge base: move(CurrentState, NextState, Character)
% Words: bakka, baklawa, baraka, baz, bidriyah

% DFA structure based on diagram:

move(q0,  q1,  b).
move(q1,  q8,  a).
move(q1,  q2,  i).
move(q8,  q13, r).
move(q8,  q9,  k).
move(q8,  q15, z).
move(q9,  q10, k).
move(q9,  q11, l).
move(q11, q12, a).
move(q12, q10, w).
move(q13, q14, a).
move(q14, q10, k).
move(q14, q10, w).
move(q10, q15, a).
move(q2,  q3,  d).
move(q3,  q4,  r).
move(q4,  q5,  i).
move(q5,  q6,  y).
move(q6,  q7,  a).
move(q7,  q15, h).

% Accepting state
accepting_state(q15).

% Entry point
go_over_automaton(ListToCheck) :-
    automatonCheck(ListToCheck, q0).

% Base case: entire list consumed, check if current state is accepting
automatonCheck([], CurrentState) :-
    accepting_state(CurrentState).

% Recursive case (Tail): process next symbol
automatonCheck([Symbol | Rest], CurrentState) :-
    move(CurrentState, NextState, Symbol),
    automatonCheck(Rest, NextState).

% ---- Test cases ----

bakka :-
    write('bakka'), nl,
    write('Expected: true'), nl,
    ( go_over_automaton([b, a, k, k, a]) -> write('Result: true') ; write('Result: false') ), nl.

baklawa :-
    write('baklawa'), nl,
    write('Expected: true'), nl,
    ( go_over_automaton([b, a, k, l, a, w, a]) -> write('Result: true') ; write('Result: false') ), nl.

baraka :-
    write('baraka'), nl,
    write('Expected: true'), nl,
    ( go_over_automaton([b, a, r, a, k, a]) -> write('Result: true') ; write('Result: false') ), nl.

baz :-
    write('baz'), nl,
    write('Expected: true'), nl,
    ( go_over_automaton([b, a, z]) -> write('Result: true') ; write('Result: false') ), nl.

bidriyah :-
    write('bidriyah'), nl,
    write('Expected: true'), nl,
    ( go_over_automaton([b, i, d, r, i, y, a, h]) -> write('Result: true') ; write('Result: false') ), nl.

baka :-
    write('baka (wrong: missing second k)'), nl,
    write('Expected: false'), nl,
    ( go_over_automaton([b, a, k, a]) -> write('Result: true') ; write('Result: false') ), nl.

baklawa :-
    write('baklawaa (wrong: extra a)'), nl,
    write('Expected: false'), nl,
    ( go_over_automaton([b, a, k, l, a, w, a, a]) -> write('Result: true') ; write('Result: false') ), nl.

bidriya :-
    write('bidriya (wrong: missing h)'), nl,
    write('Expected: false'), nl,
    ( go_over_automaton([b, i, d, r, i, y, a]) -> write('Result: true') ; write('Result: false') ), nl.

hello :-
    write('hello (wrong: not in language)'), nl,
    write('Expected: false'), nl,
    ( go_over_automaton([h, e, l, l, o]) -> write('Result: true') ; write('Result: false') ), nl.