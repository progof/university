import matplotlib.pyplot as plt

# Dane do wykresu w sekundach
labels = ['Dodawanie', 'Pobieranie']
pkmon_times = [20639906.71 / 1_000_000_000, 266680.45 / 1_000_000_000]  # Czas dla PKmonWaitNotify
pkmonjcu_times = [33505358.02 / 1_000_000_000, 41156.34 / 1_000_000_000]  # Czas dla PKmonJCU

x = range(len(labels))  # Indeksy dla etykiet

# Tworzenie wykresu
plt.bar(x, pkmon_times, width=0.4, label='PKmonWaitNotify', color='blue', align='center')
plt.bar([p + 0.4 for p in x], pkmonjcu_times, width=0.4, label='PKmonJCU', color='orange', align='center')

# Ustawienia wykresu
plt.xlabel('Operacja')
plt.ylabel('Średni czas operacji (s)')
plt.title('Porównanie czasów operacji dla implementacji PKmon i PKmonJCU')
plt.xticks([p + 0.2 for p in x], labels)  # Ustawienie etykiet na osi x
plt.legend()  # Dodanie legendy

# Wyświetlenie wykresu
plt.show()
