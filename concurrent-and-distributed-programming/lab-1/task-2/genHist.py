import matplotlib.pyplot as plt

# Wczytaj dane z pliku
with open("counter_results.txt", "r") as file:
    data = [int(line.strip()) for line in file]

# Tworzenie histogramu
plt.hist(data, bins=20)
plt.xlabel('Wartość counter')
plt.ylabel('Częstotliwość')
plt.title('Histogram wartości counter')
plt.show()
