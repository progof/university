// #include <stdio.h>
// #include <stdlib.h>
// #include <math.h>
// #include <gsl/gsl_fft_real.h>

// #define N 1024 // Liczba próbek
// #define PI 3.14159265358979323846

// // Funkcja generująca sygnał cosinus z szumem
// void generate_signal(double *data)
// {
//     for (int i = 0; i < N; i++)
//     {
//         data[i] = cos(4 * PI * i / N) + ((double)rand()) / RAND_MAX / 8.0; // Sygnał cosinus + szum
//     }
// }

// // Funkcja obliczająca transformatę Fouriera i zapisująca wynik do pliku
// void compute_fft(double *data)
// {
//     gsl_fft_real_workspace *work = gsl_fft_real_workspace_alloc(N);
//     gsl_fft_real_wavetable *wavetable = gsl_fft_real_wavetable_alloc(N);

//     // Wykonanie FFT na danych
//     gsl_fft_real_transform(data, 1, N, wavetable, work);

//     // Zapisanie wyników FFT do pliku
//     FILE *file = fopen("fft_output.dat", "w");
//     for (int i = 0; i < N / 2; i++)
//     {                                                     // Tylko pierwsza połowa wyników (częstotliwości pozytywne)
//         fprintf(file, "%f %f\n", (double)i / N, data[i]); // Częstotliwość i amplituda
//     }
//     fclose(file);

//     // Zwolnienie pamięci
//     gsl_fft_real_workspace_free(work);
//     gsl_fft_real_wavetable_free(wavetable);
// }

// int main()
// {
//     double data[N];
//     generate_signal(data); // Generowanie sygnału
//     compute_fft(data);     // Obliczanie FFT i zapisywanie wyników

//     printf("FFT obliczone i zapisane do fft_output.dat\n");
//     return 0;
// }

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define MAX_SAMPLES 1024 // Maksymalna liczba próbek sygnału

// Struktura do przechowywania sygnału
typedef struct
{
    double time;
    double amplitude;
} Signal;

// Funkcja do obliczania transformaty Fouriera
void calculate_fft(Signal *signal, int n, double *fft_real, double *fft_imag)
{
    for (int k = 0; k < n; k++)
    {
        fft_real[k] = 0;
        fft_imag[k] = 0;
        for (int t = 0; t < n; t++)
        {
            double angle = 2 * M_PI * k * t / n;
            fft_real[k] += signal[t].amplitude * cos(angle);
            fft_imag[k] -= signal[t].amplitude * sin(angle);
        }
    }
}

// Funkcja do wczytywania sygnału z pliku
int load_signal(const char *filename, Signal *signal)
{
    FILE *file = fopen(filename, "r");
    if (!file)
    {
        perror("Nie udało się otworzyć pliku");
        return -1;
    }

    int i = 0;
    while (fscanf(file, "%lf %lf", &signal[i].time, &signal[i].amplitude) == 2)
    {
        i++;
        if (i >= MAX_SAMPLES)
            break; // Ograniczenie liczby próbek
    }

    fclose(file);
    return i; // Zwraca liczbę próbek
}

// Funkcja do zapisywania FFT do pliku
void save_fft(const char *filename, double *fft_real, double *fft_imag, int n)
{
    FILE *file = fopen(filename, "w");
    if (!file)
    {
        perror("Nie udało się otworzyć pliku");
        return;
    }

    for (int i = 0; i < n; i++)
    {
        double magnitude = sqrt(fft_real[i] * fft_real[i] + fft_imag[i] * fft_imag[i]);
        fprintf(file, "%d %lf\n", i, magnitude); // Zapisujemy numer częstotliwości i amplitudę
    }

    fclose(file);
}

int main()
{
    Signal signal[MAX_SAMPLES];
    int n = load_signal("../task-2/output_signal.txt", signal);

    if (n == -1)
    {
        return 1; // Błąd wczytywania sygnału
    }

    double fft_real[MAX_SAMPLES];
    double fft_imag[MAX_SAMPLES];

    // Obliczamy transformację Fouriera
    calculate_fft(signal, n, fft_real, fft_imag);

    // Zapisujemy wyniki FFT do pliku
    save_fft("output_fft.txt", fft_real, fft_imag, n);

    printf("Obliczono FFT i zapisano do pliku output_fft.txt\n");
    return 0;
}
