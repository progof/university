import matplotlib.pyplot as plt

# Dane z tabeli
rozmiar_pola = [10, 20, 30, 40, 50, 100, 120, 150, 170, 200]
czas_wykonania = [0.446187, 0.471149, 0.426114, 0.492119, 0.504548, 0.461668, 0.472067, 0.505706, 0.493074, 0.459276]

# Tworzenie wykresu
plt.plot(rozmiar_pola, czas_wykonania, marker='o', linestyle='-', color='b')

# Dodanie tytułu i etykiet osi
plt.title('Czas wykonania algorytmu w zależności od rozmiaru pola')
plt.xlabel('Rozmiar pola (n)')
plt.ylabel('Czas wykonania (s)')  # Zmieniono na sekundy

# Wyświetlenie wykresu
plt.grid(True)
plt.show()
