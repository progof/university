// Gra w życie:

// Gra toczy się na planszy o rozmiarze nXn podzielonej na nXn kwadratowych komórek. 
// Każda komórka ma ośmiu "sąsiadów", czyli komórki przylegające do niej bokami i rogami. 
// Każda komórka może znajdować się w jednym z dwóch stanów: może być albo "żywa" (włączona), albo "martwa" (wyłączona). 
// Stany komórek zmieniają się w pewnych jednostkach czasu. Stan wszystkich komórek w pewnej jednostce czasu jest używany 
// do obliczenia stanu wszystkich komórek w następnej jednostce. Po obliczeniu wszystkie komórki zmieniają swój stan 
// dokładnie w tym samym momencie. Stan komórki zależy tylko od liczby jej żywych sąsiadów.
// Reguły gry według Conwaya:
// Martwa komórka, która ma dokładnie 3 żywych sąsiadów, staje się żywa w następnej jednostce czasu (rodzi się)
// Żywa komórka z 2 albo 3 żywymi sąsiadami pozostaje nadal żywa; przy innej liczbie sąsiadów 
// umiera (z "samotności" albo "zatłoczenia").
// Napisz program symulujący stan gry w kolejnych chwilach czasu. Rozmiar planszy n jest podany parametrem programu.
//  Stan początkowy generowany jest losowo z udziałem "żywych" komórek 30%. Kolejne stany wyświetlają się po naciśnięciu Enter.


import java.util.Random;
import java.util.Scanner;

public class GameOfLife {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Wymiary planszy
        int n = 10; // Domyślny rozmiar planszy
        if (args.length > 0) {
            n = Integer.parseInt(args[0]);
        }

        // Inicjalizacja planszy
        boolean[][] board = new boolean[n][n];
        initializeBoard(board);

        // Symulacja gry
        while (true) {
            printBoard(board);
            board = getNextGeneration(board);
            scanner.nextLine();
        }
    }

    // Inicjalizacja planszy losowymi stanami
    public static void initializeBoard(boolean[][] board) {
        Random random = new Random();
        for (int i = 0; i < board.length; i++) {
            for (int j = 0; j < board[i].length; j++) {
                board[i][j] = random.nextDouble() < 0.3; // Początkowo 30% komórek jest "żywych"
            }
        }
    }

    // Wyświetlenie aktualnego stanu planszy
    public static void printBoard(boolean[][] board) {
        for (int i = 0; i < board.length; i++) {
            for (int j = 0; j < board[i].length; j++) {
                if (board[i][j]) {
                    System.out.print("■ "); // Żywa komórka
                } else {
                    System.out.print("□ "); // Martwa komórka
                }
            }
            System.out.println();
        }
    }

    // Obliczenie następnego stanu planszy
    public static boolean[][] getNextGeneration(boolean[][] board) {
        int n = board.length;
        boolean[][] newBoard = new boolean[n][n];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                int liveNeighbors = countLiveNeighbors(board, i, j);
                if (board[i][j]) {
                    newBoard[i][j] = (liveNeighbors == 2 || liveNeighbors == 3);
                } else {
                    newBoard[i][j] = (liveNeighbors == 3);
                }
            }
        }

        return newBoard;
    }

    // Obliczenie liczby żywych sąsiadów danej komórki
    public static int countLiveNeighbors(boolean[][] board, int x, int y) {
        int n = board.length;
        int count = 0;

        int[] dx = { -1, -1, -1, 0, 0, 1, 1, 1 };
        int[] dy = { -1, 0, 1, -1, 1, -1, 0, 1 };

        for (int i = 0; i < 8; i++) {
            int newX = x + dx[i];
            int newY = y + dy[i];

            if (newX >= 0 && newX < n && newY >= 0 && newY < n && board[newX][newY]) {
                count++;
            }
        }

        return count;
    }
}
