#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <mpi.h>

// Funkcja sortująca kubełek
void insertion_sort(int *arr, int n)
{
    for (int i = 1; i < n; i++)
    {
        int key = arr[i];
        int j = i - 1;
        while (j >= 0 && arr[j] > key)
        {
            arr[j + 1] = arr[j];
            j--;
        }
        arr[j + 1] = key;
    }
}

// Funkcja sortowania kubełkowego
void bucket_sort(int *arr, int n, int num_buckets, int rank, int size)
{
    int min_val = arr[0], max_val = arr[0];

    // Znalezienie zakresu danych
    for (int i = 1; i < n; i++)
    {
        if (arr[i] < min_val)
            min_val = arr[i];
        if (arr[i] > max_val)
            max_val = arr[i];
    }

    int range = (max_val - min_val) / num_buckets + 1;

    // Tworzenie kubełków
    int **buckets = malloc(num_buckets * sizeof(int *));
    int *bucket_sizes = calloc(num_buckets, sizeof(int));

    for (int i = 0; i < num_buckets; i++)
    {
        buckets[i] = malloc(n * sizeof(int));
    }

    // Przydzielanie elementów do odpowiednich kubełków
    for (int i = 0; i < n; i++)
    {
        int index = (arr[i] - min_val) / range;
        buckets[index][bucket_sizes[index]++] = arr[i];
    }

    // Rozpoczęcie równoległego sortowania kubełków
    int local_size = bucket_sizes[rank] / size;
    int *local_bucket = malloc(local_size * sizeof(int));

    // Zrównoleglenie: każdy proces sortuje swój fragment
    insertion_sort(local_bucket, local_size);

    // Łączenie wyników po posortowaniu
    for (int i = 0; i < num_buckets; i++)
    {
        free(buckets[i]);
    }
    free(buckets);
    free(bucket_sizes);
    free(local_bucket);
}

int main(int argc, char **argv)
{
    MPI_Init(&argc, &argv);

    int n = 100;          // Rozmiar tablicy
    int num_buckets = 10; // Liczba kubełków
    int rank, size;
    int *array = malloc(n * sizeof(int));

    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    // Inicjalizacja tablicy losowymi wartościami (tylko proces 0)
    if (rank == 0)
    {
        srand(time(NULL));
        for (int i = 0; i < n; i++)
        {
            array[i] = rand() % 1000;
        }
    }

    // Rozpoczęcie pomiaru czasu
    double start = MPI_Wtime();

    // Rozpowszechnianie danych do wszystkich procesów
    MPI_Bcast(array, n, MPI_INT, 0, MPI_COMM_WORLD);

    // Sortowanie kubełkowe (zrównoleglone)
    bucket_sort(array, n, num_buckets, rank, size);

    // Zakończenie pomiaru czasu
    double end = MPI_Wtime();

    // Wyświetlanie wyników tylko w procesie 0
    if (rank == 0)
    {
        printf("Posortowana tablica:\n");
        for (int i = 0; i < n; i++)
        {
            printf("%d ", array[i]);
        }
        printf("\n");

        printf("Czas wykonania programu równoległego: %f sekund\n", end - start);
    }

    free(array);
    MPI_Finalize();

    return 0;
}