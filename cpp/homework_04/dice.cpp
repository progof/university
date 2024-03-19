/*
Student: Oleh Ortynskyi 1k112

Napisz funkcję pmf(...) (probability mass function), która symuluje wykonanie n rzutów dwoma kostkami i zapisuje wartości otrzymanego przybliżonego rozkładu prawdopodobieństwa w tablicy. 
Losując liczbę oczek jednej kostki -- dla uzyskania powtarzalności wyników -- należy raz wywołać funkcję rand() i jej wynik sprowadzić do przedziału [1,6].
Napisz również funkcję print_histogram(double v[], int n, int x_start, double y_scale), która w trybie znakowym przedstawia histogram funkcji o n wartościach zapisanych w argumencie v. 

Należy przyjąć założenia:
1. Oś zmiennej niezależnej jest pionowa, skierowana w dół. Oś zmiennej zależnej jest pozioma, skierowana w prawo (nie jest rysowana).
2. Wartości zmiennej niezależnej są kolejnymi liczbami naturalnymi, począwszy od x_start. Są one pisane od pierwszej lewej kolumny, w polu o szerokości 2 znaków z wyrównaniem w prawo.
3. W trzeciej kolumnie wyprowadzane są znaki '|' tworząc oś x.
4. Począwszy od 4. kolumny pisane są znaki '*'. Liczba znaków jest przeskalowaną i zaokrągloną wartością funkcji. Parametr y_scale jest wartością zmiennej zależnej odpowiadającej szerokości jednego znaku na wykresie.
5. Wartości funkcji (liczby nieujemne typu double) są wyprowadzane z dokładnością do 3 cyfr po kropce dziesiętnej w każdym wierszu, po jednej spacji na prawo od ostatniego znaku '*'.
*/

#include <iostream>
#include <cstdlib>
#include <ctime>
#include <cmath>
#include <iomanip>

using namespace std;

void pmf(int n, double p[]) {
    for (int i = 2; i <= 12; i++) {
        p[i] = 0.0;
    }
    srand(time(0)); 
    for (int i = 0; i < n; i++) {
        int roll1 = rand() % 6 + 1;
        int roll2 = rand() % 6 + 1;
        p[roll1 + roll2] += 1.0;
    }
    for (int i = 2; i <= 12; i++) {
        p[i] /= n;
    }
}

void print_histogram(double v[], int n, int x_start, double y_scale) {
    cout << setprecision(3) << fixed;
    for (int i = 0; i < n; i++) {
        cout << setw(2) << x_start + i << "  |";
        int num_stars = static_cast<int>(round(v[i] * y_scale));
        for (int j = 0; j < num_stars; j++) {
            cout << "*";
        }
        cout << " " << v[i] << endl;
    }
}


int main()
{
    double pmf_values[11] = {0.11, 0.12, 0.21, 0.31, 0.48, 0.42, 0.41, 0.24, 0.14, 0.1};
    pmf(1000, pmf_values);
    print_histogram(pmf_values, 11, 2, 50.0);
    return 0;
}