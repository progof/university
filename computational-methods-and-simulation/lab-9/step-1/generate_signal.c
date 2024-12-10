#include <stdio.h>
#include <math.h>

#define N 256
#define PI 3.141592653589793

int main()
{
    double data[N];
    FILE *file = fopen("signal_data.txt", "w");

    if (!file)
    {
        perror("Nie można otworzyć pliku");
        return 1;
    }

    // Generowanie danych
    for (int i = 0; i < N; i++)
    {
        data[i] = cos(4 * PI * i / N) +
                  cos(16 * PI * i / N) / 5 +
                  cos(32 * PI * i / N) / 8 +
                  cos(128 * PI * i / N) / 16;

        // Zapis danych do pliku
        fprintf(file, "%d\t%f\n", i, data[i]);
    }

    fclose(file);
    printf("Dane zostały zapisane do pliku signal_data.txt.\n");
    return 0;
}
