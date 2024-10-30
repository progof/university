import matplotlib.pyplot as plt

# Dane do wykresu
produced = list(range(101))  # Producenci od 0 do 100
consumed = [i for i in range(101) if i % 2 == 0]  # Konsumenci co drugi element
remaining = [10 - (i // 2) for i in range(len(produced))]  # Dynamically calculate remaining items

# Wykres
plt.figure(figsize=(10, 6))
plt.plot(produced, label='Ilość dodanych', marker='o', color='blue')
plt.plot(consumed, label='Ilość pobranych', marker='x', color='orange')
plt.plot(remaining, label='Pozostałe elementy', linestyle='--', color='green')

# Dodatkowe informacje
plt.title('Produkcja i konsumpcja w buforze')
plt.xlabel('Numer iteracji')
plt.ylabel('Ilość')
plt.xticks(range(0, 101, 10))  # Oznaczenia co 10
plt.yticks(range(0, 11))  # Oznaczenia do 10
plt.axhline(y=10, color='red', linestyle='--', label='Maks. w buforze')  # Linia maksymalna
plt.legend()
plt.grid()
plt.show()
