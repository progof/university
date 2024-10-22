import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Wczytaj dane z pliku
data = np.loadtxt('dane2.dat', skiprows=1)  # Pomija pierwszą linię z komentarzem

# Rozdziel dane na osie X, Y i Z
X = data[:, 0]
Y = data[:, 1]
Z = data[:, 2]

# Tworzenie wykresu 3D
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

# Wykres powierzchni
ax.scatter(X, Y, Z, c=Z, cmap='viridis')  # Koloruj punkty według wartości Z
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')

# Ustawienia tytułu
ax.set_title('Wizualizacja danych z dane2.dat')

# Wyświetlenie wykresu
plt.show()
