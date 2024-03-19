/*
Student: Oleh Ortynskyi 1k112
*/
#include <iostream>

template<typename T, int CAPACITY = 8>
class CyclicBuffer {
private:
    T buffer[CAPACITY];
    int p_read; // index to read
    int p_write; // index to write
    int count; // number of elements
public:
    CyclicBuffer() : p_read(0), p_write(0), count(0) {}

    bool empty()
    {
        return count == 0;
    }

    bool full()
    {
        return count == CAPACITY;
    }

    T get()
    {
        if (empty())
        {
            throw std::runtime_error("Buffer is empty");
        }

        T value = buffer[p_read];
        p_read = (p_read + 1) % CAPACITY;
        count--;
        return value;
    }

    void put(T value)
    {
        if (full())
        {
            throw std::runtime_error("Buffer is full");
        }

        buffer[p_write] = value;
        p_write = (p_write + 1) % CAPACITY;
        count++;
    }

    void print() const {
        int index = p_read;
        for (int i = 0; i < count; i++)
        {
            std::cout << buffer[index] << " ";
            index = (index + 1) % CAPACITY;
        }
        std::cout << std::endl;
    }
};

class MyObject {
private:
    int id;
public:
    MyObject() : id(0) {} 

    MyObject(int _id) : id(_id) {}

    int getID() const
    {
        return id;
    }

    friend std::ostream& operator<<(std::ostream& os, const MyObject& obj)
    {
        os << obj.id;
        return os;
    }
};

int main()
{
    std::cout << "CyclicBuffer of integers:" << std::endl;
    CyclicBuffer<int> intBuffer;

    for (int i = 1; i <= 10; i++)
    {
        if (!intBuffer.full())
        {
            intBuffer.put(i);
            std::cout << "Added: " << i << std::endl;
        }
    }

    std::cout << "Buffer contents: ";
    intBuffer.print();

    while (!intBuffer.empty())
    {
        int value = intBuffer.get();
        std::cout << "Retrieved: " << value << std::endl;
    }

    std::cout << std::endl;
    std::cout << "CyclicBuffer of MyObjects:" << std::endl;
    CyclicBuffer<MyObject, 16> objectBuffer;

    for (int i = 1; i <= 20; i++)
    {
        if (!objectBuffer.full())
        {
            objectBuffer.put(MyObject(i));
            std::cout << "Added: " << i << std::endl;
        }
    }

    std::cout << "Buffer contents: ";
    objectBuffer.print();

    while (!objectBuffer.empty())
    {
        MyObject obj = objectBuffer.get();
        std::cout << "Retrieved: " << obj.getID() << std::endl;
    }

    return 0;
}
