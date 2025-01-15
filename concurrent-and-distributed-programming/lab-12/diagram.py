import matplotlib.pyplot as plt
import numpy as np

# Dane o czasie wykonania (w sekundach)
procesy = [1, 2, 5, 10, 20]
macierze = [10, 50, 100, 150, 200]

# Przykładowe dane (zastąp swoimi wynikami)
czasy = {
    10: [0.007791, 0.027845, 0.047153, 0.050281, 0.000397],
    50: [0.151548,  0.168660, 0.281163, 0.383024, 0.683197],
    100: [0.159108, 0.157478, 0.273609, 0.387820, 0.674503],
    150: [1.275542, 1.490512, 1.542643, 2.144991, 3.177287],
    200: [3.209029, 2.652502, 2.388281,  3.113414, 4.816590]
}

# Tworzenie wykresu
plt.figure(figsize=(10, 6))

for size in macierze:
    plt.plot(procesy, czasy[size], label=f"Macierz {size}x{size}")

plt.xlabel('Liczba procesów')
plt.ylabel('Czas wykonania (sekundy)')
plt.title('Czas wykonania programu w zależności od liczby procesów i rozmiaru macierzy')
plt.legend()
plt.grid(True)
plt.show()
