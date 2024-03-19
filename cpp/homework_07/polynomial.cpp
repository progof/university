/*
Student: Oleh Ortynskti 1k112

Napisz klasę Polynomial opisującą wielomian n-tego stopnia.

Pola klasy to:
   - static constexpr int N {100}; - rozmiar tablicy współczynników
   - int n; - stopień wielomianu
   - double coefficients[N]; - tablica współczynników wielomianu skonstruowana tak, że coefficients[0] oznacza wyraz wolny, coefficients[1] jest współczynnikiem przy pierwszej potędze x itd.

Zaimplementuj następujące funkcje składowe klasy:
   - Konstruktor, przyjmujący jeden parametr typu całkowitego (określający stopień wielomianu) powinien zainicjalizować współczynniki wielomianu wartościami losowymi
   - void print(); - drukuj wielomian
   - Polynomial derivative(); - zwraca wielomian będący pochodną argumentu
*/
#include <iostream>
#include <cstdlib>
#include <ctime>
using namespace std;

class Polynomial
{
private:
    static constexpr int N {100};
    int n;
    double coefficients[N];
public:
     Polynomial(int degree)
     {
        n = degree;
        srand(time(nullptr)); 
        for (int i = 0; i <= n; ++i)
        {
            coefficients[i] = (double)rand() / RAND_MAX; 
        }    
    }
    void print()
    {
        cout << "f(x) = ";
        for (int i = n; i >= 0; --i) {
            if (i == n)
            {
                cout << coefficients[i] << "x^" << i;
            }
            else if (i == 0)
            {
                cout << " + " << coefficients[i];
            } else {
                cout << " + " << coefficients[i] << "x^" << i;
            }
        }
        cout << endl;
    }
    Polynomial derivative()
    {
        Polynomial result(n - 1);
        for (int i = 1; i <= n; ++i)
        {
            result.coefficients[i - 1] = i * coefficients[i];
        }
        return result;
    }
};

int main()
{
    Polynomial p(3); 
    p.print();
    Polynomial p_prime = p.derivative(); 
    p_prime.print();

    return EXIT_SUCCESS;
}