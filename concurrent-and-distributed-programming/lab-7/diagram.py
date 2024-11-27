import matplotlib.pyplot as plt

# Dane
threads = [10, 20, 50, 100]
fine_grained_times = [200.029, 163.231, 205.716, 477.463]  # ms
single_lock_times = [33.837, 48.949, 85.921, 237.552]  # ms

# Tworzenie wykresu
plt.figure(figsize=(10, 6))
plt.plot(threads, fine_grained_times, marker='o', linestyle='-', color='b', label='FineGrainedList')
plt.plot(threads, single_lock_times, marker='o', linestyle='--', color='r', label='SingleLockList')
plt.title('Porównanie wydajności: FineGrainedList vs SingleLockList')
plt.xlabel('Liczba wątków')
plt.ylabel('Czas wykonania operacji (ms)')
plt.xticks(threads)
plt.grid(True, linestyle='--', alpha=0.6)
plt.legend()
plt.show()
