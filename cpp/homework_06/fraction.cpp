/*
Student: Oleh Ortynskyi 1k112

Napisz klasę Fraction. Zaimplementuj:
    konstruktor, który przyjmuje dwa parametry całkowite (licznik i mianownik); 
    konstruktor powinien wypisać komunikat o błędzie w przypadku, gdy mianownik jest zerem
    Fraction add(Fraction u) - dodawanie ułamków
    Fraction mult(Fraction u) - mnożenie ułamków
    void reduce() - skróć ułamek
    double evaluate() - zwraca wartość ułamka w postaci liczby rzeczywistej
    void print() - wypisuje ułamek
Funkcja main() testuje funkcje składowe klasy Fraction
*/
#include <iostream>
using namespace std;

class Fraction {
    int numerator;
    int denominator;
public:
    Fraction(int num, int denom)
    {
        if(denom == 0)
        { 
            cout << "Error: the denominator is zero" << endl;
            return;
        }
        numerator = num;
        denominator = denom;    
    }
    Fraction add(Fraction u)
    {
        int num = numerator * u.denominator + u.numerator * denominator;
        int denom = denominator * u.denominator;
        return Fraction(num,denom);
    }
    Fraction mult(Fraction u) {
        int num = numerator * u.numerator;
        int denom = denominator * u.denominator;
        return Fraction(num, denom);
    }

    void reduce() {
        int gcd = getGcd(numerator, denominator);
        numerator /= gcd;
        denominator /= gcd;
    }

    double evaluate() {
        return (double)numerator / denominator;
    }

    void print() {
        cout << numerator << "/" << denominator << endl;
    }

private:
    int getGcd(int a, int b) {
        if(b == 0) return a;
        return getGcd(b, a % b);
    }    
};

int main()
{
    Fraction f1(2, 3);
    Fraction f2(5, 8);
    Fraction f3 = f1.add(f2);
    Fraction f4 = f1.mult(f2);

    cout << "f1: ";
    f1.print();
    cout << "f2: ";
    f2.print();
    cout << "f1 + f2 = ";
    f3.print();
    cout << "f1 * f2 = ";
    f4.print();

    cout << " " << endl;

    f1.reduce();
    cout << "f1 (reduced): ";
    f1.print();
    cout << "f1 (evaluated): " << f1.evaluate() << endl;

    cout << " " << endl;

    cout << "f5(1, 0) test error:" << endl;
    Fraction f5(1, 0);

    return 0;
}