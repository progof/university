// import java.util.ArrayList;
// import java.util.List;

// class Bufor {
//     private final int[] buffer;
//     private int count = 0;
//     private int putIndex = 0;
//     private int getIndex = 0;
//     private final int capacity;

//     public Bufor(int capacity) {
//         this.capacity = capacity;
//         this.buffer = new int[capacity];
//     }

//     public synchronized void put(int value) {
//         long startTime = System.nanoTime();
//         while (count == capacity) {
//             try {
//                 wait();
//             } catch (InterruptedException e) {
//                 Thread.currentThread().interrupt();
//             }
//         }
//         buffer[putIndex] = value;
//         putIndex = (putIndex + 1) % capacity;
//         count++;
//         long endTime = System.nanoTime();
//         System.out.printf("Producent dodał: %d | Ilość w buforze: %d | Czas operacji: %d ns\n",
//                 value, count, (endTime - startTime));
//         notifyAll();
//     }

//     public synchronized int get() {
//         long startTime = System.nanoTime();
//         while (count == 0) {
//             try {
//                 wait();
//             } catch (InterruptedException e) {
//                 Thread.currentThread().interrupt();
//             }
//         }
//         int value = buffer[getIndex];
//         getIndex = (getIndex + 1) % capacity;
//         count--;
//         long endTime = System.nanoTime();
//         System.out.printf("Konsument pobrał: %d | Pozostało w buforze: %d | Czas operacji: %d ns\n",
//                 value, count, (endTime - startTime));
//         notifyAll();
//         return value;
//     }
// }

// class Producent extends Thread {
//     private final Bufor bufor;

//     public Producent(Bufor bufor) {
//         this.bufor = bufor;
//     }

//     public void run() {
//         for (int i = 0; i < 100; ++i) {
//             bufor.put(i);
//             try {
//                 Thread.sleep((long) (Math.random() * 50)); // Losowy czas usypiania producenta
//             } catch (InterruptedException e) {
//                 Thread.currentThread().interrupt();
//             }
//         }
//     }
// }

// class Konsument extends Thread {
//     private final Bufor bufor;
//     private final List<Integer> consumedValues;

//     public Konsument(Bufor bufor) {
//         this.bufor = bufor;
//         this.consumedValues = new ArrayList<>();
//     }

//     public void run() {
//         for (int i = 0; i < 100; ++i) {
//             int value = bufor.get();
//             consumedValues.add(value);
//             try {
//                 Thread.sleep((long) (Math.random() * 100)); // Losowy czas usypiania konsumenta
//             } catch (InterruptedException e) {
//                 Thread.currentThread().interrupt();
//             }
//         }
//         System.out.println("Pobrane wartości: " + consumedValues);
//     }
// }

// public class PKmon {
//     public static void main(String[] args) {
//         Bufor bufor = new Bufor(10);
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

import java.util.ArrayList;
import java.util.List;

class Bufor {
    private final int[] buffer;
    private int count = 0;
    private int putIndex = 0;
    private int getIndex = 0;
    private final int capacity;
    private long totalPutTime = 0; // Łączny czas dodawania
    private long totalGetTime = 0; // Łączny czas pobierania
    private int putCount = 0; // Liczba dodanych elementów
    private int getCount = 0; // Liczba pobranych elementów

    public Bufor(int capacity) {
        this.capacity = capacity;
        this.buffer = new int[capacity];
    }

    public synchronized void put(int value) {
        long startTime = System.nanoTime();
        while (count == capacity) {
            try {
                wait();
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
        buffer[putIndex] = value;
        putIndex = (putIndex + 1) % capacity;
        count++;
        long endTime = System.nanoTime();
        totalPutTime += (endTime - startTime);
        putCount++;
        System.out.printf("Producent dodał: %d | Ilość w buforze: %d | Czas operacji: %d ns\n",
                value, count, (endTime - startTime));
        notifyAll();
    }

    public synchronized int get() {
        long startTime = System.nanoTime();
        while (count == 0) {
            try {
                wait();
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
        int value = buffer[getIndex];
        getIndex = (getIndex + 1) % capacity;
        count--;
        long endTime = System.nanoTime();
        totalGetTime += (endTime - startTime);
        getCount++;
        System.out.printf("Konsument pobrał: %d | Pozostało w buforze: %d | Czas operacji: %d ns\n",
                value, count, (endTime - startTime));
        notifyAll();
        return value;
    }

    public void printAverageTimes() {
        System.out.printf("Średni czas dodawania: %.2f ns\n", (double) totalPutTime / putCount);
        System.out.printf("Średni czas pobierania: %.2f ns\n", (double) totalGetTime / getCount);
    }
}

class Producent extends Thread {
    private final Bufor bufor;

    public Producent(Bufor bufor) {
        this.bufor = bufor;
    }

    public void run() {
        for (int i = 0; i < 100; ++i) {
            bufor.put(i);
            try {
                Thread.sleep((long) (Math.random() * 50)); // Losowy czas usypiania producenta
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }
}

class Konsument extends Thread {
    private final Bufor bufor;
    private final List<Integer> consumedValues;

    public Konsument(Bufor bufor) {
        this.bufor = bufor;
        this.consumedValues = new ArrayList<>();
    }

    public void run() {
        for (int i = 0; i < 100; ++i) {
            int value = bufor.get();
            consumedValues.add(value);
            try {
                Thread.sleep((long) (Math.random() * 100)); // Losowy czas usypiania konsumenta
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
        System.out.println("Pobrane wartości: " + consumedValues);
    }
}

public class PKmon {
    public static void main(String[] args) {
        Bufor bufor = new Bufor(10);
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
