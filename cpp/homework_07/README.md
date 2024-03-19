Napisz klasę Polynomial opisującą wielomian n-tego stopnia.
Pola klasy to:

static constexpr int N {100}; - rozmiar tablicy współczynników
int n; - stopień wielomianu
double coefficients[N]; - tablica współczynników wielomianu skonstruowana tak, że coefficients[0] oznacza wyraz wolny, coefficients[1] jest współczynnikiem przy pierwszej potędze x itd.

Zaimplementuj następujące funkcje składowe klasy:
Konstruktor, przyjmujący jeden parametr typu całkowitego (określający stopień wielomianu) powinien zainicjalizować współczynniki wielomianu wartościami losowymi
void print(); - drukuj wielomian
Polynomial derivative(); - zwraca wielomian będący pochodną argumentu

Napisz następujące funkcje zewnętrzne:

Polynomial add(const Polynomial&, const Polynomial&); - suma 2 wielomianów
Polynomial multiply(const Polynomial&, const Polynomial&); - iloczyn 2 wielomianów

Funkcja main() tworzy dwa obiekty typu Polynomial, p1 i p2, a następnie drukuje współczynniki wielomianów:

p1(x)
p2(x)
p1'(x)
p2'(x)
p1(x) + p2(x)
p1(x) \* p2(x)
