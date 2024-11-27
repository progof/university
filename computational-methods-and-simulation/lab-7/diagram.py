import matplotlib.pyplot as plt

# Read data from the file
decompose_times = []
solve_times = []

with open('wyniki.txt', 'r') as f:
    for line in f:
        if line.startswith("Czas dekompozycji LU:"):
            decompose_times.append(float(line.split(':')[1].strip().split()[0]))
        elif line.startswith("Czas rozwiązywania układu:"):
            solve_times.append(float(line.split(':')[1].strip().split()[0]))

# Ensure n_values matches the number of data points in wyniki.txt
n_values = list(range(10, 10 + 100 * len(decompose_times), 100))  # Adjusting based on the data length

# If there are fewer decompose_times or solve_times than n_values, fill with zeros
while len(decompose_times) < len(n_values):
    decompose_times.append(0)
while len(solve_times) < len(n_values):
    solve_times.append(0)

# Check if the lengths match
assert len(n_values) == len(decompose_times), f"Mismatch between n_values and decompose_times lengths: {len(n_values)} != {len(decompose_times)}"
assert len(n_values) == len(solve_times), f"Mismatch between n_values and solve_times lengths: {len(n_values)} != {len(solve_times)}"

# Plotting the results
plt.figure(figsize=(10, 6))
plt.plot(n_values, decompose_times, label="Czas dekompozycji LU", marker='o')
plt.plot(n_values, solve_times, label="Czas rozwiązywania układu", marker='o')
plt.xlabel("Rozmiar układu równań (n)")
plt.ylabel("Czas (s)")
plt.title("Zależność czasu od rozmiaru układu równań")
plt.legend()
plt.grid()
plt.show()
