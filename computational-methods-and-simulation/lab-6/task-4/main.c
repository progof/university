#include <stdio.h>
#include <math.h>
#include <time.h>
#include <stdlib.h>

// Funkcja f(x) = e^(-x) - sin(x)
double func(double x)
{
    return exp(-x) - sin(x);
}

// Pochodna funkcji f'(x) = -e^(-x) - cos(x)
double derivative(double x)
{
    return -exp(-x) - cos(x);
}

// Funkcja do obliczania błędu przybliżenia
double error(double x)
{
    return fabs(x - 2.0); // Pierwiastek analityczny równania
}

// Metoda Newtona
void newton_method(double (*f)(double), double (*f_prime)(double), double x0, double tol)
{
    double x = x0;
    int iter = 0;
    FILE *f_errors = fopen("newton_errors.txt", "w"); // Plik do zapisu błędów

    if (f_errors == NULL)
    {
        printf("Error opening file for errors.\n");
        return;
    }

    while (fabs(f(x)) > tol)
    {
        if (fabs(f_prime(x)) < 1e-12) // Unikamy dzielenia przez zero
        {
            printf("Derivative too close to zero, stopping Newton's method.\n");
            break;
        }

        x = x - f(x) / f_prime(x);
        iter++;

        double err = error(x);
        fprintf(f_errors, "%d %f\n", iter, err);
    }

    fclose(f_errors);
}

// Sprawdzanie zmiany znaku na granicach interwału
int check_sign_change(double (*f)(double), double a, double b)
{
    return f(a) * f(b) < 0;
}

// Metoda bisekcji
void bisection_method(double (*f)(double), double a, double b, double tol)
{
    double c;
    int iter = 0;
    FILE *f_errors = fopen("bisection_errors.txt", "w");

    if (!check_sign_change(f, a, b))
    {
        printf("Bisection Method: Function does not change sign on the given interval.\n");
        fclose(f_errors);
        return;
    }

    while ((b - a) / 2 > tol)
    {
        c = (a + b) / 2;
        if (f(c) == 0.0)
            break;
        else if (f(c) * f(a) < 0)
            b = c;
        else
            a = c;
        iter++;

        double err = error(c);
        fprintf(f_errors, "%d %f\n", iter, err);
    }

    fclose(f_errors);
}

// Funkcja do mierzenia czasu wykonania metody
void measure_time_newton(void (*method)(double (*)(double), double (*)(double), double, double), double (*f)(double), double (*f_prime)(double), double x0, double tol)
{
    clock_t start, end;
    start = clock();
    method(f, f_prime, x0, tol);
    end = clock();
    double time_taken = ((double)(end - start)) / CLOCKS_PER_SEC;
    printf("Newton Method Time: %.7f seconds\n", time_taken);
}

// Funkcja do mierzenia czasu wykonania metody bisekcji
void measure_time_bisection(void (*method)(double (*)(double), double, double, double), double (*f)(double), double a, double b, double tol)
{
    clock_t start, end;
    start = clock();
    method(f, a, b, tol);
    end = clock();
    double time_taken = ((double)(end - start)) / CLOCKS_PER_SEC;
    printf("Bisection Method Time: %.7f seconds\n", time_taken);
}

int main()
{
    double x0 = 2.0;         // Początkowa wartość dla metody Newtona
    double a = 0.5, b = 1.5; // Zmieniony interwał dla metody bisekcji
    double tol = 1e-6;       // Tolerancja

    printf("Running Newton Method...\n");
    measure_time_newton(newton_method, func, derivative, x0, tol); // Mierzymy czas metody Newtona

    printf("Running Bisection Method...\n");
    measure_time_bisection(bisection_method, func, a, b, tol); // Mierzymy czas metody bisekcji

    return 0;
}
