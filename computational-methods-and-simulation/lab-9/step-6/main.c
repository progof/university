#include <stdio.h>
#include <stdlib.h>
#include <gsl/gsl_fft_complex.h>

#define N 256 // liczba punktów w FFT

int main()
{
    // Załaduj dane z pliku
    FILE *file = fopen("../task-5/filtered_fft.txt", "r");
    if (file == NULL)
    {
        printf("Nie można otworzyć pliku.\n");
        return 1;
    }

    double data[N * 2]; // Dane zespolone (część rzeczywista, część urojona)
    int i = 0;
    while (fscanf(file, "%lf %lf", &data[i * 2], &data[i * 2 + 1]) == 2 && i < N)
    {
        i++;
    }
    fclose(file);

    // Przeprowadzenie odwrotnej transformaty Fouriera
    gsl_fft_complex_radix2_inverse(data, 1, N);

    // Normalizacja wyników
    for (int i = 0; i < N; i++)
    {
        data[i * 2] /= N;     // Część rzeczywista
        data[i * 2 + 1] /= N; // Część urojona
    }

    // Zapis wyników do pliku
    FILE *output_file = fopen("ifft_output.txt", "w");
    if (output_file == NULL)
    {
        printf("Nie można otworzyć pliku do zapisu.\n");
        return 1;
    }

    // Wydrukowanie wyników do pliku
    for (int i = 0; i < N; i++)
    {
        fprintf(output_file, "%d: %lf %lfi\n", i, data[i * 2], data[i * 2 + 1]);
    }

    fclose(output_file);
    printf("Wyniki zapisane do pliku ifft_output.txt\n");

    return 0;
}
