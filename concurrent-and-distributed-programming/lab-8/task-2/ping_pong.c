#include <mpi.h>
#include <stdio.h>

int main(int argc, char **argv)
{
    int rank, size;
    int val = 0;

    // Initialize the MPI environment
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank); // Get the rank (ID) of the process
    MPI_Comm_size(MPI_COMM_WORLD, &size); // Get the total number of processes

    // Check if there are exactly 2 processes
    if (size != 2)
    {
        printf("The program requires 2 processes!\n");
        MPI_Finalize();
        return 1;
    }

    // The program works with exactly 2 processes (rank 0 and rank 1)
    if (rank == 0)
    {
        // Process 0 sends a value, then receives from process 1
        while (val < 20)
        {
            MPI_Send(&val, 1, MPI_INT, 1, 0, MPI_COMM_WORLD); // Send the value to process 1
            printf("Process %d sent: %d\n", rank, val);
            MPI_Recv(&val, 1, MPI_INT, 1, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE); // Receive the value from process 1
            printf("Process %d received: %d\n", rank, val);
        }
    }
    else if (rank == 1)
    {
        // Process 1 receives a value, then sends it to process 0
        while (val < 20)
        {
            MPI_Recv(&val, 1, MPI_INT, 0, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE); // Receive the value from process 0
            printf("Process %d received: %d\n", rank, val);
            val++;                                            // Increment the value
            MPI_Send(&val, 1, MPI_INT, 0, 0, MPI_COMM_WORLD); // Send the value to process 0
            printf("Process %d sent: %d\n", rank, val);
        }
    }

    // Finalize the MPI environment
    MPI_Finalize();
    return 0;
}
