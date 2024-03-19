
// 1k112 Oleh Ortysnkyi

#include <iostream>
#include <cmath>
using namespace std;

bool is_prime(int n);
void print_primes(int m, int n);
int num_primes(int m, int n);

int main()
{
    cout << endl;
    print_primes(50, 150);
    cout << endl;
    
    for (int i = 1; i <= 10; i++) {
        int m = (i - 1) * 100 + 1;
        int n = i * 100;
        int count = num_primes(m, n);
        cout << "Liczba liczb pierwszych w przedziale [" << m << ", " << n << "]: " << count << endl;
    }
    return 0;
}

bool is_prime(int n)
{
    for (int i = 2; i <= sqrt(n); i++)
    {
        if (n % i == 0)
        {
            return false;
        }
    }
    return true;
}

void print_primes(int m, int n)
{
    for (int i = m; i <= n; i++)
    {
        if (is_prime(i))
        {
            cout << i << " ";
        }
    }
    cout << endl;
}

int num_primes(int m, int n)
{
    int count = 0;
    for (int i = m; i <= n; i++)
    {
        if (is_prime(i))
        {
            count++;
        }
    }
    return count;
}

