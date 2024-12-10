#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <gsl/gsl_errno.h>
#include <gsl/gsl_fft_real.h>

#define Pi 3.1415926535
#define N 256

// Funkcja wczytująca dane z pliku
void read_data(double data[N])
{
    FILE *file = fopen("../task-1/signal_data.txt", "r");
    if (!file)
    {
        perror("Nie mogę otworzyć pliku");
        exit(1);
    }

    for (int i = 0; i < N; i++)
    {
        fscanf(file, "%*d %lf", &data[i]);
    }

    fclose(file);
}

int main(void)
{
    double data[N]; // Tablica na dane
    FILE *output1 = fopen("output_signal.txt", "w");
    FILE *output2 = fopen("output_fft.txt", "w");

    // Wczytanie danych
    read_data(data);

    // Zapisanie danych przed transformacją
    for (int i = 0; i < N; i++)
    {
        fprintf(output1, "%d\t%f\n", i, data[i]);
    }

    // Transformaty Fouriera (Real FFT)
    gsl_fft_real_radix2_transform(data, 1, N);

    // Zapisanie wyników po transformacji
    for (int i = 0; i < N; i++)
    {
        fprintf(output2, "%d\t%f\n", i, data[i]);
    }

    fclose(output1);
    fclose(output2);

    return 0;
}
