// #include <stdlib.h>
// #include <stdio.h>
// #include <math.h>
// #include <gsl/gsl_errno.h>
// #include <gsl/gsl_fft_real.h>
// #include <gsl/gsl_fft_halfcomplex.h>

// #define Pi 3.1415926535
// #define N 256 // Liczba próbek

// // Funkcja sygnału: suma cosinusów o różnych częstotliwościach
// double f(int i)
// {
//     double t = (double)i / N;                                // Normalizacja czasu
//     return cos(2 * Pi * 5 * t) + 0.5 * cos(2 * Pi * 20 * t); // Przykładowy sygnał
// }

// int main(void)
// {
//     int i;
//     double data[N]; // Tablica danych wejściowych
//     FILE *output_signal = fopen("signal_data.txt", "w");
//     FILE *output_spectrum = fopen("spectrum_data.txt", "w");

//     if (!output_signal || !output_spectrum)
//     {
//         fprintf(stderr, "Błąd: Nie można otworzyć plików wyjściowych.\n");
//         return EXIT_FAILURE;
//     }

//     // Generowanie sygnału i zapis do pliku
//     for (i = 0; i < N; i++)
//     {
//         data[i] = f(i);
//         fprintf(output_signal, "%d\t%f\n", i, data[i]);
//     }
//     fclose(output_signal);

//     // Transformacja Fouriera
//     gsl_fft_real_radix2_transform(data, 1, N);

//     // Obliczanie modułu wartości widma i zapis do pliku
//     for (i = 0; i < N / 2; i++)
//     {                                               // N/2, bo widmo jest symetryczne
//         double frequency = (double)i / N;           // Normalizacja częstotliwości
//         double amplitude = sqrt(data[i] * data[i]); // Moduł wartości widma
//         fprintf(output_spectrum, "%f\t%f\n", frequency, amplitude);
//     }
//     fclose(output_spectrum);

//     printf("Dane zapisano do plików 'signal_data.txt' i 'spectrum_data.txt'.\n");
//     return 0;
// }

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
