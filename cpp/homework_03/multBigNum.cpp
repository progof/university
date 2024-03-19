/* 
1k112 Oleh Ortynskyi
Proszę napisać program, który wczytuje dwie liczby całkowite 
(co najwyżej stucyfrowe) a następnie wylicza i drukuje ich iloczyn.
*/
#include <iostream>
#include <cstring>

using namespace std;

const int MAX_DIGITS = 100; 

int main()
{
    char a[MAX_DIGITS+1], b[MAX_DIGITS+1];
    int result[MAX_DIGITS*2] = {0};

    cout << "Enter the number [a]: ";
    cin >> a;
    cout << "Enter the number [b]: ";
    cin >> b;

    int len_a = strlen(a), len_b = strlen(b);

    int num_a[MAX_DIGITS], num_b[MAX_DIGITS];

    for(int i = 0; i < len_a; i++)
        num_a[i] = a[len_a-1-i] - '0';

    for(int i = 0; i < len_b; i++)
        num_b[i] = b[len_b-1-i] - '0';

    for(int i = 0; i < len_a; i++)
    {
        for(int j = 0; j < len_b; j++)
        {
            result[i+j] += num_a[i] * num_b[j];
            result[i+j+1] += result[i+j] / 10;
            result[i+j] %= 10;
        }
    }

    int len_result = len_a + len_b - 1;
    while(len_result > 0 && result[len_result] == 0)
        len_result--;

    cout << "Result(a * b): ";
    for(int i = len_result; i >= 0; i--)
        cout << result[i];
    cout << endl;

    return 0;
}