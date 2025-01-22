#include <stdio.h>
#include <stdlib.h>
#include <time.h>

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
void bucket_sort(int *arr, int n, int num_buckets)
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

    // Sortowanie każdego kubełka i łączenie wyników
    int idx = 0;
    for (int i = 0; i < num_buckets; i++)
    {
        insertion_sort(buckets[i], bucket_sizes[i]);
        for (int j = 0; j < bucket_sizes[i]; j++)
        {
            arr[idx++] = buckets[i][j];
        }
    }

    // Zwolnienie pamięci
    for (int i = 0; i < num_buckets; i++)
    {
        free(buckets[i]);
    }
    free(buckets);
    free(bucket_sizes);
}

int main()
{
    int n = 100;          // Rozmiar tablicy
    int num_buckets = 10; // Liczba kubełków
    int *array = malloc(n * sizeof(int));

    // Inicjalizacja tablicy losowymi wartościami
    srand(time(NULL));
    for (int i = 0; i < n; i++)
    {
        array[i] = rand() % 1000;
    }

    // Pomiar czasu rozpoczęcia
    clock_t start_time = clock();

    // Sortowanie kubełkowe
    bucket_sort(array, n, num_buckets);

    // Pomiar czasu zakończenia
    clock_t end_time = clock();

    // Obliczanie czasu wykonania
    double time_taken = ((double)(end_time - start_time)) / CLOCKS_PER_SEC;

    // Wyświetlanie wyników
    printf("Posortowana tablica:\n");
    for (int i = 0; i < n; i++)
    {
        printf("%d ", array[i]);
    }
    printf("\n");

    // Wyświetlanie czasu wykonania
    printf("Czas wykonania sortowania: %f sekund\n", time_taken);

    free(array);
    return 0;
}
