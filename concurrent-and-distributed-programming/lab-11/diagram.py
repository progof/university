import matplotlib.pyplot as plt
import numpy as np

# Dane wejściowe
seq_result_time = 0.5468
par_results_time = {
    "result_1": 0.5389,
    "result_2": 0.5364,
    "result_5": 0.6196,
    "result_10": 0.6490,
    "result_20": 0.5636,
}

par_results = {
    "result_1": 3.14157120,
    "result_2": 3.14027280,
    "result_5": 3.14093920,
    "result_10": 3.14073200,
    "result_20": 3.14206920,
}

# Obliczenia
# Przyśpieszenie S = T(1) / T(p)
speedup = {key: seq_result_time / time for key, time in par_results_time.items()}

# Efektywność E = S / p
efficiency = {key: speedup[key] / int(key.split('_')[1]) for key in speedup}

# Wykres przyśpieszenia
processes = [1, 2, 5, 10, 20]
speedup_values = [speedup[f"result_{p}"] for p in processes]
efficiency_values = [efficiency[f"result_{p}"] for p in processes]

# Przygotowanie wykresu
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(12, 6))

# Wykres przyśpieszenia
ax1.plot(processes, speedup_values, marker='o', color='b', label='Przyśpieszenie')
ax1.set_title('Wykres przyśpieszenia')
ax1.set_xlabel('Liczba procesów')
ax1.set_ylabel('Przyśpieszenie (S)')
ax1.grid(True)

# Wykres efektywności
ax2.plot(processes, efficiency_values, marker='o', color='g', label='Efektywność')
ax2.set_title('Wykres efektywności')
ax2.set_xlabel('Liczba procesów')
ax2.set_ylabel('Efektywność (E)')
ax2.grid(True)

plt.tight_layout()
plt.show()

# Analiza
speedup, efficiency
