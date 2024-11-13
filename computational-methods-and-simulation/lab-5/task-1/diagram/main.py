# import matplotlib.pyplot as plt
# import numpy as np

# # Dane do wykresu
# functions = [
#     {
#         "name": "f1(x) = x^2 + x + 1",
#         "exact_value": 1.6666666667,
#         "approx_values": [1.8333314260, 1.8333314260, 1.8333314260, 1.8333314260],
#         "errors": [0.1666647593, 0.1666647593, 0.1666647593, 0.1666647593],
#         "subintervals": [1048576, 1048576, 1048576, 1048576]
#     },
#     {
#         "name": "f2(x) = sqrt(1 - x^2)",
#         "exact_value": 0.7853981634,
#         "approx_values": [0.7863493507, 0.7854588020, 0.7854057753, 0.7853991163],
#         "errors": [0.0009511873, 0.0000606386, 0.0000076119, 0.0000009529],
#         "subintervals": [512, 8192, 65536, 524288]
#     },
#     {
#         "name": "f3(x) = 1/sqrt(x)",
#         "exact_value": 2.0000000000,
#         "approx_values": [1.9800945559, 1.9800945559, 1.9800945559, 1.9800945559],
#         "errors": [0.0199054441, 0.0199054441, 0.0199054441, 0.0199054441],
#         "subintervals": [1048576, 1048576, 1048576, 1048576]
#     }
# ]

# # Ustawienia wykresów
# fig, axs = plt.subplots(3, 2, figsize=(14, 10))
# fig.suptitle("Wyniki przybliżonej całki dla różnych funkcji", fontsize=16)

# # Generowanie wykresów
# for i, func in enumerate(functions):
#     # Podprzedziały vs Przybliżona całka
#     axs[i, 0].plot(func["subintervals"], func["approx_values"], marker='o', color='b', label="Przybliżona całka")
#     axs[i, 0].axhline(y=func["exact_value"], color='r', linestyle='--', label="Dokładna wartość")
#     axs[i, 0].set_xscale("log")
#     axs[i, 0].set_xlabel("Podprzedziały (log scale)")
#     axs[i, 0].set_ylabel("Wartość całki")
#     axs[i, 0].set_title(f"{func['name']}")
#     axs[i, 0].legend()
    
#     # Podprzedziały vs Błąd
#     axs[i, 1].plot(func["subintervals"], func["errors"], marker='o', color='g', label="Błąd")
#     axs[i, 1].set_xscale("log")
#     axs[i, 1].set_yscale("log")
#     axs[i, 1].set_xlabel("Podprzedziały (log scale)")
#     axs[i, 1].set_ylabel("Błąd (log scale)")
#     axs[i, 1].set_title(f"Błąd dla {func['name']}")
#     axs[i, 1].legend()

# plt.tight_layout(rect=[0, 0, 1, 0.96])
# plt.show()


import matplotlib.pyplot as plt
import numpy as np

# Dane do wykresu
functions = [
    {
        "name": "f1(x) = x^2 + x + 1",
        "exact_value": 1.6666666667,
        "approx_values": [1.8333314260, 1.8333314260, 1.8333314260, 1.8333314260],
        "errors": [0.1666647593, 0.1666647593, 0.1666647593, 0.1666647593],
        "subintervals": [1048576, 1048576, 1048576, 1048576]
    },
    {
        "name": "f2(x) = sqrt(1 - x^2)",
        "exact_value": 0.7853981634,
        "approx_values": [0.7863493507, 0.7854588020, 0.7854057753, 0.7853991163],
        "errors": [0.0009511873, 0.0000606386, 0.0000076119, 0.0000009529],
        "subintervals": [512, 8192, 65536, 524288]
    },
    {
        "name": "f3(x) = 1/sqrt(x)",
        "exact_value": 2.0000000000,
        "approx_values": [1.9800945559, 1.9800945559, 1.9800945559, 1.9800945559],
        "errors": [0.0199054441, 0.0199054441, 0.0199054441, 0.0199054441],
        "subintervals": [1048576, 1048576, 1048576, 1048576]
    }
]

# Generowanie oddzielnych wykresów
for func in functions:
    # Wykres Przybliżonej całki
    plt.figure()
    plt.plot(func["subintervals"], func["approx_values"], marker='o', color='b', label="Przybliżona całka")
    plt.axhline(y=func["exact_value"], color='r', linestyle='--', label="Dokładna wartość")
    plt.xscale("log")
    plt.xlabel("Podprzedziały (log scale)")
    plt.ylabel("Wartość całki")
    plt.title(f"{func['name']}")
    plt.legend()
    plt.show()

    # Wykres Błędu
    plt.figure()
    plt.plot(func["subintervals"], func["errors"], marker='o', color='g', label="Błąd")
    plt.xscale("log")
    plt.yscale("log")
    plt.xlabel("Podprzedziały (log scale)")
    plt.ylabel("Błąd (log scale)")
    plt.title(f"Błąd dla {func['name']}")
    plt.legend()
    plt.show()
