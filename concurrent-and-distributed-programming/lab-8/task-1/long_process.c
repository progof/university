#include <mpi.h>
#include <stdio.h>
#include <unistd.h> // dla funkcji sleep()

int main(int argc, char **argv)
{
    int rank, size;

    // Inicjalizacja środowiska MPI
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    printf("Proces %d z %d: Start\n", rank, size);

    // Pętla opóźniająca (sztuczne opóźnienie)
    for (long i = 0; i < 1000000000; i++)
    {
        if (i % 250000000 == 0)
        {
            printf("Proces %d: Iteracja %ld\n", rank, i);
        }
    }

    printf("Proces %d: Koniec\n", rank);

    // Zakończenie środowiska MPI
    MPI_Finalize();
    return 0;
}
