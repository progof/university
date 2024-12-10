#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <mpi.h>

// mpicc -o life_mpi life_mpi.c
// mpirun -np 4 ./life_mpi 100 0.5 100

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

void exchange_borders(int **grid, int K, int N, int rank, int psize)
{
    MPI_Request requests[4];
    int up = rank > 0 ? rank - 1 : MPI_PROC_NULL;
    int down = rank < psize - 1 ? rank + 1 : MPI_PROC_NULL;

    MPI_Isend(grid[1], N, MPI_INT, up, 0, MPI_COMM_WORLD, &requests[0]);
    MPI_Isend(grid[K], N, MPI_INT, down, 0, MPI_COMM_WORLD, &requests[1]);
    MPI_Irecv(grid[0], N, MPI_INT, up, 0, MPI_COMM_WORLD, &requests[2]);
    MPI_Irecv(grid[K + 1], N, MPI_INT, down, 0, MPI_COMM_WORLD, &requests[3]);

    MPI_Waitall(4, requests, MPI_STATUSES_IGNORE);
}

void update_cells(int **grid, int **prev_grid, int K, int N)
{
    for (int i = 1; i <= K; i++)
    {
        for (int j = 0; j < N; j++)
        {
            int nb_count =
                prev_grid[i - 1][(j - 1 + N) % N] + prev_grid[i - 1][j] + prev_grid[i - 1][(j + 1) % N] +
                prev_grid[i][(j - 1 + N) % N] + prev_grid[i][(j + 1) % N] +
                prev_grid[i + 1][(j - 1 + N) % N] + prev_grid[i + 1][j] + prev_grid[i + 1][(j + 1) % N];
            if (nb_count == 3)
            {
                grid[i][j] = 1;
            }
            else if (nb_count == 2)
            {
                grid[i][j] = prev_grid[i][j];
            }
            else
            {
                grid[i][j] = 0;
            }
        }
    }
}

int main(int argc, char **argv)
{
    int rank, psize, K, N, il_pok;
    int **grid, **prev_grid;

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
    il_pok = atoi(argv[3]);
    K = N / psize + (rank < N % psize ? 1 : 0);

    grid = calloc(K + 2, sizeof(int *));
    prev_grid = calloc(K + 2, sizeof(int *));
    for (int i = 0; i < K + 2; i++)
    {
        grid[i] = calloc(N, sizeof(int));
        prev_grid[i] = calloc(N, sizeof(int));
    }

    initialize_grid(grid, K, N, pp, rank);

    for (int generation = 1; generation <= il_pok; generation++)
    {
        exchange_borders(grid, K, N, rank, psize);

        for (int i = 1; i <= K; i++)
        {
            for (int j = 0; j < N; j++)
            {
                prev_grid[i][j] = grid[i][j];
            }
        }

        update_cells(grid, prev_grid, K, N);

        int local_alive_count = 0;
        for (int i = 1; i <= K; i++)
        {
            for (int j = 0; j < N; j++)
            {
                local_alive_count += grid[i][j];
            }
        }

        int global_alive_count = 0;
        MPI_Reduce(&local_alive_count, &global_alive_count, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);

        if (rank == 0)
        {
            printf("Generation %d: Total alive cells = %d\n", generation, global_alive_count);
        }
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
