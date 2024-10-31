# import matplotlib.pyplot as plt

# # Dane do wykresu w sekundach
# labels = ['Dodawanie', 'Pobieranie']
# pkmon_add_times = [20639906.71 / 1_000_000_000, 0]  # Czas dla PKmonWaitNotify
# pkmonjcu_add_times = [33505358.02 / 1_000_000_000, 0]  # Czas dla PKmonJCU

# pkmon_get_times = [266680.45 / 1_000_000_000]  # Czas dla PKmonWaitNotify
# pkmonjcu_get_times = [41156.34 / 1_000_000_000]  # Czas dla PKmonJCU

# # Ustawienia dla osi x
# x = range(len(labels))  # Indeksy dla etykiet
# width = 0.35  # Szerokość kolumn

# # Tworzenie wykresu
# plt.bar([p - width/2 for p in x], pkmon_add_times, width=width, label='PKmonWaitNotify (Dodawanie)', color='blue', align='center')
# plt.bar([p + width/2 for p in x], pkmonjcu_add_times, width=width, label='PKmonJCU (Dodawanie)', color='orange', align='center')

# plt.bar([p - width/2 for p in x], pkmon_get_times, width=width, label='PKmonWaitNotify (Pobieranie)', color='cyan', alpha=0.5, align='center')
# plt.bar([p + width/2 for p in x], pkmonjcu_get_times, width=width, label='PKmonJCU (Pobieranie)', color='lightgreen', alpha=0.5, align='center')

# # Ustawienia wykresu
# plt.xlabel('Operacja')
# plt.ylabel('Średni czas operacji (s)')
# plt.title('Porównanie czasów operacji dla implementacji PKmon i PKmonJCU')
# plt.xticks(x, labels)  # Ustawienie etykiet na osi x
# plt.legend()  # Dodanie legendy

# # Wyświetlenie wykresu
# plt.tight_layout()  # Dostosowanie wykresu do rozmiaru
# plt.show()


import matplotlib.pyplot as plt

# Dane do wykresu w sekundach
labels = ['Dodawanie', 'Pobieranie']
pkmon_add_times = [20.63990671, 0.00026668045]  # Czas dla PKmonWaitNotify (Dodawanie, Pobieranie)
pkmonjcu_add_times = [33.50535802, 0.00004115634]  # Czas dla PKmonJCU (Dodawanie, Pobieranie)

# Ustawienia dla osi x
x = range(len(labels))  # Indeksy dla etykiet
width = 0.35  # Szerokość kolumn

# Tworzenie wykresu
fig, ax = plt.subplots()
# Dodawanie słupków dla PKmonWaitNotify z etykietą
ax.bar([p - width / 2 for p in x], pkmon_add_times, width=width, label='PKmonWaitNotify (Dodawanie)', color='blue')
# Dodawanie słupków dla PKmonJCU z etykietą
ax.bar([p + width / 2 for p in x], pkmonjcu_add_times, width=width, label='PKmonJCU (Dodawanie)', color='orange')

# Dodawanie słupków dla PKmonWaitNotify pobieranie z przezroczystością i etykietą
ax.bar([p - width / 2 for p in x], [0, pkmon_add_times[1]], width=width, label='PKmonWaitNotify (Pobieranie)', color='cyan', alpha=0.7)
# Dodawanie słupków dla PKmonJCU pobieranie z przezroczystością i etykietą
ax.bar([p + width / 2 for p in x], [0, pkmonjcu_add_times[1]], width=width, label='PKmonJCU (Pobieranie)', color='lightgreen', alpha=0.7)

# Ustawienia wykresu
ax.set_xlabel('Operacja')
ax.set_ylabel('Średni czas operacji (s)')
ax.set_title('Porównanie czasów operacji dla implementacji PKmonWaitNotify i PKmonJCU')
ax.set_xticks(x)
ax.set_xticklabels(labels)
ax.set_yscale('log')  # Skala logarytmiczna na osi y
ax.set_ylim(1e-5, 40)  # Zakres dla osi y
ax.legend()

# Wyświetlenie wykresu
plt.tight_layout()
plt.show()



