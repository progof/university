#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

double monte_carlo_pi(int num_points)
{
    int inside_circle = 0;

    for (int i = 0; i < num_points; i++)
    {
        double x = (double)rand() / RAND_MAX * 2.0 - 1.0;
        double y = (double)rand() / RAND_MAX * 2.0 - 1.0;

        if (x * x + y * y <= 1.0)
        {
            inside_circle++;
        }
    }

    return 4.0 * (double)inside_circle / num_points;
}

int main(int argc, char **argv)
{
    int rank, size, num_points = 10000000, points_per_process;
    int local_inside_circle = 0, total_inside_circle = 0;
    double pi_estimate;
    double start_time, end_time;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    points_per_process = num_points / size;
    srand(time(NULL) + rank); // Każdy proces inicjalizuje inny generator

    if (rank == 0)
    {
        start_time = MPI_Wtime(); // Rozpoczęcie pomiaru czasu
    }

    for (int i = 0; i < points_per_process; i++)
    {
        double x = (double)rand() / RAND_MAX * 2.0 - 1.0;
        double y = (double)rand() / RAND_MAX * 2.0 - 1.0;

        if (x * x + y * y <= 1.0)
        {
            local_inside_circle++;
        }
    }

    MPI_Reduce(&local_inside_circle, &total_inside_circle, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);

    if (rank == 0)
    {
        pi_estimate = 4.0 * (double)total_inside_circle / num_points;
        end_time = MPI_Wtime(); // Zakończenie pomiaru czasu

        printf("Szacowana wartość π: %.8f\n", pi_estimate);
        printf("Czas wykonania: %.4f sekund\n", end_time - start_time);
    }

    MPI_Finalize();
    return 0;
}