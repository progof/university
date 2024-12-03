// #include "mpi.h"
// #include <stdio.h>
// #include <stdlib.h>
// #include <time.h>

// int main(int argc, char **argv)
// {
//     int myid, num_procs;
//     int stake = 0, my_number;
//     MPI_Status status;

//     // Initialize MPI
//     MPI_Init(&argc, &argv);

//     // Get the process id and number of processes
//     MPI_Comm_rank(MPI_COMM_WORLD, &myid);
//     MPI_Comm_size(MPI_COMM_WORLD, &num_procs);

//     // Generate a random number for each process
//     srand(time(NULL) + myid);
//     my_number = rand() % 10; // Random number between 0 and 9

//     if (myid == 0)
//     {
//         // Process 0 starts the auction
//         printf("Process %d starts the auction. Initial value: %d\n", myid, stake);
//         // Process 0 sends the initial stake (0) to process 1
//         MPI_Send(&stake, 1, MPI_INT, 1, 0, MPI_COMM_WORLD);
//     }

//     while (1)
//     {
//         // Receive the stake from the previous process
//         MPI_Recv(&stake, 1, MPI_INT, (myid - 1 + num_procs) % num_procs, 0, MPI_COMM_WORLD, &status);

//         printf("Process %d received the stake %d, my number is %d.\n", myid, stake, my_number);

//         // If our number is greater than the stake, we raise the stake
//         if (my_number > stake)
//         {
//             stake++;
//             printf("Process %d raises the stake to %d\n", myid, stake);
//             // Send the raised stake to the next process
//             MPI_Send(&stake, 1, MPI_INT, (myid + 1) % num_procs, 0, MPI_COMM_WORLD);
//         }
//         else
//         {
//             // If we do not raise the stake, we send it forward without changes
//             printf("Process %d does not raise the stake, sending %d\n", myid, stake);
//             MPI_Send(&stake, 1, MPI_INT, (myid + 1) % num_procs, 0, MPI_COMM_WORLD);
//         }

//         // End the auction - the process ends when the stake doesn't change
//         if (stake == my_number)
//         {
//             printf("Process %d wins the auction with a stake value of %d!\n", myid, stake);
//             break;
//         }
//     }

//     // Finalize MPI
//     MPI_Finalize();
//     return 0;
// }

#include "mpi.h"
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char **argv)
{
    int myid, num_procs;
    int stake = 0, my_number;
    int global_auction_ongoing = 1; // Globalna flaga zakończenia aukcji
    int local_auction_ongoing = 1;  // Lokalna flaga dla każdego procesu
    int end_flag = 0;               // Flaga sygnalizująca zakończenie aukcji
    MPI_Status status;

    // Inicjalizacja MPI
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &myid);
    MPI_Comm_size(MPI_COMM_WORLD, &num_procs);

    srand(time(NULL) + myid);
    my_number = rand() % 10; // Każdy proces ma losową liczbę od 0 do 9

    if (myid == 0)
    {
        printf("Process %d starts the auction. Initial value: %d\n", myid, stake);
        MPI_Send(&stake, 1, MPI_INT, (myid + 1) % num_procs, 0, MPI_COMM_WORLD);
    }

    while (global_auction_ongoing)
    {
        // Odbieramy stawkę od poprzedniego procesu
        MPI_Recv(&stake, 1, MPI_INT, (myid - 1 + num_procs) % num_procs, 0, MPI_COMM_WORLD, &status);

        printf("Process %d received stake %d, my number is %d.\n", myid, stake, my_number);

        if (local_auction_ongoing)
        {
            if (my_number > stake)
            {
                stake++;
                printf("Process %d raises the stake to %d\n", myid, stake);
            }
            else
            {
                printf("Process %d does not raise the stake, sending %d\n", myid, stake);
            }

            // Jeśli wygrywamy, ustawiamy lokalną flagę i kończymy
            if (stake == my_number)
            {
                printf("Process %d wins the auction with stake value %d!\n", myid, stake);
                local_auction_ongoing = 0;
                end_flag = 1;
            }

            // Wysyłamy stawkę do następnego procesu
            MPI_Send(&stake, 1, MPI_INT, (myid + 1) % num_procs, 0, MPI_COMM_WORLD);
        }

        // Synchronizacja globalna - propagujemy stan zakończenia aukcji
        MPI_Allreduce(&end_flag, &global_auction_ongoing, 1, MPI_INT, MPI_LOR, MPI_COMM_WORLD);

        if (!global_auction_ongoing)
        {
            printf("Process %d exiting the auction.\n", myid);
        }
    }

    MPI_Finalize();
    return 0;
}
