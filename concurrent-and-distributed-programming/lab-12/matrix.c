#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>

#define N 10 // rozmiar macierzy

// Funkcja do drukowania macierzy
void print_matrix(int matrix[N][N])
{
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < N; j++)
        {
            printf("%d ", matrix[i][j]);
        }
        printf("\n");
    }
}

int main(int argc, char *argv[])
{
    int rank, size;
    int A[N][N], B[N][N], C_local[N][N], C[N][N];
    double start_time, end_time, time_taken;

    // Inicjalizacja MPI
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    // Rozpoczęcie pomiaru czasu
    start_time = MPI_Wtime();

    // Inicjalizacja macierzy A i B przez proces 0
    if (rank == 0)
    {
        printf("Macierz A:\n");
        for (int i = 0; i < N; i++)
        {
            for (int j = 0; j < N; j++)
            {
                A[i][j] = i + j;
                printf("%d ", A[i][j]);
            }
            printf("\n");
        }

        printf("Macierz B:\n");
        for (int i = 0; i < N; i++)
        {
            for (int j = 0; j < N; j++)
            {
                B[i][j] = i - j;
                printf("%d ", B[i][j]);
            }
            printf("\n");
        }
    }

    // Zdefiniowanie pochodnego typu danych dla kolumny macierzy
    MPI_Datatype column_type;
    MPI_Type_vector(N, 1, N, MPI_INT, &column_type); // Typ dla kolumny
    MPI_Type_commit(&column_type);

    // Rozpocznij rozdzielanie danych: podziel macierz A na kolumny
    MPI_Scatter(&A, 1, column_type, &C_local, 1, column_type, 0, MPI_COMM_WORLD);
    MPI_Bcast(&B, N * N, MPI_INT, 0, MPI_COMM_WORLD); // Przesyłanie całej macierzy B

    // Ustalamy zakres wierszy dla każdego procesu
    int rows_per_process = N / size;
    int start_row = rank * rows_per_process;
    int end_row = (rank + 1) * rows_per_process;

    // Jeśli proces jest ostatni, bierze pozostałe wiersze
    if (rank == size - 1)
    {
        end_row = N;
    }

    // Każdy proces oblicza swoją część macierzy C
    for (int i = start_row; i < end_row; i++)
    {
        for (int j = 0; j < N; j++)
        {
            C_local[i][j] = 0;
            for (int k = 0; k < N; k++)
            {
                C_local[i][j] += A[i][k] * B[k][j];
            }
        }
    }

    // Debugowanie: Wyświetl część lokalną dla każdego procesu
    printf("Proces %d - C_local (wiersze %d-%d):\n", rank, start_row, end_row);
    for (int i = start_row; i < end_row; i++)
    {
        for (int j = 0; j < N; j++)
        {
            printf("%d ", C_local[i][j]);
        }
        printf("\n");
    }

    // Zbierz wyniki w procesie 0
    MPI_Gather(C_local[start_row], rows_per_process * N, MPI_INT, C, rows_per_process * N, MPI_INT, 0, MPI_COMM_WORLD);

    // Sprawdzanie połączenia danych w procesie 0
    if (rank == 0)
    {
        printf("Macierz C (wynik obliczeń):\n");
        print_matrix(C);
    }

    // Zakończenie pomiaru czasu
    end_time = MPI_Wtime();
    time_taken = end_time - start_time;

    // Wyświetlanie czasu wykonania
    if (rank == 0)
    {
        printf("Czas wykonania: %f sekund\n", time_taken);
    }

    // Zakończenie MPI
    MPI_Finalize();

    return 0;
}