/*
Student: Oleh Ortynskyi 1k112

Dana jest klasa account_info zawierająca numer konta bankowego, nazwisko właściciela i stan konta. 
Napisz program, który tworzy, inicjalizuje i drukuje tablicę kont (obiektów typu account_info) a następnie sprawdza stan kolejnych kont. 
Jeżeli stan konta jest ujemny, to generowany jest wyjątek negative_balance_exception (podklasy std::out_of_range). 
Obsługa wyjątku powinna polegać na wydrukowaniu nazwy wyjątku i wielkości deficytu na koncie, 
który spowodował wygenerowanie wyjątku (wykorzystaj nadpisaną w klasie wyjątku funkcję what()).
*/

#include <iostream>
#include <string>
#include <stdexcept>
using namespace std;

class negative_balance_exception : public out_of_range
{
public:
    negative_balance_exception(const string& what_arg) : std::out_of_range(what_arg) {}
};

class account_info 
{
public:
    string account_number;
    string owner_name;
    double account_balance;

    account_info(const string& number, const string& name, double balance) :
        account_number(number), owner_name(name), account_balance(balance) {}
};

int main() 
{
    const int NUM_ACCOUNTS = 6;

    account_info accounts[NUM_ACCOUNTS] = 
    {
        account_info("111111111", "Mike", 1800.0),
        account_info("222222222", "Jane", 5000.0),
        account_info("333333333", "Alice", -1200.0),
        account_info("444444444", "Bob", 1800.0),
        account_info("555555555", "Nick", 5000.0),
        account_info("777777777", "Mario", -6200.0)
    };

    cout << "Bank Accounts:\n" << endl;
    for (int i = 0; i < NUM_ACCOUNTS; i++) 
    {
        cout <<"Account number:" << accounts[i].account_number << endl;
        cout << "Owner: " << accounts[i].owner_name << endl;
        cout << "Account balance:" << accounts[i].account_balance << endl << endl;
    }

    for (int i = 0; i < NUM_ACCOUNTS; i++) 
    {
        try {
            if (accounts[i].account_balance < 0) 
            {
                throw negative_balance_exception("Negative account balance!");
            }
        } catch (const negative_balance_exception& e) {
            cout << "Exception: " << e.what() << endl;
            cout << "Account deficit: " << accounts[i].account_balance << endl << endl;
        }
    }

    return 0;
}
