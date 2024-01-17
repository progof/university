// Napisz program, który wczytuje liczbę całkowitą n a następnie drukuje listę jej podzielników (łącznie z 1 i n). */

import java.util.Scanner;

public class Dividers {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Enter the integer n: ");
        int n = scanner.nextInt();

        System.out.println("Divisors of a number " + n + " this:");

        for (int i = 1; i <= n; i++) {
            if (n % i == 0) {
                System.out.println(i);
            }
        }
        scanner.close();
    }
}
