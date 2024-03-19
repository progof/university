/*
Student: Oleh Ortynskyi 1k112
                                                Gra w życie:

Gra toczy się na planszy o rozmiarze nXn podzielonej na nXn kwadratowych komórek. Każda komórka ma ośmiu "sąsiadów", 
czyli komórki przylegające do niej bokami i rogami. Każda komórka może znajdować się w jednym z dwóch stanów: 
może być albo "żywa" (włączona), albo "martwa" (wyłączona). Stany komórek zmieniają się w pewnych jednostkach czasu. 
Stan wszystkich komórek w pewnej jednostce czasu jest używany do obliczenia stanu wszystkich komórek w następnej jednostce. 
Po obliczeniu wszystkie komórki zmieniają swój stan dokładnie w tym samym momencie. Stan komórki zależy tylko od liczby jej żywych sąsiadów.

Reguły gry według Conwaya:

1. Martwa komórka, która ma dokładnie 3 żywych sąsiadów, staje się żywa w następnej jednostce czasu (rodzi się)
2. Żywa komórka z 2 albo 3 żywymi sąsiadami pozostaje nadal żywa; przy innej liczbie sąsiadów umiera (z "samotności" albo "zatłoczenia").

Napisz program symulujący stan gry w kolejnych chwilach czasu. 
Rozmiar planszy n jest wczytywany. Stan początkowy generowany jest losowo z udziałem "żywych" komórek 30%. Kolejne stany wyświetlają się po naciśnięciu Enter.
*/
#include <iostream>
#include <ctime>
#include <cstdlib>
using namespace std;

const int LEN = 100;

void printSpace(int space[LEN][LEN], int spaceSize)
{
    for (int x = 0; x < spaceSize; x++)
    {
        for (int y = 0; y < spaceSize; y++)
        {
            if(space[x][y] == 1)
            {
                cout << "# ";
            }else{
                cout << ". ";
            }
        }
        cout << endl;
    }    
}

void initSpace(int space[LEN][LEN], int spaceSize)
{
    srand(time(NULL));
    int aliveCells = spaceSize * spaceSize * 0.3; // 30% of the space is alive
    while (aliveCells > 0)
    {
        int i = rand() % spaceSize;
        int j = rand() % spaceSize;
        if (space[i][j] == 0)
        {
            space[i][j] = 1;
            aliveCells--;
        }
    }    
}

int countAliveNeighbors(int space[LEN][LEN], int spaceSize, int i, int j)
{
    int count = 0;
    for (int x = i-1; x <= i+1; x++)
    {
        for (int y = j-1; y <= j+1; y++)
        {
            if (x >= 0 && x < spaceSize && y >= 0 && y < spaceSize)
            {
                if (x != i || y != j)
                {
                    count += space[x][y];
                }
            }
        }
    }
    return count;
}


void updateSpace(int space[LEN][LEN], int spaceSize)
{
    int newSpace[LEN][LEN] = {0};
    for (int i = 0; i < spaceSize; i++)
    {
        for (int j = 0; j < spaceSize; j++)
        {
            int aliveNeighbors = countAliveNeighbors(space, spaceSize, i, j);
            if (newSpace[i][j] == 1)
            {
                if (aliveNeighbors == 2 || aliveNeighbors == 3) 
                {
                    newSpace[i][j] = 1;
                }else{
                    newSpace[i][j] = 0;
                }
            }else{
                if (aliveNeighbors == 3)
                {
                    newSpace[i][j] = 1;
                }else{
                    newSpace[i][j] = 0;
                }
            }
        }
    }
    for (int i = 0; i < spaceSize; i++)
    {
        for (int j = 0; j < spaceSize; j++)
        {
            space[i][j] = newSpace[i][j];
        }
    }
}

int main()
{
    int spaceSize;
    cout << "Enter the size of space: ";
    cin >> spaceSize;

    int space[LEN][LEN] = {0};
    initSpace(space, spaceSize);

    char c;
    do{
        system("clear");
        printSpace(space, spaceSize);
        updateSpace(space, spaceSize);
        cout << "Press Enter to continue, or 'q' to quit: ";
        cin.get(c);
    } while (c != 'q');


    return 0;
}