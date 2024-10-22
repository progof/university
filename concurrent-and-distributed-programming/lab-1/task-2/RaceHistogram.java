// import java.io.FileWriter;
// import java.io.IOException;

// class Counter {
//     private int _val;

//     public Counter(int n) {
//         _val = n;
//     }

//     public synchronized void inc() {
//         _val++;
//     }

//     public synchronized void dec() {
//         _val--;
//     }

//     public int value() {
//         return _val;
//     }
// }

// class IThread extends Thread {
//     private Counter counter;

//     public IThread(Counter counter) {
//         this.counter = counter;
//     }

//     @Override
//     public void run() {
//         for (int i = 0; i < 1000000; i++) {
//             counter.inc();
//         }
//     }
// }

// class DThread extends Thread {
//     private Counter counter;

//     public DThread(Counter counter) {
//         this.counter = counter;
//     }

//     @Override
//     public void run() {
//         for (int i = 0; i < 1000000; i++) {
//             counter.dec();
//         }
//     }
// }

// public class RaceHistogram {
//     public static void main(String[] args) {
//         int iterations = 100;
//         int[] results = new int[iterations];

//         for (int i = 0; i < iterations; i++) {
//             Counter cnt = new Counter(0);

//             IThread t1 = new IThread(cnt);
//             DThread t2 = new DThread(cnt);

//             t1.start();
//             t2.start();

//             try {
//                 t1.join();
//                 t2.join();
//             } catch (InterruptedException e) {
//                 e.printStackTrace();
//             }

//             // Zapisz wynik do tablicy
//             results[i] = cnt.value();
//         }

//         // Zapisz wyniki do pliku
//         try (FileWriter writer = new FileWriter("counter_results.txt")) {
//             for (int result : results) {
//                 writer.write(result + "\n");
//             }
//             System.out.println("Wyniki zapisane do pliku 'counter_results.txt'");
//         } catch (IOException e) {
//             e.printStackTrace();
//         }
//     }
// }

// class Counter {
//     private int _val;

//     public Counter(int n) {
//         _val = n;
//     }

//     public synchronized void inc() {
//         _val++;
//     }

//     public synchronized void dec() {
//         _val--;
//     }

//     public int value() {
//         return _val;
//     }
// }

// class IThread extends Thread {
//     private Counter counter;

//     public IThread(Counter counter) {
//         this.counter = counter;
//     }

//     @Override
//     public void run() {
//         for (int i = 0; i < 1000000; i++) {
//             counter.inc();
//         }
//     }
// }

// class DThread extends Thread {
//     private Counter counter;

//     public DThread(Counter counter) {
//         this.counter = counter;
//     }

//     @Override
//     public void run() {
//         for (int i = 0; i < 1000000; i++) {
//             counter.dec();
//         }
//     }
// }

// public class RaceHistogram {
//     public static void main(String[] args) {
//         int histogramSize = 100;
//         int[] histogram = new int[histogramSize];
//         int iterations = 100; // liczba uruchomień pętli

//         for (int run = 0; run < iterations; run++) {
//             Counter cnt = new Counter(0);

//             IThread t1 = new IThread(cnt);
//             DThread t2 = new DThread(cnt);

//             t1.start();
//             t2.start();

//             try {
//                 t1.join();
//                 t2.join();
//             } catch (InterruptedException e) {
//                 e.printStackTrace();
//             }

//             int finalValue = cnt.value();
//             // Zwiększamy odpowiedni indeks histogramu
//             if (finalValue >= 0 && finalValue < histogramSize) {
//                 histogram[finalValue]++;
//             }
//         }

//         // Wyświetlamy histogram
//         System.out.println("Histogram wartości zmiennej counter:");
//         for (int i = 0; i < histogram.length; i++) {
//             System.out.println("Wartość " + i + ": " + histogram[i]);
//         }
//     }
// }

class Counter {
    private int _val;

    public Counter(int n) {
        _val = n;
    }

    public synchronized void inc() {
        _val++;
    }

    public synchronized void dec() {
        _val--;
    }

    public int value() {
        return _val;
    }
}

class IThread extends Thread {
    private Counter counter;

    public IThread(Counter counter) {
        this.counter = counter;
    }

    @Override
    public void run() {
        for (int i = 0; i < 1000000; i++) {
            counter.inc();
        }
    }
}

class DThread extends Thread {
    private Counter counter;

    public DThread(Counter counter) {
        this.counter = counter;
    }

    @Override
    public void run() {
        for (int i = 0; i < 1000000; i++) {
            counter.dec();
        }
    }
}

public class RaceHistogram {
    public static void main(String[] args) {
        int iterations = 100; // liczba uruchomień pętli
        int histogramRange = 21; // zakres histogramu
        int[] histogram = new int[histogramRange];
        int offset = histogramRange / 2;

        for (int i = 0; i < iterations; i++) {
            Counter cnt = new Counter(0);

            IThread t1 = new IThread(cnt);
            DThread t2 = new DThread(cnt);

            t1.start();
            t2.start();

            try {
                t1.join();
                t2.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            int finalValue = cnt.value();

            if (finalValue >= -offset && finalValue < offset) {
                histogram[finalValue + offset]++;
            }
        }

        System.out.println("Histogram wartości zmiennej counter:");
        for (int i = 0; i < histogram.length; i++) {
            System.out.println("Wartość " + (i - offset) + ": " + histogram[i]);
        }
    }
}
