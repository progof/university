// #include <stdio.h>
// #include <gsl/gsl_errno.h>
// #include <gsl/gsl_math.h>
// #include <gsl/gsl_min.h>
// #include <math.h>
// #include <time.h>

// // Funkcja, której minimum chcemy znaleźć
// double fn1(double x, void *params)
// {
//     return cos(x) + 1.0;
// }

// // Funkcja do zmodyfikowanej metody Brenta (quad_golden)
// double fn2(double x, void *params)
// {
//     return exp(-x) - sin(x) + sqrt(x);
// }

// void compare_methods(const gsl_min_fminimizer_type *T, gsl_function *F, double m, double a, double b, int max_iter, const char *method_name)
// {
//     int status, iter = 0;
//     gsl_min_fminimizer *s = gsl_min_fminimizer_alloc(T);

//     gsl_min_fminimizer_set(s, F, m, a, b);

//     clock_t start_time = clock();

//     printf("using %s method\n", method_name);
//     printf("%5s [%9s, %9s] %9s %10s %9s\n", "iter", "lower", "upper", "min", "err", "err(est)");

//     printf("%5d [%.7f, %.7f] %.7f %+.7f %.7f\n", iter, a, b, m, m - M_PI, b - a);

//     do
//     {
//         iter++;
//         status = gsl_min_fminimizer_iterate(s);

//         m = gsl_min_fminimizer_x_minimum(s);
//         a = gsl_min_fminimizer_x_lower(s);
//         b = gsl_min_fminimizer_x_upper(s);

//         status = gsl_min_test_interval(a, b, 0.001, 0.0);

//         if (status == GSL_SUCCESS)
//             printf("Converged:\n");

//         printf("%5d [%.7f, %.7f] %.7f %+.7f %.7f\n", iter, a, b, m, m - M_PI, b - a);
//     } while (status == GSL_CONTINUE && iter < max_iter);

//     clock_t end_time = clock();
//     double cpu_time_used = ((double)(end_time - start_time)) / CLOCKS_PER_SEC;
//     printf("Czas wykonania (%s): %f sekundy\n", method_name, cpu_time_used);

//     gsl_min_fminimizer_free(s);
// }

// int main(void)
// {
//     int max_iter = 100;
//     double m = 2.0, m_expected = M_PI;
//     double a = 0.0, b = 6.0;
//     gsl_function F;

//     F.function = &fn1; // Dla funkcji cos(x) + 1.0
//     F.params = 0;

//     // Porównanie metody złotego podziału
//     const gsl_min_fminimizer_type *T = gsl_min_fminimizer_goldensection;
//     compare_methods(T, &F, m, a, b, max_iter, "golden section");

//     // Porównanie zmodyfikowanej metody Brenta
//     T = gsl_min_fminimizer_brent;
//     compare_methods(T, &F, m, a, b, max_iter, "Brent");

//     return 0;
// }

/***/
/***/

// #include <stdio.h>
// #include <gsl/gsl_errno.h>
// #include <gsl/gsl_math.h>
// #include <gsl/gsl_min.h>
// #include <math.h>
// #include <time.h>

// // Funkcja, której minimum chcemy znaleźć
// double fn2(double x, void *params)
// {
//     return x * x - 2 * x + 1; // Prosta funkcja kwadratowa
// }

// void compare_methods(const gsl_min_fminimizer_type *T, gsl_function *F, double m, double a, double b, int max_iter, const char *method_name)
// {
//     int status, iter = 0;
//     gsl_min_fminimizer *s = gsl_min_fminimizer_alloc(T);

//     gsl_min_fminimizer_set(s, F, m, a, b);

//     clock_t start_time = clock();

//     printf("using %s method\n", method_name);
//     printf("%5s [%9s, %9s] %9s %10s %9s\n", "iter", "lower", "upper", "min", "err", "err(est)");

//     // Debugowanie: sprawdzanie wartości funkcji na końcach przedziału
//     printf("f(a) = %f, f(b) = %f\n", fn2(a, NULL), fn2(b, NULL));

//     printf("%5d [%.7f, %.7f] %.7f %+.7f %.7f\n", iter, a, b, m, m - M_PI, b - a);

//     do
//     {
//         iter++;
//         status = gsl_min_fminimizer_iterate(s);

//         m = gsl_min_fminimizer_x_minimum(s);
//         a = gsl_min_fminimizer_x_lower(s);
//         b = gsl_min_fminimizer_x_upper(s);

//         status = gsl_min_test_interval(a, b, 0.001, 0.0);

//         if (status == GSL_SUCCESS)
//         {
//             printf("Converged:\n");
//             break; // Zakończ pętlę, jeśli zakończyło się sukcesem
//         }

//         printf("%5d [%.7f, %.7f] %.7f %+.7f %.7f\n", iter, a, b, m, m - M_PI, b - a);
//     } while (status == GSL_CONTINUE && iter < max_iter);

//     clock_t end_time = clock();
//     double cpu_time_used = ((double)(end_time - start_time)) / CLOCKS_PER_SEC;
//     printf("Czas wykonania (%s): %f sekundy\n", method_name, cpu_time_used);

//     gsl_min_fminimizer_free(s);
// }

// int main(void)
// {
//     int max_iter = 100;
//     double m = 1.0; // Ustawienie początkowego minimum blisko oczekiwanego minimum
//     double a = 0.0;
//     double b = 4.0; // Zakres przedziału

//     gsl_function F;
//     F.function = &fn2;
//     F.params = 0;

//     // Porównanie metody złotego podziału
//     const gsl_min_fminimizer_type *T = gsl_min_fminimizer_goldensection;
//     compare_methods(T, &F, m, a, b, max_iter, "golden section");

//     // Porównanie zmodyfikowanej metody Brenta
//     T = gsl_min_fminimizer_brent;
//     compare_methods(T, &F, m, a, b, max_iter, "Brent");

//     return 0;
// }

#include <stdio.h>
#include <gsl/gsl_errno.h>
#include <gsl/gsl_math.h>
#include <gsl/gsl_min.h>
#include <math.h>
#include <time.h>

// Funkcja, której minimum chcemy znaleźć
double fn2(double x, void *params)
{
    return exp(-x) - sin(x) + sqrt(x);
}

void compare_methods(const gsl_min_fminimizer_type *T, gsl_function *F, double m, double a, double b, int max_iter, const char *method_name)
{
    int status, iter = 0;
    gsl_min_fminimizer *s = gsl_min_fminimizer_alloc(T);

    gsl_min_fminimizer_set(s, F, m, a, b);

    clock_t start_time = clock();

    printf("using %s method\n", method_name);
    printf("%5s [%9s, %9s] %9s %10s %9s\n", "iter", "lower", "upper", "min", "err", "err(est)");

    // Debugowanie: sprawdzanie wartości funkcji na końcach przedziału
    printf("f(a) = %f, f(b) = %f\n", fn2(a, NULL), fn2(b, NULL));

    printf("%5d [%.7f, %.7f] %.7f %+.7f %.7f\n", iter, a, b, m, m - M_PI, b - a);

    do
    {
        iter++;
        status = gsl_min_fminimizer_iterate(s);

        m = gsl_min_fminimizer_x_minimum(s);
        a = gsl_min_fminimizer_x_lower(s);
        b = gsl_min_fminimizer_x_upper(s);

        status = gsl_min_test_interval(a, b, 0.001, 0.0);

        if (status == GSL_SUCCESS)
            printf("Converged:\n");

        printf("%5d [%.7f, %.7f] %.7f %+.7f %.7f\n", iter, a, b, m, m - M_PI, b - a);
    } while (status == GSL_CONTINUE && iter < max_iter);

    clock_t end_time = clock();
    double cpu_time_used = ((double)(end_time - start_time)) / CLOCKS_PER_SEC;
    printf("Czas wykonania (%s): %f sekundy\n", method_name, cpu_time_used);

    gsl_min_fminimizer_free(s);
}

int main(void)
{
    int max_iter = 100;
    double m = 2.0, m_expected = M_PI;
    double a = M_PI / 2; // Początek przedziału (π/2)
    double b = 4 * M_PI; // Koniec przedziału (4π)
    gsl_function F;

    F.function = &fn2; // Dla funkcji e^(-x) - sin(x) + sqrt(x)
    F.params = 0;

    // Porównanie metody złotego podziału
    const gsl_min_fminimizer_type *T = gsl_min_fminimizer_goldensection;
    compare_methods(T, &F, m, a, b, max_iter, "golden section");

    // Porównanie zmodyfikowanej metody Brenta
    T = gsl_min_fminimizer_brent;
    compare_methods(T, &F, m, a, b, max_iter, "Brent");

    return 0;
}
