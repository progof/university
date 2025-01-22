# import matplotlib.pyplot as plt

# # Przykładowe dane
# processes = [1, 2, 4, 8]
# speedup = [1.0, 1.8, 3.5, 7.2]
# efficiency = [1.0, 0.9, 0.87, 0.9]

# # Wykres przyśpieszenia
# plt.figure()
# plt.plot(processes, speedup, marker='o')
# plt.title('Wykres przyśpieszenia')
# plt.xlabel('Liczba procesów')
# plt.ylabel('Przyśpieszenie')
# plt.grid()

# # Wykres efektywności
# plt.figure()
# plt.plot(processes, efficiency, marker='o')
# plt.title('Wykres efektywności')
# plt.xlabel('Liczba procesów')
# plt.ylabel('Efektywność')
# plt.grid()

# plt.show()


import matplotlib.pyplot as plt

# Dane: liczba procesów i czas wykonania w sekundach
num_processes = [1, 2, 4, 8]
execution_times = [0.000011, 0.000048, 0.000111, 0.000109]

# Utwórz wykres
plt.figure(figsize=(8, 6))
plt.plot(num_processes, execution_times, marker='o', linestyle='-', color='b', label='Czas wykonania')

# Dostosowanie wykresu
plt.xlabel('Liczba procesów')
plt.ylabel('Czas wykonania (sekundy)')
plt.title('Porównanie czasu wykonania sortowania w zależności od liczby procesów')
plt.grid(True)

# Pokaż wykres
plt.legend()
plt.show()

