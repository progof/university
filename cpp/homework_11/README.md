Uzupełnij następujący szkielet programu i zaimplementuj wymienione funkcje i metody. Napisz funkcję main() testującą działanie klas.

```
class Person {

protected:
	string name;
	int year_of_birth;

public:
	Person(const string&, int);
	virtual void print(ostream&) const;
};

class Worker : public Person {

protected:
	double salary;

public:
	Worker(const string&, int, double);
	void print(ostream&) const;
	double get_salary() const;
};

class Manager : public Worker {
	string dept;

public:
	Manager(const string&, int, double, const string&);
	void print(ostream&) const;
	string get_dept() const;
};

ostream& operator<<(ostream& os, const Person& o);
//	make sure it prints the right object type (use print())

int main() {
	//	...
}
```
