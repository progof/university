import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import solve_ivp

# Parametry równania
mu = 1.0  # możesz zmieniać wartość mu, aby zobaczyć różne zachowania

# Układ równań różniczkowych
def vanderpol(t, y):
    u, v = y
    du_dt = v
    dv_dt = -u + mu * v * (1 - u**2)
    return [du_dt, dv_dt]

# Warunki początkowe
u0 = 2.0
v0 = 0.0
y0 = [u0, v0]

# Przedział czasu
t_span = (0, 50)
t_eval = np.linspace(*t_span, 1000)

# Rozwiązanie równania
solution = solve_ivp(vanderpol, t_span, y0, t_eval=t_eval, method='RK45')

# Wykresy wyników
plt.figure(figsize=(12, 6))
plt.plot(solution.t, solution.y[0], label='u(t)')
plt.plot(solution.t, solution.y[1], label='v(t)')
plt.xlabel('Czas t')
plt.ylabel('Wartości u(t) i v(t)')
plt.title("Równanie van der Pola")
plt.legend()
plt.grid()
plt.show()
