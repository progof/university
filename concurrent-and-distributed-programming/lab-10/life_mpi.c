#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <mpi.h>

void initialize_grid(int **grid, int K, int N, double pp, int rank)
{
    srand(rank + time(NULL));
    for (int i = 1; i <= K; i++)
    {
        for (int j = 0; j < N; j++)
        {
            grid[i][j] = (rand() % 100 < pp * 100) ? 1 : 0;
        }
    }
}

void exchange_borders(int **grid, int K, int N, int rank, int psize, MPI_Request *send_requests, MPI_Request *recv_requests)
{
    int up = (rank > 0) ? rank - 1 : MPI_PROC_NULL;
    int down = (rank < psize - 1) ? rank + 1 : MPI_PROC_NULL;

    // Wysyłanie i odbieranie granic
    MPI_Isend(grid[1], N, MPI_INT, up, 0, MPI_COMM_WORLD, &send_requests[0]);
    MPI_Isend(grid[K], N, MPI_INT, down, 1, MPI_COMM_WORLD, &send_requests[1]);
    MPI_Irecv(grid[0], N, MPI_INT, up, 1, MPI_COMM_WORLD, &recv_requests[0]);
    MPI_Irecv(grid[K + 1], N, MPI_INT, down, 0, MPI_COMM_WORLD, &recv_requests[1]);
}

void update_cells(int **grid, int **prev_grid, int start, int end, int N)
{
    for (int i = start; i <= end; i++)
    {
        for (int j = 0; j < N; j++)
        {
            int nb_count =
                prev_grid[i - 1][(j - 1 + N) % N] + prev_grid[i - 1][j] + prev_grid[i - 1][(j + 1) % N] +
                prev_grid[i][(j - 1 + N) % N] + prev_grid[i][(j + 1) % N] +
                prev_grid[i + 1][(j - 1 + N) % N] + prev_grid[i + 1][j] + prev_grid[i + 1][(j + 1) % N];
            grid[i][j] = (nb_count == 3 || (grid[i][j] && nb_count == 2)) ? 1 : 0;
        }
    }
}

int main(int argc, char **argv)
{
    int rank, psize, K, N, generations;
    int **grid, **prev_grid;
    MPI_Request send_requests[2], recv_requests[2];
    MPI_Status status[2];

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &psize);

    if (argc != 4)
    {
        if (rank == 0)
        {
            fprintf(stderr, "Usage: %s <grid size> <probability> <generations>\n", argv[0]);
        }
        MPI_Finalize();
        return 1;
    }

    N = atoi(argv[1]);
    double pp = atof(argv[2]);
    generations = atoi(argv[3]);
    K = N / psize + (rank < N % psize ? 1 : 0);

    grid = (int **)calloc(K + 2, sizeof(int *));
    prev_grid = (int **)calloc(K + 2, sizeof(int *));
    for (int i = 0; i < K + 2; i++)
    {
        grid[i] = (int *)calloc(N, sizeof(int));
        prev_grid[i] = (int *)calloc(N, sizeof(int));
    }

    initialize_grid(grid, K, N, pp, rank);

    double start_time = MPI_Wtime();

    for (int gen = 1; gen <= generations; gen++)
    {
        exchange_borders(grid, K, N, rank, psize, send_requests, recv_requests);

        // Kopiowanie stanu do prev_grid
        for (int i = 1; i <= K; i++)
        {
            for (int j = 0; j < N; j++)
            {
                prev_grid[i][j] = grid[i][j];
            }
        }

        // Obliczenia dla wewnętrznych komórek
        update_cells(grid, prev_grid, 2, K - 1, N);

        MPI_Waitall(2, recv_requests, status);

        // Obliczenia dla krawędzi
        update_cells(grid, prev_grid, 1, 1, N);
        update_cells(grid, prev_grid, K, K, N);

        // Zliczanie żywych komórek
        int local_alive = 0;
        for (int i = 1; i <= K; i++)
        {
            for (int j = 0; j < N; j++)
            {
                local_alive += grid[i][j];
            }
        }

        int global_alive;
        MPI_Reduce(&local_alive, &global_alive, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);

        if (rank == 0)
        {
            printf("Generation %d: Total alive cells = %d\n", gen, global_alive);
        }
    }

    double end_time = MPI_Wtime();
    if (rank == 0)
    {
        printf("Total time: %f seconds\n", end_time - start_time);
    }

    for (int i = 0; i < K + 2; i++)
    {
        free(grid[i]);
        free(prev_grid[i]);
    }
    free(grid);
    free(prev_grid);

    MPI_Finalize();
    return 0;
}