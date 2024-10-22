import numpy as np
import matplotlib.pyplot as plt
import csv

# Wczytaj dane z pliku CSV
n_values = []
float_seq1 = []
double_seq1 = []
float_seq2 = []
double_seq2 = []

with open('results.csv', mode='r', newline='') as file:
    reader = csv.reader(file, delimiter='\t')
    # Pomiń pierwszy wiersz (nagłówki)
    next(reader)
    for row in reader:
        n_values.append(int(row[0]))
        float_seq1.append(float(row[1].replace(',', '.')))
        double_seq1.append(float(row[2].replace(',', '.')))
        float_seq2.append(float(row[3].replace(',', '.')))
        double_seq2.append(float(row[4].replace(',', '.')))

# Konwersja list do numpy arrays dla łatwiejszej obróbki
n_values = np.array(n_values)
float_seq1 = np.array(float_seq1)
double_seq1 = np.array(double_seq1)
float_seq2 = np.array(float_seq2)
double_seq2 = np.array(double_seq2)

# Tworzenie wykresów
plt.figure(figsize=(12, 8))

# Wykres dla Wzoru 1
plt.subplot(2, 1, 1)
plt.plot(n_values, float_seq1, label='float (Wzór 1)', color='blue', marker='o')
plt.plot(n_values, double_seq1, label='double (Wzór 1)', color='cyan', marker='x')
plt.title('Wyniki Wzoru 1')
plt.xlabel('n')
plt.ylabel('Wartości')
plt.legend()
plt.grid()

# Wykres dla Wzoru 2
plt.subplot(2, 1, 2)
plt.plot(n_values, float_seq2, label='float (Wzór 2)', color='orange', marker='o')
plt.plot(n_values, double_seq2, label='double (Wzór 2)', color='red', marker='x')
plt.title('Wyniki Wzoru 2')
plt.xlabel('n')
plt.ylabel('Wartości')
plt.legend()
plt.grid()

# Wyświetlenie wykresów
plt.tight_layout()
plt.show()
