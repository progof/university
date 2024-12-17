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
#include <math.h>
#include <gsl/gsl_errno.h>
#include <gsl/gsl_math.h>
#include <gsl/gsl_min.h>
#include <gsl/gsl_min.h>

double fn1(double x, void *params)
{
    return exp(-x) - sin(x) + sqrt(x); // Funkcja: e^(-x) - sin(x) + sqrt(x)
}

void check_interval(double a, double b, double m, gsl_function *F)
{
    // Diagnostyka: sprawdzamy wartości funkcji na krańcach przedziału
    double f_a = GSL_FN_EVAL(F, a);
    double f_b = GSL_FN_EVAL(F, b);
    double f_m = GSL_FN_EVAL(F, m);

    printf("\nDiagnostyka przedziału:\n");
    printf("f(a = %.5f) = %.5f\n", a, f_a);
    printf("f(b = %.5f) = %.5f\n", b, f_b);
    printf("f(m = %.5f) = %.5f\n", m, f_m);

    // Diagnostyka poprawności przedziału
    if (f_a > f_b)
    {
        printf("Uwaga: f(a) > f(b), rozważ zmianę przedziału.\n");
    }
    if (f_a > f_m)
    {
        printf("Uwaga: f(a) > f(m), rozważ zmianę przedziału.\n");
    }
    if (f_b > f_m)
    {
        printf("Uwaga: f(b) > f(m), rozważ zmianę przedziału.\n");
    }

    if (f_a <= f_m || f_b <= f_m)
    {
        printf("Przedzial [%.5f, %.5f] zawiera minimum, kontynuujemy.\n", a, b);
    }
    else
    {
        printf("Przedział [%.5f, %.5f] może nie zawierać minimum w oczekiwanym zakresie.\n", a, b);
    }
}

int main(void)
{
    int status;
    int iter = 0, max_iter = 100;
    const gsl_min_fminimizer_type *T;
    gsl_min_fminimizer *s;

    double a = M_PI / 2.0;    // Początek przedziału: pi/2
    double b = 4 * M_PI;      // Koniec przedziału: 4*pi
    double m = (a + b) / 2.0; // Punkt startowy (środek przedziału)
    double m_expected = 2.0;  // Szacowane minimum

    gsl_function F;
    F.function = &fn1;
    F.params = NULL;

    int wybor;
    printf("Wybierz metode: 1 - Brent, 2 - Zloty podzial\n");
    scanf("%d", &wybor);

    // Wybór metody
    if (wybor == 1)
    {
        T = gsl_min_fminimizer_brent; // Metoda Brenta
    }
    else if (wybor == 2)
    {
        T = gsl_min_fminimizer_goldensection; // Metoda złotego podziału
    }
    else
    {
        printf("Nieprawidlowy wybor metody.\n");
        return 1;
    }

    // Diagnostyka przedziału
    check_interval(a, b, m, &F);

    // Inicjalizacja minimizatora
    s = gsl_min_fminimizer_alloc(T);
    gsl_min_fminimizer_set(s, &F, m, a, b);

    printf("\nUzywamy metody: %s\n", gsl_min_fminimizer_name(s));
    printf("%5s [%9s, %9s] %9s %10s %9s\n", "Iter", "Lower", "Upper", "Min", "Err", "Err(est)");
    printf("%5d [%.7f, %.7f] %.7f %+.7f %.7f\n", iter, a, b, m, m - m_expected, b - a);

    do
    {
        iter++;
        status = gsl_min_fminimizer_iterate(s);

        m = gsl_min_fminimizer_x_minimum(s);
        a = gsl_min_fminimizer_x_lower(s);
        b = gsl_min_fminimizer_x_upper(s);

        status = gsl_min_test_interval(a, b, 0.001, 0.0);
        if (status == GSL_SUCCESS)
            printf("Zbieznosc osiagnieta:\n");

        printf("%5d [%.7f, %.7f] %.7f %+.7f %.7f\n", iter, a, b, m, m - m_expected, b - a);
    } while (status == GSL_CONTINUE && iter < max_iter);

    gsl_min_fminimizer_free(s);
    return status;
}
