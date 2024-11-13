import matplotlib.pyplot as plt

# Dane wejściowe
data = [
    {"readers": 10, "writers": 1, "LibraryWithSemaphores": {"execution_time": 222}, "LibraryWithConditions": {"execution_time": 157}},
    {"readers": 10, "writers": 5, "LibraryWithSemaphores": {"execution_time": 624}, "LibraryWithConditions": {"execution_time": 576}},
    {"readers": 10, "writers": 10, "LibraryWithSemaphores": {"execution_time": 1142}, "LibraryWithConditions": {"execution_time": 1084}},
    {"readers": 50, "writers": 1, "LibraryWithSemaphores": {"execution_time": 212}, "LibraryWithConditions": {"execution_time": 166}},
    {"readers": 50, "writers": 5, "LibraryWithSemaphores": {"execution_time": 635}, "LibraryWithConditions": {"execution_time": 571}},
    {"readers": 50, "writers": 10, "LibraryWithSemaphores": {"execution_time": 1145}, "LibraryWithConditions": {"execution_time": 1103}},
    {"readers": 100, "writers": 1, "LibraryWithSemaphores": {"execution_time": 212}, "LibraryWithConditions": {"execution_time": 168}},
    {"readers": 100, "writers": 5, "LibraryWithSemaphores": {"execution_time": 617}, "LibraryWithConditions": {"execution_time": 583}},
    {"readers": 100, "writers": 10, "LibraryWithSemaphores": {"execution_time": 1151}, "LibraryWithConditions": {"execution_time": 1110}},
]

# Przygotowanie danych
readers = [entry["readers"] for entry in data]
writers = [entry["writers"] for entry in data]
semaphores_times = [entry["LibraryWithSemaphores"]["execution_time"] for entry in data]
conditions_times = [entry["LibraryWithConditions"]["execution_time"] for entry in data]

# Tworzenie dwóch wykresów: jeden dla LibraryWithSemaphores, drugi dla LibraryWithConditions
fig, axs = plt.subplots(2, 1, figsize=(10, 12))

# Wykres dla LibraryWithSemaphores
axs[0].plot(range(len(data)), semaphores_times, label='LibraryWithSemaphores', marker='o', color='blue')
for i, txt in enumerate(semaphores_times):
    axs[0].annotate(txt, (i, semaphores_times[i]), textcoords="offset points", xytext=(0, 5), ha='center')
axs[0].set_title('Czas wykonania operacji - LibraryWithSemaphores')
axs[0].set_xlabel('Indeks (readers, writers)')
axs[0].set_ylabel('Czas wykonania (ms)')
axs[0].set_xticks(range(len(data)))
axs[0].set_xticklabels([f'{r}R, {w}W' for r, w in zip(readers, writers)], rotation=45)
axs[0].grid(True)
axs[0].legend()

# Wykres dla LibraryWithConditions
axs[1].plot(range(len(data)), conditions_times, label='LibraryWithConditions', marker='x', color='green')
for i, txt in enumerate(conditions_times):
    axs[1].annotate(txt, (i, conditions_times[i]), textcoords="offset points", xytext=(0, 5), ha='center')
axs[1].set_title('Czas wykonania operacji - LibraryWithConditions')
axs[1].set_xlabel('Indeks (readers, writers)')
axs[1].set_ylabel('Czas wykonania (ms)')
axs[1].set_xticks(range(len(data)))
axs[1].set_xticklabels([f'{r}R, {w}W' for r, w in zip(readers, writers)], rotation=45)
axs[1].grid(True)
axs[1].legend()

# Wyświetlanie wykresów
plt.tight_layout()
plt.show()
