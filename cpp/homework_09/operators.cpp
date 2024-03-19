/*
Student: Oleh Ortynskyi 1k112

Napisz klasę Set opisującą podzbiór liczb całkowitych.
Zaimplementuj następujące metody klasy:
Konstruktory
Destruktor
operator+=() - suma zbiorów
operator-=() - różnica zbiorów
operator*=() - przecięcie zbiorów
oraz funkcje
operator+() - suma zbiorów
operator-() - różnica zbiorów
*/

#include <iostream>
#include <set>

class Se {
private:
    std::set<int> s;

public:
    Se() {}
    Se(const std::set<int>& other) : s(other) {}
    ~Se() {}

    Se& operator+=(const Se& other) {
        for (const auto& elem : other.s) {
            s.insert(elem);
        }
        return *this;
    }

    Se& operator-=(const Se& other) {
        for (const auto& elem : other.s) {
            s.erase(elem);
        }
        return *this;
    }

    Se& operator*=(const Se& other) {
        std::set<int> intersection;
        std::set_intersection(s.begin(), s.end(), other.s.begin(), other.s.end(), std::inserter(intersection, intersection.begin()));
        s = intersection;
        return *this;
    }

    Se operator+() const {
        return *this;
    }

    Se operator-() const {
        return Se(std::set<int>());
    }

    friend std::ostream& operator<<(std::ostream& os, const Se& se) {
        os << "{";
        for (const auto& elem : se.s) {
            os << elem << ",";
        }
        os << "}";
        return os;
    }
};

int main() {
    Se s1({1, 2, 3, 4, 5});
    Se s2({4, 5, 6, 7, 8});

    std::cout << "s1: " << s1 << std::endl;
    std::cout << "s2: " << s2 << std::endl;

    Se s3 = +s1;
    Se s4 = -s1;
    Se s5 = s1 += s2;
    Se s6 = s1 -= s2;
    Se s7 = s1 *= s2;

    std::cout << "+s1: " << s3 << std::endl;
    std::cout << "-s1: " << s4 << std::endl;
    std::cout << "s1 += s2: " << s5 << std::endl;
    std::cout << "s1 -= s2: " << s6 << std::endl;
    std::cout << "s1 *= s2: " << s7 << std::endl;

    return 0;
}
