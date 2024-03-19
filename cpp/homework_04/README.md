Napisz funkcję pmf(...) (probability mass function), która symuluje wykonanie n rzutów dwoma kostkami i zapisuje wartości otrzymanego przybliżonego rozkładu prawdopodobieństwa w tablicy. Losując liczbę oczek jednej kostki -- dla uzyskania powtarzalności wyników -- należy raz wywołać funkcję rand() i jej wynik sprowadzić do przedziału [1,6].

Napisz również funkcję print\*histogram(double v[], int n, int x_start, double y_scale), która w trybie znakowym przedstawia histogram funkcji o n wartościach zapisanych w argumencie v. Należy przyjąć założenia:

1. Oś zmiennej niezależnej jest pionowa, skierowana w dół. Oś zmiennej zależnej jest pozioma, skierowana w prawo (nie jest rysowana).
2. Wartości zmiennej niezależnej są kolejnymi liczbami naturalnymi, począwszy od x_start. Są one pisane od pierwszej lewej kolumny, w polu o szerokości 2 znaków z wyrównaniem w prawo.
3. W trzeciej kolumnie wyprowadzane są znaki '|' tworząc oś x.
4. Począwszy od 4. kolumny pisane są znaki '*'. Liczba znaków jest przeskalowaną i zaokrągloną wartością funkcji. Parametr y*scale jest wartością zmiennej zależnej odpowiadającej szerokości jednego znaku na wykresie.
5. Wartości funkcji (liczby nieujemne typu double) są wyprowadzane z dokładnością do 3 cyfr po kropce dziesiętnej w każdym wierszu, po jednej spacji na prawo od ostatniego znaku '\*'.

Definicje: https://en.wikipedia.org/wiki/Probability mass function

Wejście: m
Wyjście: Dyskretny rozkład prawdopodobieństwa wyrażający prawdopodobieństwo wyrzucenia każdej z liczb od 2 do 12.

Przykład:

```
Wejście: 1000
Wyjście:
 2 |***** 0.024
 3 |************** 0.068
 4 |******************* 0.094
 5 |************************ 0.120
 6 |**************************** 0.140
 7 |********************************* 0.165
 8 |************************* 0.125
 9 |******************* 0.096
10 |***************** 0.083
11 |********** 0.051
12 |******* 0.034
```
