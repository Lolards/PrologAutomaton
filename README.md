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
![Automata](https://github.com/Lolards/PrologAutomaton/blob/5d85a1eb560835ed7477a1f6e48a71fb635043ab/DFA.pdf)

Another way to represent the same automaton is through a regular expression (regex). A regex is a sequence of sub-expressions that is extremely powerful for searching and manipulating text strings. In this case, since the automaton only accepts exactly five words, the regex can be written using the OR operator (|), which accepts one string or another. Additionally, since four of the five words share the prefix ba, the expression can be simplified by factoring it out and only writing the differing suffixes inside parentheses. The resulting regex for this language would be:

( ^ ba(kka | klawa | raka | z) | bidriyah )$

This is more compact than inserting all five words separately, and it still tells the machine to accept only those exact strings — which is exactly what the DFA does.
