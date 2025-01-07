#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>

double monte_carlo_pi(int num_points)
{
    int inside_circle = 0;

    for (int i = 0; i < num_points; i++)
    {
        double x = (double)rand() / RAND_MAX * 2.0 - 1.0;
        double y = (double)rand() / RAND_MAX * 2.0 - 1.0;

        if (x * x + y * y <= 1.0)
        {
            inside_circle++;
        }
    }

    return 4.0 * (double)inside_circle / num_points;
}

int main()
{
    int num_points = 10000000; // Liczba losowań
    srand(time(NULL));         // Inicjalizacja generatora liczb losowych

    clock_t start = clock();
    double pi_estimate = monte_carlo_pi(num_points);
    clock_t end = clock();

    printf("Szacowana wartość π: %.8f\n", pi_estimate);
    printf("Czas wykonania: %.4f sekund\n", (double)(end - start) / CLOCKS_PER_SEC);

    return 0;
}
