import matplotlib.pyplot as plt

# Dane
generations = list(range(1, 101))
alive_cells = [
    2896, 2614, 2481, 2327, 2276, 2257, 2179, 2096, 2107, 2020,
    1956, 1931, 1941, 1862, 1810, 1762, 1780, 1654, 1732, 1667,
    1646, 1660, 1590, 1614, 1531, 1531, 1423, 1452, 1386, 1412,
    1356, 1415, 1359, 1349, 1340, 1241, 1286, 1228, 1261, 1234,
    1213, 1170, 1152, 1123, 1157, 1203, 1220, 1220, 1144, 1207,
    1157, 1186, 1129, 1158, 1105, 1087, 1087, 1031, 966, 963,
    974, 964, 979, 989, 995, 955, 953, 904, 922, 901, 944, 880,
    893, 884, 897, 860, 822, 807, 786, 829, 831, 832, 830, 844,
    824, 843, 825, 816, 770, 737, 771, 740, 773, 772, 772, 788,
    804, 781, 786, 748
]

# Rysowanie wykresu
plt.figure(figsize=(10, 6))
plt.plot(generations, alive_cells, marker='o', linestyle='-', color='blue', label='Alive cells')

# Dodanie etykiet i tytułu
plt.title('Game of Life: Alive Cells per Generation', fontsize=14)
plt.xlabel('Generation', fontsize=12)
plt.ylabel('Total Alive Cells', fontsize=12)
plt.grid(True, linestyle='--', alpha=0.6)
plt.legend()
plt.tight_layout()

# Wyświetlenie wykresu
plt.show()
