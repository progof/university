// public class Task {

//     public static void main(String[] args) {
//         int n = 10; // Liczba iteracji
//         double[] wyniki = new double[n + 1]; // Tablica do przechowywania wyników
//         double x0 = 0.5; // Zainicjalizuj x0, możesz zmienić na inną wartość

//         // Inicjalizacja pierwszego elementu ciągu
//         wyniki[0] = x0;

//         // Obliczanie ciągu
//         for (int i = 0; i < n; i++) {
//             wyniki[i + 1] = 4.0 * wyniki[i] - 3.0 * wyniki[i] * wyniki[i];
//         }

//         // Wyświetlenie wyników
//         System.out.println("Wyniki ciągu:");
//         for (int i = 0; i <= n; i++) {
//             System.out.printf("x[%d] = %.4f%n", i, wyniki[i]);
//         }

//         // Porównanie z wynikami z wcześniejszego zadania (jeśli są dostępne)
//         // Przykładowe wyniki do porównania, należy je zastąpić właściwymi danymi
//         double[] wynikiWczesniejsze = { 0.5, 0.5, 0.4, 0.3, 0.2, 0.1, 0.05, 0.025, 0.0125, 0.00625, 0.003125 };

//         System.out.println("\nPorównanie z wynikami z wcześniejszego zadania:");
//         for (int i = 0; i <= n; i++) {
//             if (i < wynikiWczesniejsze.length) {
//                 System.out.printf("x[%d] = %.4f (wcześniejsze = %.4f)%n", i, wyniki[i], wynikiWczesniejsze[i]);
//             } else {
//                 System.out.printf("x[%d] = %.4f (brak danych do porównania)%n", i, wyniki[i]);
//             }
//         }
//     }
// }

public class Task {
    public static void main(String[] args) {
        final int N = 50;
        float[] floatSequence1 = new float[N];
        float[] floatSequence2 = new float[N];
        double[] doubleSequence1 = new double[N];
        double[] doubleSequence2 = new double[N];

        // Ustalanie wartości początkowej
        floatSequence1[0] = 0.01f;
        floatSequence2[0] = 0.01f;
        doubleSequence1[0] = 0.01;
        doubleSequence2[0] = 0.01;

        // Obliczanie pierwszego wzoru
        for (int n = 0; n < N - 1; n++) {
            floatSequence1[n + 1] = floatSequence1[n] + 3.0f * floatSequence1[n] * (1 - floatSequence1[n]);
            doubleSequence1[n + 1] = doubleSequence1[n] + 3.0 * doubleSequence1[n] * (1 - doubleSequence1[n]);
        }

        // Obliczanie drugiego wzoru
        for (int n = 0; n < N - 1; n++) {
            floatSequence2[n + 1] = 4.0f * floatSequence2[n] - 3.0f * floatSequence2[n] * floatSequence2[n];
            doubleSequence2[n + 1] = 4.0 * doubleSequence2[n] - 3.0 * doubleSequence2[n] * doubleSequence2[n];
        }

        // Wyświetlanie wyników
        System.out.println("n\tfloat (Wzór 1)\tdouble (Wzór 1)\tfloat (Wzór 2)\tdouble (Wzór 2)");
        for (int n = 0; n < N; n++) {
            System.out.printf("%d\t%.7f\t%.7f\t%.7f\t%.7f%n",
                    n,
                    floatSequence1[n], doubleSequence1[n],
                    floatSequence2[n], doubleSequence2[n]);
        }
    }
}

