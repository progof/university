#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

#define N 256

int main()
{
    float data[N];
    FILE *file = fopen("signal_with_noise.dat", "w");

    if (file == NULL)
    {
        perror("Nie można otworzyć pliku do zapisu");
        return 1;
    }

    srand(time(NULL)); // Inicjalizacja generatora liczb losowych

    for (int i = 0; i < N; i++)
    {
        data[i] = cos(4 * M_PI * i / N) + ((float)rand() / RAND_MAX) / 8.0;
        fprintf(file, "%d %.6f\n", i, data[i]);
    }

    fclose(file);
    printf("Dane zapisane do pliku 'signal_with_noise.dat'.\n");

    return 0;
}
