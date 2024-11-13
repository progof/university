#include <stdio.h>
#include <math.h>
#include <gsl/gsl_chebyshev.h>
#include <sys/stat.h>

double f1(double x)
{
    return exp(x) * cos(0.5 * x * x);
}

double f2(double x)
{
    return 1.0 / (12.0 * x * x + 1.0);
}

double func_wrapper(double x, void *params)
{
    double (*f)(double) = params;
    return f(x);
}

void aproksymacja(double (*f)(double), double a, double b, int n, const char *filename)
{
    gsl_cheb_series *cheb = gsl_cheb_alloc(n);

    gsl_function F;
    F.function = &func_wrapper;
    F.params = f;

    gsl_cheb_init(cheb, &F, a, b);

    FILE *fp = fopen(filename, "w");
    if (!fp)
    {
        fprintf(stderr, "Error opening file: %s\n", filename);
        gsl_cheb_free(cheb);
        return;
    }

    double x, y, y_cheb;
    for (x = a; x <= b; x += 0.01)
    {
        y = f(x);
        y_cheb = gsl_cheb_eval(cheb, x);
        fprintf(fp, "%g %g %g\n", x, y, y_cheb);
    }

    fclose(fp);
    gsl_cheb_free(cheb);
}

int main()
{
    const char *dirname = "data";
    mkdir(dirname, 0777);

    aproksymacja(f1, 0, 3, 3, "data/f1_n3.dat");
    aproksymacja(f1, 0, 3, 10, "data/f1_n10.dat");
    aproksymacja(f1, 0, 3, 40, "data/f1_n40.dat");

    aproksymacja(f2, -2, 2, 3, "data/f2_n3.dat");
    aproksymacja(f2, -2, 2, 10, "data/f2_n10.dat");
    aproksymacja(f2, -2, 2, 40, "data/f2_n40.dat");

    return 0;
}
