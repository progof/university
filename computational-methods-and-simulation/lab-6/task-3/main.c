#include <stdio.h>
#include <math.h>

// Funkcja kwadratowa i jej pochodna
double quadratic(double x)
{
    return x * x - 2 * x + 1; // f(x) = x^2 - 2x + 1
}

double derivative(double x)
{
    return 2 * x - 2; // f'(x) = 2x - 2
}

// Metoda Newtona
void newton_method(double (*f)(double), double (*f_prime)(double), double x0, double tol)
{
    double x = x0;
    int iter = 0;
    while (fabs(f(x)) > tol)
    {
        x = x - f(x) / f_prime(x);
        iter++;
        printf("Newton Method Iter %d: x = %.7f, f(x) = %.7f\n", iter, x, f(x));
    }
    printf("Newton Method converged to x = %.7f after %d iterations\n", x, iter);
}

// Uproszczona metoda Newtona
void simplified_newton_method(double (*f)(double), double x0, double tol)
{
    double h = 1e-5; // Mały krok do obliczenia przybliżonej pochodnej
    double x = x0;
    int iter = 0;
    while (fabs(f(x)) > tol)
    {
        double f_prime = (f(x + h) - f(x)) / h; // Przybliżona pochodna
        x = x - f(x) / f_prime;
        iter++;
        printf("Simplified Newton Method Iter %d: x = %.7f, f(x) = %.7f\n", iter, x, f(x));
    }
    printf("Simplified Newton Method converged to x = %.7f after %d iterations\n", x, iter);
}

// Metoda Steffensona
void steffenson_method(double (*f)(double), double x0, double tol)
{
    double x = x0;
    int iter = 0;
    while (fabs(f(x)) > tol)
    {
        double f_x = f(x);
        double f_x_plus = f(x + f_x);
        x = x - (f_x * f_x) / (f_x_plus - f_x);
        iter++;
        printf("Steffenson Method Iter %d: x = %.7f, f(x) = %.7f\n", iter, x, f(x));
    }
    printf("Steffenson Method converged to x = %.7f after %d iterations\n", x, iter);
}

int main()
{
    double x0 = 2.0;   // Początkowy punkt
    double tol = 1e-6; // Tolerancja

    printf("Using Newton's Method:\n");
    newton_method(quadratic, derivative, x0, tol);

    printf("\nUsing Simplified Newton's Method:\n");
    simplified_newton_method(quadratic, x0, tol);

    printf("\nUsing Steffenson's Method:\n");
    steffenson_method(quadratic, x0, tol);

    return 0;
}
