/*
    Student: Oleh Ortynskyi 1k112

    Zadanie:

    Symulacja książki telefonicznej
Napisz klasę Entry zawierającą nazwisko abonenta i numer telefonu (oba pola typu string). Klasa powinna zawierać konstruktor inicjalizujący pola, funkcję print() wypisującą wartości pól oraz gettery.
Klasa Directory reprezentuje książkę telefoniczną. Jej struktura wygląda następująco:

class Directory {
public:
    Directory(int max_size); // set up empty directory of entries (allocate array)
    Directory(const Directory &d); // copy constructor
    ~Directory(); // free memory
    void insert(const Entry &entry); // Insert an entry into the directory.
    void lookup(const string &name) const; // display the directory entry for a name
    void remove(const string &name); // remove an entry.
    void display() const; // display the current directory.
private:
    int	max_size; // the maximum allowable number of entries
    int current_size; // the current number of entries
    Entry* entry_list; // pointer to the list of entries
    void grow(); // double the maximum size, when required.
    int find_name(const string &name) const; // return index of an entry, given a name.
};
Funkcja main() testuje działanie klasy
*/
#include <iostream>
#include <string>
using namespace std;

class Entry {
public:
    Entry() {}

    Entry(string name, string phone_number) : name(name), phone_number(phone_number) {}

    string get_name() const
    {
        return name;
    }

    string get_phone_number() const
    {
        return phone_number;
    }

    void print() const 
    {
        cout << name << ": " << phone_number << endl;
    }
private:
    string name;
    string phone_number;
};

class Directory {
public:
    Directory(int max_size) : max_size(max_size), current_size(0)
    {
        entry_list = new Entry[max_size];
    }

    Directory(const Directory &d) : max_size(d.max_size), current_size(d.current_size)
    {
        entry_list = new Entry[max_size];
        for (int i = 0; i < current_size; i++) {
            entry_list[i] = d.entry_list[i];
        }
    }

    ~Directory()
    {
        delete[] entry_list;
    }

    void insert(const Entry &entry)
    {
        if (current_size == max_size)
        {
            grow();
        }
        entry_list[current_size] = entry;
        current_size++;
    }

    void lookup(const std::string &name) const
    {
        int index = find_name(name);
        if (index != -1)
        {
            entry_list[index].print();
        } else {
            cout << "Entry not found." << endl;
        }
    }

    void remove(const string &name) {
        int index = find_name(name);
        if (index != -1)
        {
            for (int i = index; i < current_size - 1; i++) 
            {
                entry_list[i] = entry_list[i+1];
            }
            current_size--;
        }
    }

    void display() const
    {
        for (int i = 0; i < current_size; i++)
        {
            entry_list[i].print();
        }
    }

private:
    int max_size;
    int current_size;
    Entry* entry_list;

    void grow()
    {
        max_size *= 2;
        Entry* new_entry_list = new Entry[max_size];
        for (int i = 0; i < current_size; i++)
        {
            new_entry_list[i] = entry_list[i];
        }
        delete[] entry_list;
        entry_list = new_entry_list;
    }

    int find_name(const string &name) const
    {
        for (int i = 0; i < current_size; i++)
        {
            if (entry_list[i].get_name() == name)
            {
                return i;
            }
        }
        return -1;
    }
};

int main()
{
    Directory directory(4);

    Entry entry1("Jan Kowalski", "111-222-334");
    directory.insert(entry1);

    Entry entry2("Joe Morelly", "555-354-565");
    directory.insert(entry2);

    Entry entry3("Tom Lee", "656-335-565");
    directory.insert(entry3);

    Entry entry4("Satoshi Nakamoto", "111-333-333-777");
    directory.insert(entry4);

    directory.display();

    directory.remove("Jan Kowalski");

    directory.lookup("Tom Lee");

    directory.lookup("Mia");

    return EXIT_SUCCESS;
}
