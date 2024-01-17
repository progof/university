import java.util.Random;

class Ant {
    int x, y;

    public Ant(int x, int y) {
        this.x = x;
        this.y = y;
    }
}

public class Ants{
    static int n; 
    static boolean[][] board;
    static Ant[] ants; 
    static Random random = new Random();

    public static void main(String[] args) {
        if (args.length != 2) {
            System.out.println("Usage: java Ants <board size> <number of ants>.");
            System.exit(1);
        }

        n = Integer.parseInt(args[0]);
        int numberOfAnts = Integer.parseInt(args[1]);

        initializeBoard(numberOfAnts);
        printBoard();

        while (true) {
            for (Ant ant : ants) {
                moveAnt(ant);
            }

            try {
                Thread.sleep(1000); 
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            printBoard();
        }
    }

    static synchronized void moveAnt(Ant ant) {
        int newX, newY;

        do {
            int direction = random.nextInt(8);
            switch (direction) {
                case 0:  
                    newX = (ant.x - 1 + n) % n;
                    newY = (ant.y - 1 + n) % n;
                    break;
                case 1:  // move up
                    newX = ant.x;
                    newY = (ant.y - 1 + n) % n;
                    break;
                case 2:  // move right up
                    newX = (ant.x + 1) % n;
                    newY = (ant.y - 1 + n) % n;
                    break;
                case 3:  // move left
                    newX = (ant.x - 1 + n) % n;
                    newY = ant.y;
                    break;
                case 4:  // move right 
                    newX = (ant.x + 1) % n;
                    newY = ant.y;
                    break;
                case 5:  // move left down
                    newX = (ant.x - 1 + n) % n;
                    newY = (ant.y + 1) % n;
                    break;
                case 6:  // move down
                    newX = ant.x;
                    newY = (ant.y + 1) % n;
                    break;
                case 7:  // move right down
                    newX = (ant.x + 1) % n;
                    newY = (ant.y + 1) % n;
                    break;
                default:
                    newX = ant.x;
                    newY = ant.y;
            }
        } while (board[newX][newY]);

        board[ant.x][ant.y] = false; // release the previous seat
        ant.x = newX;
        ant.y = newY;
        board[newX][newY] = true; // take a new seat
    }

    static void initializeBoard(int numberOfAnts) {
        board = new boolean[n][n];
        ants = new Ant[numberOfAnts];

        for (int i = 0; i < numberOfAnts; i++) {
            int x = random.nextInt(n);
            int y = random.nextInt(n);

            while (board[x][y]) {
                x = random.nextInt(n);
                y = random.nextInt(n);
            }

            board[x][y] = true;
            ants[i] = new Ant(x, y);
        }
    }

    static void printBoard() {
        System.out.println("State of the Board:");
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (board[i][j]) {
                    System.out.print("8 ");
                } else {
                    System.out.print(". ");
                }
            }
            System.out.println();
        }
        System.out.println();
    }
}
