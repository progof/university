// Napisz program, który wczytuje liczbę całkowitą n, 
// losuje n liczb całkowitych z przedziału [0, 10) a następnie rysuje ich histogram.

import java.util.Random;
import java.util.Scanner;

public class Histogram {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        System.out.print("Enter the integer n: ");
        int n = scanner.nextInt();
        
        if (n <= 0) {
            System.out.println("The number n specified must be greater than zero.");
            return;
        }
        
        int[] numbers = new int[n];
        Random rand = new Random();
        
        System.out.println("Numbers drawn:");
        for (int i = 0; i < n; i++) {
            numbers[i] = rand.nextInt(10); // Losujemy liczby z przedziału [0, 10)
            System.out.print(numbers[i] + " ");
        }
        
        System.out.println("\nHistogram:");
        printHistogram(numbers);
    }
    
    public static void printHistogram(int[] numbers) {
        int[] counts = new int[10]; // Tablica liczników dla każdej możliwej liczby
        
        for (int number : numbers) {
            counts[number]++; // Zliczamy wystąpienia każdej liczby
        }
        
        for (int i = 0; i < 10; i++) {
            System.out.print(i + ": ");
            for (int j = 0; j < counts[i]; j++) {
                System.out.print("*"); // Rysujemy gwiazdki na podstawie liczby wystąpień
            }
            System.out.println();
        }
    }
}
