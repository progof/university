#include <stdio.h>
#include <math.h>
#include <gsl/gsl_rng.h>
#include <gsl/gsl_monte.h>
#include <gsl/gsl_monte_plain.h>
#include <gsl/gsl_monte_miser.h>
#include <gsl/gsl_monte_vegas.h>

// Funkcja, której całkę obliczamy
double f(double *x, size_t dim, void *params)
{
    return x[0] * x[0] + x[0] + 1; // f(x) = x^2 + x + 1
}

int main()
{
    // Parametry Monte Carlo
    double xl[1] = {0.0}; // Dolna granica
    double xu[1] = {1.0}; // Górna granica
    size_t dim = 1;

    gsl_monte_function G = {&f, dim, NULL};

    gsl_rng *rng = gsl_rng_alloc(gsl_rng_default);
    gsl_monte_plain_state *s_plain = gsl_monte_plain_alloc(dim);
    gsl_monte_miser_state *s_miser = gsl_monte_miser_alloc(dim);
    gsl_monte_vegas_state *s_vegas = gsl_monte_vegas_alloc(dim);

    double res, err;

    // Otwórz plik do zapisu wyników
    FILE *output = fopen("results.dat", "w");
    if (!output)
    {
        perror("Nie można otworzyć pliku results.dat");
        return 1;
    }

    fprintf(output, "# num_samples plain_error miser_error vegas_error\n");

    for (int num_samples = 1000; num_samples <= 1000000; num_samples *= 10)
    {
        // Metoda PLAIN
        gsl_monte_plain_integrate(&G, xl, xu, dim, num_samples, rng, s_plain, &res, &err);
        double plain_error = err;

        // Metoda MISER
        gsl_monte_miser_integrate(&G, xl, xu, dim, num_samples, rng, s_miser, &res, &err);
        double miser_error = err;

        // Metoda VEGAS
        gsl_monte_vegas_integrate(&G, xl, xu, dim, num_samples, rng, s_vegas, &res, &err);
        double vegas_error = err;

        // Zapisz wyniki do pliku
        fprintf(output, "%d %f %f %f\n", num_samples, plain_error, miser_error, vegas_error);
    }

    fclose(output);

    // Zwolnienie pamięci
    gsl_monte_plain_free(s_plain);
    gsl_monte_miser_free(s_miser);
    gsl_monte_vegas_free(s_vegas);
    gsl_rng_free(rng);

    return 0;
}
