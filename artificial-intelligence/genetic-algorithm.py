import random
from deap import base, creator, tools, algorithms
import matplotlib.pyplot as plt

# 1. Definicja problemu
# Tworzymy "fitness" jako maksymalizację funkcji
creator.create("FitnessMax", base.Fitness, weights=(1.0,))  # Maksymalizacja
creator.create("Individual", list, fitness=creator.FitnessMax)

# 2. Inicjalizacja narzędzi
toolbox = base.Toolbox()

# Definiujemy generator genów: liczby zmiennoprzecinkowe z zakresu -10 do 10
toolbox.register("attr_float", random.uniform, -10, 10)

# Definiujemy strukturę indywidualną: jeden gen (x)
toolbox.register("individual", tools.initRepeat, creator.Individual, toolbox.attr_float, n=1)

# Definiujemy populację: lista indywidualnych
toolbox.register("population", tools.initRepeat, list, toolbox.individual)

# 3. Definicja funkcji oceny
def eval_func(individual):
    x = individual[0]
    return x**2,

toolbox.register("evaluate", eval_func)

# 4. Definicja operatorów genetycznych
# Krzyżowanie blend z alpha=0.5
toolbox.register("mate", tools.cxBlend, alpha=0.5)

# Mutacja z rozkładem Gaussa: średnia=0, odchylenie standardowe=1, zmienia 10% genów
toolbox.register("mutate", tools.mutGaussian, mu=0, sigma=1, indpb=0.1)

# Selekcja turniejowa z rozmiarem turnieju=3
toolbox.register("select", tools.selTournament, tournsize=3)

# 5. Parametry algorytmu
population_size = 50
num_generations = 40
crossover_prob = 0.7
mutation_prob = 0.2

# 6. Inicjalizacja populacji
population = toolbox.population(n=population_size)

# 7. Statystyki
# Poprawka: Upewniamy się, że statystyki operują na pojedynczych wartościach fitness
stats = tools.Statistics(lambda ind: ind.fitness.values[0])
stats.register("avg", lambda fits: sum(fits) / len(fits))
stats.register("max", max)

# 8. Rekordy najlepszych osobników
logbook = tools.Logbook()
logbook.header = ["gen", "avg", "max"]

# 9. Ewolucja
for gen in range(num_generations):
    # Selekcja
    offspring = toolbox.select(population, len(population))
    offspring = list(map(toolbox.clone, offspring))
    
    # Krzyżowanie
    for child1, child2 in zip(offspring[::2], offspring[1::2]):
        if random.random() < crossover_prob:
            toolbox.mate(child1, child2)
            del child1.fitness.values
            del child2.fitness.values
    
    # Mutacja
    for mutant in offspring:
        if random.random() < mutation_prob:
            toolbox.mutate(mutant)
            del mutant.fitness.values
    
    # Ocena osobników z usuniętymi wartościami fitness
    invalid_ind = [ind for ind in offspring if not ind.fitness.valid]
    fitnesses = map(toolbox.evaluate, invalid_ind)
    for ind, fit in zip(invalid_ind, fitnesses):
        ind.fitness.values = fit
    
    # Zastępowanie populacji
    population[:] = offspring
    
    # Zbieranie statystyk
    record = stats.compile(population)
    logbook.record(gen=gen, avg=record["avg"], max=record["max"])
    print(f"Generacja {gen}: Średnia={record['avg']:.2f}, Maksymalna={record['max']:.2f}")

# 10. Najlepszy osobnik
best_ind = tools.selBest(population, 1)[0]
print("\nNajlepszy osobnik:")
print(f"Indywiduum: {best_ind}")
print(f"Wartość funkcji celu: {best_ind.fitness.values[0]}")

# 11. Wizualizacja wyników
gen = logbook.select("gen")
avg = logbook.select("avg")
max_fit = logbook.select("max")

plt.figure(figsize=(10, 5))
plt.plot(gen, avg, label="Średnia wartość fitness")
plt.plot(gen, max_fit, label="Maksymalna wartość fitness")
plt.xlabel("Generacja")
plt.ylabel("Fitness")
plt.title("Ewolucja wartości fitness przez generacje")
plt.legend()
plt.grid(True)
plt.show()
