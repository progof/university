import matplotlib.pyplot as plt
import numpy as np

# Dane z wyników zadania
num_samples = [1000, 10000, 100000, 1000000]
plain_error = [0.018233, 0.005792, 0.001837, 0.000582]
miser_error = [0.007041, 0.000399, 0.000020, 0.000001]
vegas_error = [0.000016, 0.000001, 0.000000, 0.000000]

# Wykres błędu w skali log-log
plt.figure(figsize=(10, 6))
plt.loglog(num_samples, plain_error, label='PLAIN', marker='o')
plt.loglog(num_samples, miser_error, label='MISER', marker='s')
plt.loglog(num_samples, vegas_error, label='VEGAS', marker='^')

# Dodanie opisu osi i tytułu
plt.xlabel('Number of Samples (log scale)', fontsize=12)
plt.ylabel('Error (log scale)', fontsize=12)
plt.title('Error vs Number of Samples for Monte Carlo Methods', fontsize=14)
plt.legend(fontsize=12)
plt.grid(which="both", linestyle='--', linewidth=0.5)
plt.tight_layout()

# Wyświetlenie wykresu
plt.show()
plt.savefig("monte_carlo_error.png")
