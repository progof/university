// import java.util.concurrent.ArrayBlockingQueue;
// import java.util.concurrent.BlockingQueue;

// class BuforJCU {
//     private final BlockingQueue<Integer> queue;

//     public BuforJCU(int capacity) {
//         this.queue = new ArrayBlockingQueue<>(capacity);
//     }

//     public void put(int value) {
//         long startTime = System.nanoTime();
//         try {
//             queue.put(value);
//             long endTime = System.nanoTime();
//             System.out.printf("Producent dodał: %d | Ilość w buforze: %d | Czas operacji: %d ns\n",
//                     value, queue.size(), (endTime - startTime));
//         } catch (InterruptedException e) {
//             Thread.currentThread().interrupt();
//         }
//     }

//     public int get() {
//         long startTime = System.nanoTime();
//         try {
//             int value = queue.take();
//             long endTime = System.nanoTime();
//             System.out.printf("Konsument pobrał: %d | Pozostało w buforze: %d | Czas operacji: %d ns\n",
//                     value, queue.size(), (endTime - startTime));
//             return value;
//         } catch (InterruptedException e) {
//             Thread.currentThread().interrupt();
//             return -1; // Wartość domyślna w przypadku przerwania
//         }
//     }
// }

// class Producent extends Thread {
//     private final BuforJCU bufor;

//     public Producent(BuforJCU bufor) {
//         this.bufor = bufor;
//     }

//     @Override
//     public void run() {
//         for (int i = 0; i < 100; i++) { // Producent dodaje 100 elementów
//             bufor.put(i);
//             try {
//                 Thread.sleep(100); // Przerwa między dodaniami
//             } catch (InterruptedException e) {
//                 Thread.currentThread().interrupt();
//             }
//         }
//     }
// }

// class Konsument extends Thread {
//     private final BuforJCU bufor;

//     public Konsument(BuforJCU bufor) {
//         this.bufor = bufor;
//     }

//     @Override
//     public void run() {
//         for (int i = 0; i < 100; i++) { // Konsument pobiera 100 elementów
//             bufor.get();
//             try {
//                 Thread.sleep(150); // Przerwa między pobieraniami
//             } catch (InterruptedException e) {
//                 Thread.currentThread().interrupt();
//             }
//         }
//     }
// }

// public class PKmonJCU {
//     public static void main(String[] args) {
//         BuforJCU bufor = new BuforJCU(10); // Bufor o pojemności 10
//         Producent producent = new Producent(bufor);
//         Konsument konsument = new Konsument(bufor);

//         producent.start();
//         konsument.start();

//         try {
//             producent.join();
//             konsument.join();
//         } catch (InterruptedException e) {
//             Thread.currentThread().interrupt();
//         }
//     }
// }

// import java.util.concurrent.ArrayBlockingQueue;
// import java.util.concurrent.BlockingQueue;

// class BuforJCU {
//     private final BlockingQueue<Integer> queue;
//     private long totalPutTime = 0; // Łączny czas dodawania
//     private long totalGetTime = 0; // Łączny czas pobierania
//     private int putCount = 0; // Liczba dodanych elementów
//     private int getCount = 0; // Liczba pobranych elementów

//     public BuforJCU(int capacity) {
//         this.queue = new ArrayBlockingQueue<>(capacity);
//     }

//     public synchronized void put(int value) {
//         long startTime = System.nanoTime();
//         try {
//             queue.put(value);
//             long endTime = System.nanoTime();
//             totalPutTime += (endTime - startTime);
//             putCount++;
//             System.out.printf("Producent dodał: %d | Ilość w buforze: %d | Czas operacji: %d ns\n",
//                     value, queue.size(), (endTime - startTime));
//         } catch (InterruptedException e) {
//             Thread.currentThread().interrupt();
//         }
//     }

//     public synchronized int get() {
//         long startTime = System.nanoTime();
//         try {
//             int value = queue.take();
//             long endTime = System.nanoTime();
//             totalGetTime += (endTime - startTime);
//             getCount++;
//             System.out.printf("Konsument pobrał: %d | Pozostało w buforze: %d | Czas operacji: %d ns\n",
//                     value, queue.size(), (endTime - startTime));
//             return value;
//         } catch (InterruptedException e) {
//             Thread.currentThread().interrupt();
//             return -1; // Wartość domyślna w przypadku przerwania
//         }
//     }

//     public void printAverageTimes() {
//         System.out.printf("Średni czas dodawania: %.2f ns\n", (double) totalPutTime / putCount);
//         System.out.printf("Średni czas pobierania: %.2f ns\n", (double) totalGetTime / getCount);
//     }
// }

// class Producent extends Thread {
//     private final BuforJCU bufor;

//     public Producent(BuforJCU bufor) {
//         this.bufor = bufor;
//     }

//     @Override
//     public void run() {
//         for (int i = 0; i < 100; i++) { // Producent dodaje 100 elementów
//             bufor.put(i);
//             try {
//                 Thread.sleep(100); // Przerwa między dodaniami
//             } catch (InterruptedException e) {
//                 Thread.currentThread().interrupt();
//             }
//         }
//     }
// }

// class Konsument extends Thread {
//     private final BuforJCU bufor;

//     public Konsument(BuforJCU bufor) {
//         this.bufor = bufor;
//     }

//     @Override
//     public void run() {
//         for (int i = 0; i < 100; i++) { // Konsument pobiera 100 elementów
//             bufor.get();
//             try {
//                 Thread.sleep(150); // Przerwa między pobieraniami
//             } catch (InterruptedException e) {
//                 Thread.currentThread().interrupt();
//             }
//         }
//     }
// }

// public class PKmonJCU {
//     public static void main(String[] args) {
//         BuforJCU bufor = new BuforJCU(10); // Bufor o pojemności 10
//         Producent producent = new Producent(bufor);
//         Konsument konsument = new Konsument(bufor);

//         producent.start();
//         konsument.start();

//         try {
//             producent.join();
//             konsument.join();
//         } catch (InterruptedException e) {
//             Thread.currentThread().interrupt();
//         }

//         bufor.printAverageTimes(); // Wydrukuj średnie czasy
//     }
// }

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

class BuforJCU {
    private final BlockingQueue<Integer> queue;
    private long totalPutTime = 0; // Łączny czas dodawania
    private long totalGetTime = 0; // Łączny czas pobierania
    private int putCount = 0; // Liczba dodanych elementów
    private int getCount = 0; // Liczba pobranych elementów

    public BuforJCU(int capacity) {
        this.queue = new ArrayBlockingQueue<>(capacity);
    }

    public void put(int value) {
        long startTime = System.nanoTime();
        try {
            queue.put(value);
            long endTime = System.nanoTime();
            totalPutTime += (endTime - startTime);
            putCount++;
            System.out.printf("Producent dodał: %d | Ilość w buforze: %d | Czas operacji: %d ns\n",
                    value, queue.size(), (endTime - startTime));
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }

    public int get() {
        long startTime = System.nanoTime();
        try {
            int value = queue.take();
            long endTime = System.nanoTime();
            totalGetTime += (endTime - startTime);
            getCount++;
            System.out.printf("Konsument pobrał: %d | Pozostało w buforze: %d | Czas operacji: %d ns\n",
                    value, queue.size(), (endTime - startTime));
            return value;
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            return -1; // Wartość domyślna w przypadku przerwania
        }
    }

    public void printAverageTimes() {
        if (putCount > 0) {
            System.out.printf("Średni czas dodawania: %.2f ns\n", (double) totalPutTime / putCount);
        } else {
            System.out.println("Brak dodanych elementów.");
        }
        if (getCount > 0) {
            System.out.printf("Średni czas pobierania: %.2f ns\n", (double) totalGetTime / getCount);
        } else {
            System.out.println("Brak pobranych elementów.");
        }
    }
}

class Producent extends Thread {
    private final BuforJCU bufor;

    public Producent(BuforJCU bufor) {
        this.bufor = bufor;
    }

    @Override
    public void run() {
        for (int i = 0; i < 100; i++) { // Producent dodaje 100 elementów
            bufor.put(i);
            try {
                Thread.sleep(100); // Przerwa między dodaniami
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }
}

class Konsument extends Thread {
    private final BuforJCU bufor;

    public Konsument(BuforJCU bufor) {
        this.bufor = bufor;
    }

    @Override
    public void run() {
        for (int i = 0; i < 100; i++) { // Konsument pobiera 100 elementów
            bufor.get();
            try {
                Thread.sleep(150); // Przerwa między pobieraniami
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }
}

public class PKmonJCU {
    public static void main(String[] args) {
        BuforJCU bufor = new BuforJCU(10); // Bufor o pojemności 10
        Producent producent = new Producent(bufor);
        Konsument konsument = new Konsument(bufor);

        producent.start();
        konsument.start();

        try {
            producent.join();
            konsument.join();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }

        bufor.printAverageTimes(); // Wydrukuj średnie czasy
    }
}
