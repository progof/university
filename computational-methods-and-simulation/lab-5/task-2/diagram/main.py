import numpy as np
import matplotlib.pyplot as plt

# Dane wejściowe
epsrel_values = [1e-3, 1e-4, 1e-5, 1e-6]
functions = {
    "f3: sin(x)": {
        "GSL": [2.0, 2.0, 2.0, 2.0],
        "Rectangular": [2.0002008117, 2.0000125499, 2.0000031375, 2.0000001961]
    },
    "f4: tan(x)": {
        "GSL": [13.8155086985, 13.8155105592, 13.8155105579, 13.8155105579],
        "Rectangular": [13.8154192810, 13.8154877322, 13.8155091312, 13.8155104688]
    },
    "f5: log(x + x^2)": {
        "GSL": [6.2060726455, 6.2060726455, 6.2060726455, 6.2060726455],
        "Rectangular": [6.2061687630, 6.2060966773, 6.2060741476, 6.2060727394]
    }
}

# Generowanie wykresów pojedynczo dla każdej funkcji
for func_name, results in functions.items():
    plt.figure(figsize=(8, 5))
    
    # Wykres wyników GSL
    plt.plot(epsrel_values, results["GSL"], marker='o', color='b', label='GSL')
    
    # Wykres wyników Metody Prostokątów
    plt.plot(epsrel_values, results["Rectangular"], marker='x', color='r', label='Rectangular')
    
    # Konfiguracja wykresu
    plt.xscale("log")
    plt.xlabel("epsrel (Dokładność)")
    plt.ylabel("Wynik całki")
    plt.title(f"Wyniki dla {func_name}")
    plt.legend()
    plt.grid(True, which="both", linestyle="--", linewidth=0.5)
    
    # Wyświetlanie wykresu
    plt.show()
