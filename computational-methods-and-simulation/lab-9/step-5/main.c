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
