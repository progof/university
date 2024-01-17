Dany jest plik tekstowy students.txt, którego każda linia zawiera imię studenta i symbol przedmiotu na jaki uczęszcza. Student może być zapisany na kilka przedmiotów (czyli jego imię może pojawić się w pliku wielokrotnie.
Na podstawie danych zawartych w pliku utwórz strukturę opartą o jedną z kolekcji Map, której kluczami są symbole przedmiotów a wartościami listy studentów uczęszczających na dany przedmiot.
Proszę przetestować stworzoną strukturę, implementując funkcje:

```
int numberOfClasses() - zwraca liczbę przedmiotów
LinkedList<String> studentsAttendingClass(String classCode) - zwraca alfabetyczną listę studentów uczęszczających na dane zajęcia
int bigClasses(int limit) - zwraca liczbę przedmiotów, na które uczęszcza więcej niż limit studentów
LinkedList<String> bigClassesList(int limit) - zwraca listę przedmiotów, na które uczęszcza więcej niż limit studentów
int classNumber(String student) - zwraca liczbę przedmiotów, na które uczęszcza zadany student
LinkedList<String> classList(String student) - zwraca listę przedmiotów, na które uczęszcza zadany student
```
