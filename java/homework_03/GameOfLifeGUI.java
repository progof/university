import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Random;

public class GameOfLifeGUI extends JFrame {
    private int n = 50; // Rozmiar planszy
    private boolean[][] board = new boolean[n][n];
    private Timer timer;
    private final int delay = 100; // Opóźnienie w ms

    public GameOfLifeGUI() {
        setTitle("Gra w życie");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(800, 800);
        setLocationRelativeTo(null);
        setLayout(new GridLayout(n, n));

        initializeBoard();
        initializeTimer();

        timer.start();
    }

    private void initializeBoard() {
        Random random = new Random();
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                board[i][j] = random.nextDouble() < 0.3; // Początkowo 30% komórek jest "żywych"
            }
        }
    }

    private void initializeTimer() {
        timer = new Timer(delay, new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                board = getNextGeneration(board);
                repaint();
            }
        });
    }

    private boolean[][] getNextGeneration(boolean[][] board) {
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

    private int countLiveNeighbors(boolean[][] board, int x, int y) {
        int n = board.length;
        int count = 0;

        int[] dx = {-1, -1, -1, 0, 0, 1, 1, 1};
        int[] dy = {-1, 0, 1, -1, 1, -1, 0, 1};

        for (int i = 0; i < 8; i++) {
            int newX = x + dx[i];
            int newY = y + dy[i];

            if (newX >= 0 && newX < n && newY >= 0 && newY < n && board[newX][newY]) {
                count++;
            }
        }

        return count;
    }

    @Override
    public void paint(Graphics g) {
        super.paint(g);

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (board[i][j]) {
                    g.setColor(Color.BLACK);
                    g.fillRect(i * 800 / n, j * 800 / n, 800 / n, 800 / n);
                } else {
                    g.setColor(Color.WHITE);
                    g.fillRect(i * 800 / n, j * 800 / n, 800 / n, 800 / n);
                }
            }
        }
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            GameOfLifeGUI game = new GameOfLifeGUI();
            game.setVisible(true);
        });
    }
}
