// demo_fn.h
#ifndef DEMO_FN_H
#define DEMO_FN_H

struct quadratic_params
{
  double a;
  double b;
  double c;
};

double quadratic(double x, void *params); // Deklaracja funkcji

#endif // DEMO_FN_H
