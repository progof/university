#include <stdio.h>
#include <gsl/gsl_sf_bessel.h>

int main(void)
{
    double x = 5.0;
    double y_J0 = gsl_sf_bessel_J0(x);
    double y_ieee = gsl_ieee_printf_double(x);

    printf("J0 (%g) = %.18e\n", x, y_J0);
    printf("IEEE (%g) = %s\n", x, y_ieee);
    return 0;
}