/*
Student: Oleh Ortynskyi 1k112

Uzupełnij następujący szkielet programu i zaimplementuj wymienione funkcje i metody. 
Napisz funkcję main() testującą działanie klas.

*/
#include <iostream>
#include <string>

using namespace std;

class Person {
protected:
    string name;
    int year_of_birth;

public:
    Person(const string& name, int year_of_birth)
        : name(name), year_of_birth(year_of_birth) {}

    virtual void print(ostream& os) const
    {
        os << "[Person] Name: " << name << ", Year of Birth: " << year_of_birth;
    }
};

class Worker : public Person {
protected:
    double salary;

public:
    Worker(const string& name, int year_of_birth, double salary)
        : Person(name, year_of_birth), salary(salary) {}

    void print(ostream& os) const override
    {
        os << "[Worker] Name: " << name << ", Year of Birth: " << year_of_birth << ", Salary: " << salary;
    }

    double get_salary() const
    {
        return salary;
    }
};

class Manager : public Worker {
    string dept;

public:
    Manager(const string& name, int year_of_birth, double salary, const string& dept)
        : Worker(name, year_of_birth, salary), dept(dept) {}

    void print(ostream& os) const override
    {
        os << "[Manager] Name: " << name << ", Year of Birth: " << year_of_birth << ", Salary: " << salary
           << ", Department: " << dept;
    }

    string get_dept() const
    {
        return dept;
    }
};

ostream& operator<<(ostream& os, const Person& obj)
{
    obj.print(os);
    return os;
}

int main() {
    Person person("Jan Kowalski", 1990);
    Worker worker("Elon Musk", 1985, 5000.0);
    Manager manager("Steve Jobs", 1978, 9000.0, "Sales");

    cout << person << endl;
    cout << worker << endl;
    cout << manager << endl;

    return 0;
}
