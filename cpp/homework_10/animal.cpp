/*
Student: Oleh Ortynskyi 1k112

Napisz klasę Animal, zawierającą:
imię zwierzęcia
wiek zwierzęcia
konstruktor
funkcję print(), drukującą dane zwierzęcia
Napisz operator wyjścia dla obiektu klasy Animal.
Zdefiniuj klasy Horse i Dog dziedziczące z klasy Animal, które zawierają dodatkowo: pole breed typu string (rasa konia) i pole height typu całkowitego (wysokość w kłębie) dla klasy Horse oraz pole weight typu rzeczywistego (waga psa) dla klasy Dog. W obu klasach pochodnych zredefiniuj odpowiednie funkcje klasy Animal.
Funkcja main() powinna utworzyć i wydrukować obiekty typu Horse i Dog.
*/
#include <iostream>
#include <string>
using namespace std;

class Animal {
public:
    Animal(string name_animal, int age_animal)
    {
        name = name_animal;
        age = age_animal;
    }
    ostream &printData(ostream &out) const
    {
        return out << "\n\tName: " << name << ", Age: " << age << endl;

    }
    friend ostream &operator<<(ostream &out, const Animal &obj)
    {
        return obj.printData(out);
    }
protected:
    string name;
    int age;
};

class Horse: public Animal {
public:
    Horse(string name_animal, int age_animal, string breed_horse, int heigth_horse) : Animal(name_animal, age_animal)
    {
        breed = breed_horse;
        height = heigth_horse;
    }
    ostream &printData(ostream &out) const
    {
        return out << "\n\tName: " << name << ", Age: " << age << ", Breed:" << breed << ", Height:" << height<< endl;

    }
    friend ostream &operator<<(ostream &out, const Horse &obj)
    {
        return obj.printData(out);
    }
private:
    string breed;
    int height;
};

class Dog: public Animal {
public:
    Dog(string name_animal, int age_animal,  double weight_dog) : Animal(name_animal, age_animal)
    {
        weight = weight_dog;
    }
    ostream &printData(ostream &out) const
    {
        return out << "\n\tName: " << name << ", Age: " << age << ",  Weight:" << weight << endl;

    }
    friend ostream &operator<<(ostream &out, const Dog &obj)
    {
        return obj.printData(out);
    }
private:
    double weight;
};

int main()
{
    Animal animal("Leo", 45);
    cout << animal << endl;

    Horse horse("Lee", 12, "red", 23);
    cout << horse << endl;

    Dog dog("Linda", 14, 8.5);
    cout << dog << endl;

    return 0;
}
