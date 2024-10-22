import numpy as np
import matplotlib.pyplot as plt
import csv

# Funkcja do obliczania wartości w oparciu o dany wzór
def calculate_sequence(formula, x0, n):
    x_values = [x0]
    for i in range(n):
        x_n = formula(x_values[i])
        x_values.append(x_n)
    return x_values

# Wzory
def formula1(x_n):
    return x_n + 3.0 * x_n * (1 - x_n)

def formula2(x_n):
    return 4.0 * x_n - 3.0 * x_n * x_n

# Parametry
x0 = 0.01
n = 49  # Liczba iteracji

# Obliczanie wartości dla różnych reprezentacji
float_values_formula1 = calculate_sequence(formula1, float(x0), n)
double_values_formula1 = calculate_sequence(lambda x: float(x), x0, n)  # Symulacja double

float_values_formula2 = calculate_sequence(formula2, float(x0), n)
double_values_formula2 = calculate_sequence(lambda x: float(x), x0, n)  # Symulacja double

# Zapis danych do pliku CSV
with open('results.csv', 'w', newline='') as csvfile:
    csv_writer = csv.writer(csvfile)
    # Nagłówki
    csv_writer.writerow(['n', 'float (Wzór 1)', 'double (Wzór 1)', 'float (Wzór 2)', 'double (Wzór 2)'])
    # Zapis danych
    for i in range(n + 1):
        csv_writer.writerow([i, float_values_formula1[i], double_values_formula1[i], float_values_formula2[i], double_values_formula2[i]])

print("Dane zostały zapisane do pliku results.csv")

# Generowanie wykresów
x = np.arange(n + 1)

plt.figure(figsize=(14, 6))

# Wykres dla Wzór 1
plt.subplot(1, 2, 1)
plt.plot(x, float_values_formula1, label='float (Wzór 1)', marker='o')
plt.plot(x, double_values_formula1, label='double (Wzór 1)', marker='x')
plt.title('Wzór 1: x_{n+1} = x_{n} + 3.0 * x_{n} * (1 - x_{n})')
plt.xlabel('n')
plt.ylabel('Wartość')
plt.legend()
plt.grid()

# Wykres dla Wzór 2
plt.subplot(1, 2, 2)
plt.plot(x, float_values_formula2, label='float (Wzór 2)', marker='o')
plt.plot(x, double_values_formula2, label='double (Wzór 2)', marker='x')
plt.title('Wzór 2: x_{n+1} = 4.0 * x_{n} - 3.0 * x_{n} * x_{n}')
plt.xlabel('n')
plt.ylabel('Wartość')
plt.legend()
plt.grid()

plt.tight_layout()
plt.savefig('results_plot.png')  # Zapis wykresu do pliku
plt.show()  # Wyświetlenie wykresu
