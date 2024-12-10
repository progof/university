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
