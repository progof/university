import matplotlib.pyplot as plt
import numpy as np

# Funkcja do wczytania danych z pliku
def load_data(file_path):
    indices = []
    real_values = []
    imaginary_values = []
    
    with open(file_path, 'r') as file:
        for line in file:
            # Parsowanie linii
            parts = line.split()
            index = int(parts[0][:-1])  # Usuń dwukropek
            real = float(parts[1])
            imaginary = float(parts[2].rstrip('i'))
            
            # Dodaj dane do list
            indices.append(index)
            real_values.append(real)
            imaginary_values.append(imaginary)
    
    return indices, real_values, imaginary_values

# Funkcja do rysowania wykresu
def plot_data(indices, real_values, imaginary_values):
    plt.figure(figsize=(10, 6))
    plt.plot(indices, real_values, label='Część rzeczywista', marker='o')
    plt.plot(indices, imaginary_values, label='Część urojona', marker='x')
    
    plt.title('Wykres części rzeczywistej i urojonej')
    plt.xlabel('Indeks')
    plt.ylabel('Wartość')
    plt.legend()
    plt.grid(True)
    plt.show()

# Ścieżka do pliku
file_path = 'ifft_output.txt'

# Wczytaj dane
indices, real_values, imaginary_values = load_data(file_path)

# Narysuj wykres
plot_data(indices, real_values, imaginary_values)
