# Evidence Implementation of Lexical Analysis
Leonardo Fuentes Bear - A01614731

## Description
The language I chose was Chakobsa, which, according to the Dune Wiki, is a language from the Dune universe, a science fiction novel written by Frank Herbert. Also known as the “magnetic language,” it derives from several ancient Bhotani dialects, especially the Bhotani hunting language. It likely emerged after the first Assassin Wars and was used by various groups such as the Bene Gesserit and the Fremen. Furthermore, when House Corrino ruled the known universe, House Atreides used a form of Chakobsa as their battle language.

The words that I chose to model are these 5 words: 
1. bakka - The Weeper
2. baklawa - dessert pastry
3. baraka - miracle worker
4. baz - falcon
5. bidriyah - coarse silica frit

Considering that my goal is to only accept those five words as valid and no more, I decided to use a "DFA". Since deterministic finite automata (DFAs) process input strings through a uniquely determined sequence of states, they are suitable for modeling this problem.

## Model of the solution
I decided to go with just one automaton for this language, since a single DFA is enough to cover all five words. This works well because the words share some common structure at the beginning, making it easy to model them in one machine. It is important to mention that the automaton is only valid for the following alphabet:

$\sum_{} = {a,b,d,e,h,i,k,l,r,s,w,y,z}$

Any character not belonging to this alphabet, and not explicitly present in the automaton, will cause the machine to reject the input string.

Here is the automaton:
![Automata](https://github.com/Lolards/PrologAutomaton/blob/f4635c56e85c511a7ec597247925aba3970e356b/DFA_Image.png)

Another way to represent the same automaton is through a regular expression (regex). A regex is a sequence of sub-expressions that is extremely powerful for searching and manipulating text strings. In this case, since the automaton only accepts exactly five words, the regex can be written using the OR operator (|), which accepts one string or another. Additionally, since four of the five words share the prefix ba, the expression can be simplified by factoring it out and only writing the differing suffixes inside parentheses. The resulting regex for this language would be:

( ^ ba(kka | klawa | raka | z) | bidriyah )$

This is more compact than inserting all five words separately, and it still tells the machine to accept only those exact strings — which is exactly what the DFA does.

## Implementation
To represent the automaton in Prolog, a knowledge base was created using facts and rules.

### Facts
#### ```move(CurrentState, NextState, Char).```

The transitions of the automaton are represented as facts using the predicate “move”, which takes three arguments: the current state, the next state, and the character that triggers the transition. For example:

```prolog
move(q0, q1, b).
```
This fact states: "if you are in state q0 and you read the character b, move to state q1." There is no logic here, just a plain declaration of what is true. The entire transition table of the automaton is built from these facts.

#### ```accepting_state```

```prolog
accepting_state(q15).
```
This fact declares that q15 is the only accepting state. If the automaton finishes reading the input and lands on this state, the word is accepted.

### Rules
#### ```go_over_automaton```

```prolog
go_over_automaton(ListToCheck) :-
    automatonCheck(ListToCheck, q0).
```
This is the entry point of the program. It receives the list of characters and calls automatonCheck starting from the initial state q0.

#### ```automatonCheck (base case)```

```prolog
automatonCheck([], CurrentState) :-
    accepting_state(CurrentState).
```

This is the base case of the recursion. It fires when the list of characters is empty, meaning all characters have been consumed. At that point, it checks whether the current state is an accepting state. If it is, the recursion ends successfully and the word is accepted.

#### ```automatonCheck (recursive case)```

```prolog
automatonCheck([Symbol | Rest], CurrentState) :-
    move(CurrentState, NextState, Symbol),
    automatonCheck(Rest, NextState).
```

This is the recursive case. It takes the first character of the list (Symbol) and checks if there is a valid transition from the current state using that character. If move succeeds, it calls itself again with the remaining list (Rest) and the new state (NextState). This repeats until the list is empty and the base case kicks in.

All of these rules and facts are found in the file ```ChakobsaDFA.pl```.

## Test
To verify that the automaton works correctly, two types of test cases were created: ones that are expected to be accepted (the five valid words) and ones that are expected to be rejected (invalid inputs).

Each test case follows the same structure, for example:

```prolog
bakka :-
    write('bakka'), nl,
    write('Expected: true'), nl,
    ( go_over_automaton([b, a, k, k, a]) -> write('Result: true') ; write('Result: false') ), nl.
```

Each test case prints the word being tested, the expected result, and then sends the word as a list of characters to the automaton using an if-then-else structure (-> and ;), which prints ```Result: true``` if the automaton accepts it or ```Result: false``` if it rejects it.

### Successful tests
1. ```bakka.```
2. ```baklawa.```
3. ```baraka.```
4. ```baz.```
5. ```bidriyah.```

### Unsuccessful tests
1. ```baka.```
2. ```baklawa.```
3. ```bidriya.```
4. ```hello.```

For the words that were already defined as test cases in the knowledge base, you can run them directly by just typing their name followed by a dot in the Prolog console, for example bakka. or hello. Prolog will find the corresponding rule and execute it automatically. However, if you want to test a completely different string that was not predefined, you need to call the automaton directly using the command:

```prolog
?- go_over_automaton([b, a, k, k, a]).
```

## Analysis

### Time Complexity

The time complexity of this automaton implementation is O(n), where n is the length of the input string.
This is because the program processes exactly one character per recursive call. Each call to ```automatonCheck``` does two things: look up a ```move``` fact in the knowledge base and make one recursive call with the remaining list. Since the knowledge base has a fixed and small number of states and transitions, each lookup takes constant time O(1). 

## References
Chakobsa. (2020, 24 diciembre). Fandom. Recuperado 15 de marzo de 2026, de https://dune.fandom.com/es/wiki/Chakobsa

Sisense. (n.d.). What is Deterministic Finite Automata? (DFA) | Definition. https://www.sisense.com/glossary/deterministic-finite-automata/

Chua, H. W. (November, 2018). Regular expressions (regex). Nanyang Technological University. https://www3.ntu.edu.sg/home/ehchua/programming/howto/Regexe.html

Jnj. (2021, 17 abril). Prolog: cómo hacer condicionales. JnjSite.com. https://jnjsite.com/prolog-como-hacer-condicionales/
