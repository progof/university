// #include <stdio.h>
// #include <stdlib.h>
// #include <math.h>
// #include <gsl/gsl_fft_complex.h>

// #define N 256          // Liczba punktów w sygnale
// #define THRESHOLD 50.0 // Próg dla wyzerowania elementów widma

// // Funkcja pomocnicza do wyzerowania elementów widma poniżej progu
// void zero_spectrum_if_small(double *spectrum, size_t num_points, double threshold)
// {
//     for (size_t i = 0; i < num_points; i++)
//     {
//         double re = spectrum[2 * i];     // Część rzeczywista
//         double im = spectrum[2 * i + 1]; // Część urojona
//         double magnitude = sqrt(re * re + im * im);
//         if (magnitude < threshold)
//         {
//             spectrum[2 * i] = 0.0;     // Zerujemy część rzeczywistą
//             spectrum[2 * i + 1] = 0.0; // Zerujemy część urojoną
//         }
//     }
// }

// int main()
// {
//     double data[2 * N]; // Tablica na dane zespolone
//     FILE *file;

//     // Wczytaj dane z pliku fft_output.dat
//     file = fopen("../task-4/fft_output.dat", "r");
//     if (file == NULL)
//     {
//         fprintf(stderr, "Nie udało się otworzyć pliku fft_output.dat\n");
//         return 1;
//     }

//     for (size_t i = 0; i < N; i++)
//     {
//         if (fscanf(file, "%lf", &data[2 * i]) != 1) // Wczytaj część rzeczywistą
//         {
//             fprintf(stderr, "Błąd odczytu danych z pliku\n");
//             fclose(file);
//             return 1;
//         }
//         data[2 * i + 1] = 0.0; // Ustaw część urojoną na 0
//     }
//     fclose(file);

//     // Wyzerowanie elementów widma poniżej progu
//     zero_spectrum_if_small(data, N, THRESHOLD);

//     // Zapisz zmodyfikowane widmo do pliku w formacie CSV
//     file = fopen("modified_fft_output.csv", "w");
//     if (file == NULL)
//     {
//         fprintf(stderr, "Nie udało się otworzyć pliku do zapisu.\n");
//         return 1;
//     }

//     // Zapisz dane w formacie CSV
//     for (size_t i = 0; i < N; i++)
//     {
//         fprintf(file, "%f,%f\n", data[2 * i], data[2 * i + 1]); // Część rzeczywista, część urojona
//     }
//     fclose(file);

//     // Przeprowadzenie odwrotnej transformaty Fouriera
//     gsl_fft_complex_radix2_inverse(data, 1, N);

//     // Zapisz oczyszczony sygnał do pliku w formacie CSV
//     file = fopen("cleaned_signal.csv", "w");
//     if (file == NULL)
//     {
//         fprintf(stderr, "Nie udało się otworzyć pliku do zapisu.\n");
//         return 1;
//     }

//     // Zapisz dane w formacie CSV
//     for (size_t i = 0; i < N; i++)
//     {
//         fprintf(file, "%f\n", data[2 * i]); // Zapisz część rzeczywistą sygnału czasowego
//     }
//     fclose(file);

//     return 0;
// }

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main()
{
    // Otwarcie pliku z transformatą Fouriera
    FILE *input_file = fopen("../task-4/output_fft.txt", "r");
    if (input_file == NULL)
    {
        fprintf(stderr, "Nie mogę otworzyć pliku wejściowego.\n");
        return 1;
    }

    // Otwarcie pliku do zapisu przetworzonych danych
    FILE *output_file = fopen("filtered_fft.txt", "w");
    if (output_file == NULL)
    {
        fprintf(stderr, "Nie mogę otworzyć pliku wyjściowego.\n");
        fclose(input_file);
        return 1;
    }

    int index;
    double value;

    // Czytanie danych z pliku i przetwarzanie
    while (fscanf(input_file, "%d %lf", &index, &value) == 2)
    {
        // Jeśli wartość bezwzględna jest większa lub równa 50, zapisujemy ją do pliku
        if (fabs(value) >= 50.0)
        {
            fprintf(output_file, "%d %lf\n", index, value);
        }
        else
        {
            // Jeśli wartość jest mniejsza niż 50, zapisujemy 0
            fprintf(output_file, "%d 0.000000\n", index);
        }
    }

    // Zamknięcie plików
    fclose(input_file);
    fclose(output_file);

    printf("Przetwarzanie zakończone. Przefiltrowane dane zapisano do 'filtered_fft.txt'.\n");

    return 0;
}
