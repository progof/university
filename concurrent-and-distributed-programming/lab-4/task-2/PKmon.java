


// import java.util.ArrayList;
// import java.util.List;
// import java.util.concurrent.ArrayBlockingQueue;
// import java.util.concurrent.BlockingQueue;

// // Original Buffer Class using wait()/notify()
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
//         System.out.printf("Producent dodał: %d | Ilość w buforze: %d\n", value, count);
//         notifyAll();
//     }

//     public synchronized int get() {
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
//         System.out.printf("Konsument pobrał: %d | Pozostało w buforze: %d\n", value, count);
//         notifyAll();
//         return value;
//     }
// }

// // Producer Class
// class Producent extends Thread {
//     private final Bufor bufor; // Corrected class name
//     private final int sleepTime;
//     private final List<Integer> producedValues; // Store produced values

//     public Producent(Bufor bufor, int sleepTime) { // Corrected class name
//         this.bufor = bufor;
//         this.sleepTime = sleepTime;
//         this.producedValues = new ArrayList<>(); // Initialize the list
//     }

//     public void run() {
//         for (int i = 0; i < 100; ++i) {
//             bufor.put(i);
//             producedValues.add(i); // Log produced values
//             try {
//                 Thread.sleep(sleepTime);
//             } catch (InterruptedException e) {
//                 Thread.currentThread().interrupt();
//             }
//         }
//         System.out.println("Wszystkie wartości dodane przez producenta: " + producedValues);
//     }
// }

// // Consumer Class
// class Konsument extends Thread {
//     private final Bufor bufor; // Corrected class name
//     private final List<Integer> consumedValues;
//     private final int sleepTime;

//     public Konsument(Bufor bufor, int sleepTime) { // Corrected class name
//         this.bufor = bufor;
//         this.consumedValues = new ArrayList<>();
//         this.sleepTime = sleepTime;
//     }

//     public void run() {
//         for (int i = 0; i < 100; ++i) {
//             int value = bufor.get();
//             consumedValues.add(value);
//             try {
//                 Thread.sleep(sleepTime);
//             } catch (InterruptedException e) {
//                 Thread.currentThread().interrupt();
//             }
//         }
//         System.out.println("Pobrane wartości: " + consumedValues);
//     }
// }

// // Buffer Class using BlockingQueue
// class BuferJCU {
//     private final BlockingQueue<Integer> queue;

//     public BuferJCU(int capacity) {
//         this.queue = new ArrayBlockingQueue<>(capacity);
//     }

//     public void put(int value) throws InterruptedException {
//         queue.put(value);
//         System.out.printf("Producent dodał: %d | Ilość w buforze: %d\n", value, queue.size());
//     }

//     public int get() throws InterruptedException {
//         int value = queue.take();
//         System.out.printf("Konsument pobrał: %d | Pozostało w buforze: %d\n", value, queue.size());
//         return value;
//     }
// }

// // Producer Class for JCU Implementation
// class ProducentJCU extends Thread {
//     private final BuferJCU bufor;
//     private final int sleepTime;
//     private final List<Integer> producedValues; // Store produced values

//     public ProducentJCU(BuferJCU bufor, int sleepTime) {
//         this.bufor = bufor;
//         this.sleepTime = sleepTime;
//         this.producedValues = new ArrayList<>(); // Initialize the list
//     }

//     public void run() {
//         for (int i = 0; i < 100; ++i) {
//             try {
//                 bufor.put(i);
//                 producedValues.add(i); // Log produced values
//                 Thread.sleep(sleepTime);
//             } catch (InterruptedException e) {
//                 Thread.currentThread().interrupt();
//             }
//         }
//         System.out.println("Wszystkie wartości dodane przez producenta JCU: " + producedValues);
//     }
// }

// // Consumer Class for JCU Implementation
// class KonsumentJCU extends Thread {
//     private final BuferJCU bufor;
//     private final List<Integer> consumedValues;
//     private final int sleepTime;

//     public KonsumentJCU(BuferJCU bufor, int sleepTime) {
//         this.bufor = bufor;
//         this.consumedValues = new ArrayList<>();
//         this.sleepTime = sleepTime;
//     }

//     public void run() {
//         for (int i = 0; i < 100; ++i) {
//             try {
//                 int value = bufor.get();
//                 consumedValues.add(value);
//                 Thread.sleep(sleepTime);
//             } catch (InterruptedException e) {
//                 Thread.currentThread().interrupt();
//             }
//         }
//         System.out.println("Pobrane wartości JCU: " + consumedValues);
//     }
// }

// // Main Class
// public class PKmon {
//     public static void main(String[] args) {
//         int[] producerSleepTimes = {50, 100, 150};
//         int[] consumerSleepTimes = {100, 150, 200};

//         for (int producerSleepTime : producerSleepTimes) {
//             for (int consumerSleepTime : consumerSleepTimes) {
//                 System.out.printf("Producent sleep time: %d ms, Konsument sleep time: %d ms\n", producerSleepTime, consumerSleepTime);

//                 // Original Implementation
//                 Bufor bufor = new Bufor(10); // Create original buffer
//                 Producent producent = new Producent(bufor, producerSleepTime); // Use original buffer
//                 Konsument konsument = new Konsument(bufor, consumerSleepTime); // Use original buffer

//                 long startTime = System.nanoTime();
//                 producent.start();
//                 konsument.start();
//                 try {
//                     producent.join();
//                     konsument.join();
//                 } catch (InterruptedException e) {
//                     Thread.currentThread().interrupt();
//                 }
//                 long endTime = System.nanoTime();
//                 long duration = endTime - startTime;
//                 System.out.printf("Czas wykonania (wait/notify): %d ns\n\n", duration);

//                 // JCU Implementation
//                 BuferJCU buforJCU = new BuferJCU(10); // Create JCU buffer
//                 ProducentJCU producentJCU = new ProducentJCU(buforJCU, producerSleepTime); // Use JCU buffer
//                 KonsumentJCU konsumentJCU = new KonsumentJCU(buforJCU, consumerSleepTime); // Use JCU buffer

//                 startTime = System.nanoTime();
//                 producentJCU.start();
//                 konsumentJCU.start();
//                 try {
//                     producentJCU.join();
//                     konsumentJCU.join();
//                 } catch (InterruptedException e) {
//                     Thread.currentThread().interrupt();
//                 }
//                 endTime = System.nanoTime();
//                 duration = endTime - startTime;
//                 System.out.printf("Czas wykonania (BlockingQueue): %d ns\n\n", duration);
//             }
//         }
//     }
// }



// import java.util.ArrayList;
// import java.util.List;
// import java.util.concurrent.ArrayBlockingQueue;
// import java.util.concurrent.BlockingQueue;

// // Original Buffer Class using wait()/notify()
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
//         System.out.printf("Producent dodał: %d | Ilość w buforze: %d\n", value, count);
//         notifyAll();
//     }

//     public synchronized int get() {
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
//         System.out.printf("Konsument pobrał: %d | Pozostało w buforze: %d\n", value, count);
//         notifyAll();
//         return value;
//     }
// }

// // Producer Class
// class Producent extends Thread {
//     private final Bufor bufor;
//     private final int sleepTime;
//     private final List<Integer> producedValues;

//     public Producent(Bufor bufor, int sleepTime) {
//         this.bufor = bufor;
//         this.sleepTime = sleepTime;
//         this.producedValues = new ArrayList<>();
//     }

//     public void run() {
//         for (int i = 0; i < 100; ++i) {
//             bufor.put(i);
//             producedValues.add(i);
//             try {
//                 Thread.sleep(sleepTime);
//             } catch (InterruptedException e) {
//                 Thread.currentThread().interrupt();
//             }
//         }
//     }

//     public List<Integer> getProducedValues() {
//         return producedValues;
//     }
// }

// // Consumer Class
// class Konsument extends Thread {
//     private final Bufor bufor;
//     private final List<Integer> consumedValues;
//     private final int sleepTime;

//     public Konsument(Bufor bufor, int sleepTime) {
//         this.bufor = bufor;
//         this.consumedValues = new ArrayList<>();
//         this.sleepTime = sleepTime;
//     }

//     public void run() {
//         for (int i = 0; i < 100; ++i) {
//             int value = bufor.get();
//             consumedValues.add(value);
//             try {
//                 Thread.sleep(sleepTime);
//             } catch (InterruptedException e) {
//                 Thread.currentThread().interrupt();
//             }
//         }
//     }

//     public List<Integer> getConsumedValues() {
//         return consumedValues;
//     }
// }

// // Buffer Class using BlockingQueue
// class BuferJCU {
//     private final BlockingQueue<Integer> queue;

//     public BuferJCU(int capacity) {
//         this.queue = new ArrayBlockingQueue<>(capacity);
//     }

//     public void put(int value) throws InterruptedException {
//         queue.put(value);
//         System.out.printf("Producent dodał: %d | Ilość w buforze: %d\n", value, queue.size());
//     }

//     public int get() throws InterruptedException {
//         int value = queue.take();
//         System.out.printf("Konsument pobrał: %d | Pozostało w buforze: %d\n", value, queue.size());
//         return value;
//     }
// }

// // Producer Class for JCU Implementation
// class ProducentJCU extends Thread {
//     private final BuferJCU bufor;
//     private final int sleepTime;
//     private final List<Integer> producedValues;

//     public ProducentJCU(BuferJCU bufor, int sleepTime) {
//         this.bufor = bufor;
//         this.sleepTime = sleepTime;
//         this.producedValues = new ArrayList<>();
//     }

//     public void run() {
//         for (int i = 0; i < 100; ++i) {
//             try {
//                 bufor.put(i);
//                 producedValues.add(i);
//                 Thread.sleep(sleepTime);
//             } catch (InterruptedException e) {
//                 Thread.currentThread().interrupt();
//             }
//         }
//     }

//     public List<Integer> getProducedValues() {
//         return producedValues;
//     }
// }

// // Consumer Class for JCU Implementation
// class KonsumentJCU extends Thread {
//     private final BuferJCU bufor;
//     private final List<Integer> consumedValues;
//     private final int sleepTime;

//     public KonsumentJCU(BuferJCU bufor, int sleepTime) {
//         this.bufor = bufor;
//         this.consumedValues = new ArrayList<>();
//         this.sleepTime = sleepTime;
//     }

//     public void run() {
//         for (int i = 0; i < 100; ++i) {
//             try {
//                 int value = bufor.get();
//                 consumedValues.add(value);
//                 Thread.sleep(sleepTime);
//             } catch (InterruptedException e) {
//                 Thread.currentThread().interrupt();
//             }
//         }
//     }

//     public List<Integer> getConsumedValues() {
//         return consumedValues;
//     }
// }

// // Main Class
// public class PKmon {
//     public static void main(String[] args) {
//         // Użyj jednego zestawu czasów snu dla uproszczenia
//         int producerSleepTime = 100;
//         int consumerSleepTime = 150;

//         System.out.printf("Producent sleep time: %d ms, Konsument sleep time: %d ms\n", producerSleepTime, consumerSleepTime);

//         // Original Implementation
//         Bufor bufor = new Bufor(10); // Create original buffer
//         Producent producent = new Producent(bufor, producerSleepTime); // Use original buffer
//         Konsument konsument = new Konsument(bufor, consumerSleepTime); // Use original buffer

//         long startTime = System.nanoTime();
//         producent.start();
//         konsument.start();
//         try {
//             producent.join();
//             konsument.join();
//         } catch (InterruptedException e) {
//             Thread.currentThread().interrupt();
//         }
//         long endTime = System.nanoTime();
//         long duration = endTime - startTime;
//         System.out.printf("Czas wykonania (wait/notify): %d ns\n", duration);
        
//         // Podsumowanie wartości
//         System.out.println("Podsumowanie wartości:");
//         System.out.println("Wartości wyprodukowane przez producenta: " + producent.getProducedValues());
//         System.out.println("Wartości pobrane przez konsumenta: " + konsument.getConsumedValues());

//         // JCU Implementation
//         BuferJCU buforJCU = new BuferJCU(10); // Create JCU buffer
//         ProducentJCU producentJCU = new ProducentJCU(buforJCU, producerSleepTime); // Use JCU buffer
//         KonsumentJCU konsumentJCU = new KonsumentJCU(buforJCU, consumerSleepTime); // Use JCU buffer

//         startTime = System.nanoTime();
//         producentJCU.start();
//         konsumentJCU.start();
//         try {
//             producentJCU.join();
//             konsumentJCU.join();
//         } catch (InterruptedException e) {
//             Thread.currentThread().interrupt();
//         }
//         endTime = System.nanoTime();
//         duration = endTime - startTime;
//         System.out.printf("Czas wykonania (BlockingQueue): %d ns\n", duration);

//         // Podsumowanie wartości JCU
//         System.out.println("Podsumowanie wartości JCU:");
//         System.out.println("Wartości wyprodukowane przez producenta JCU: " + producentJCU.getProducedValues());
//         System.out.println("Wartości pobrane przez konsumenta JCU: " + konsumentJCU.getConsumedValues());
//     }
// }



import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.category.DefaultCategoryDataset;

import javax.swing.*;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

// Original Buffer Class using wait()/notify()
class Bufor {
    private final int[] buffer;
    private int count = 0;
    private int putIndex = 0;
    private int getIndex = 0;
    private final int capacity;

    public Bufor(int capacity) {
        this.capacity = capacity;
        this.buffer = new int[capacity];
    }

    public synchronized void put(int value) {
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
        System.out.printf("Producent dodał: %d | Ilość w buforze: %d\n", value, count);
        notifyAll();
    }

    public synchronized int get() {
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
        System.out.printf("Konsument pobrał: %d | Pozostało w buforze: %d\n", value, count);
        notifyAll();
        return value;
    }
}

// Producer Class
class Producent extends Thread {
    private final Bufor bufor;
    private final int sleepTime;
    private final List<Integer> producedValues;

    public Producent(Bufor bufor, int sleepTime) {
        this.bufor = bufor;
        this.sleepTime = sleepTime;
        this.producedValues = new ArrayList<>();
    }

    public void run() {
        for (int i = 0; i < 100; ++i) {
            bufor.put(i);
            producedValues.add(i);
            try {
                Thread.sleep(sleepTime);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }

    public List<Integer> getProducedValues() {
        return producedValues;
    }
}

// Consumer Class
class Konsument extends Thread {
    private final Bufor bufor;
    private final List<Integer> consumedValues;
    private final int sleepTime;

    public Konsument(Bufor bufor, int sleepTime) {
        this.bufor = bufor;
        this.consumedValues = new ArrayList<>();
        this.sleepTime = sleepTime;
    }

    public void run() {
        for (int i = 0; i < 100; ++i) {
            int value = bufor.get();
            consumedValues.add(value);
            try {
                Thread.sleep(sleepTime);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }

    public List<Integer> getConsumedValues() {
        return consumedValues;
    }
}

// Buffer Class using BlockingQueue
class BuferJCU {
    private final BlockingQueue<Integer> queue;

    public BuferJCU(int capacity) {
        this.queue = new ArrayBlockingQueue<>(capacity);
    }

    public void put(int value) throws InterruptedException {
        queue.put(value);
        System.out.printf("Producent dodał: %d | Ilość w buforze: %d\n", value, queue.size());
    }

    public int get() throws InterruptedException {
        int value = queue.take();
        System.out.printf("Konsument pobrał: %d | Pozostało w buforze: %d\n", value, queue.size());
        return value;
    }
}

// Producer Class for JCU Implementation
class ProducentJCU extends Thread {
    private final BuferJCU bufor;
    private final int sleepTime;
    private final List<Integer> producedValues;

    public ProducentJCU(BuferJCU bufor, int sleepTime) {
        this.bufor = bufor;
        this.sleepTime = sleepTime;
        this.producedValues = new ArrayList<>();
    }

    public void run() {
        for (int i = 0; i < 100; ++i) {
            try {
                bufor.put(i);
                producedValues.add(i);
                Thread.sleep(sleepTime);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }

    public List<Integer> getProducedValues() {
        return producedValues;
    }
}

// Consumer Class for JCU Implementation
class KonsumentJCU extends Thread {
    private final BuferJCU bufor;
    private final List<Integer> consumedValues;
    private final int sleepTime;

    public KonsumentJCU(BuferJCU bufor, int sleepTime) {
        this.bufor = bufor;
        this.consumedValues = new ArrayList<>();
        this.sleepTime = sleepTime;
    }

    public void run() {
        for (int i = 0; i < 100; ++i) {
            try {
                int value = bufor.get();
                consumedValues.add(value);
                Thread.sleep(sleepTime);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }

    public List<Integer> getConsumedValues() {
        return consumedValues;
    }
}

// Main Class
public class PKmon {
    public static void main(String[] args) {
        // Użyj jednego zestawu czasów snu dla uproszczenia
        int producerSleepTime = 100;
        int consumerSleepTime = 150;

        System.out.printf("Producent sleep time: %d ms, Konsument sleep time: %d ms\n", producerSleepTime, consumerSleepTime);

        // Original Implementation
        Bufor bufor = new Bufor(10); // Create original buffer
        Producent producent = new Producent(bufor, producerSleepTime); // Use original buffer
        Konsument konsument = new Konsument(bufor, consumerSleepTime); // Use original buffer

        long startTime = System.nanoTime();
        producent.start();
        konsument.start();
        try {
            producent.join();
            konsument.join();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
        long endTime = System.nanoTime();
        long durationWaitNotify = endTime - startTime;
        System.out.printf("Czas wykonania (wait/notify): %d ns\n", durationWaitNotify);

        // Podsumowanie wartości
        System.out.println("Podsumowanie wartości:");
        System.out.println("Wartości wyprodukowane przez producenta: " + producent.getProducedValues());
        System.out.println("Wartości pobrane przez konsumenta: " + konsument.getConsumedValues());

        // JCU Implementation
        BuferJCU buforJCU = new BuferJCU(10); // Create JCU buffer
        ProducentJCU producentJCU = new ProducentJCU(buforJCU, producerSleepTime); // Use JCU buffer
        KonsumentJCU konsumentJCU = new KonsumentJCU(buforJCU, consumerSleepTime); // Use JCU buffer

        startTime = System.nanoTime();
        producentJCU.start();
        konsumentJCU.start();
        try {
            producentJCU.join();
            konsumentJCU.join();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
        endTime = System.nanoTime();
        long durationBlockingQueue = endTime - startTime;
        System.out.printf("Czas wykonania (BlockingQueue): %d ns\n", durationBlockingQueue);

        // Podsumowanie wartości JCU
        System.out.println("Podsumowanie wartości JCU:");
        System.out.println("Wartości wyprodukowane przez producenta JCU: " + producentJCU.getProducedValues());
        System.out.println("Wartości pobrane przez konsumenta JCU: " + konsumentJCU.getConsumedValues());

        // Tworzenie wykresu
        createChart(durationWaitNotify, durationBlockingQueue);
    }

    private static void createChart(long durationWaitNotify, long durationBlockingQueue) {
        // Tworzenie zestawu danych dla wykresu
        CategoryDataset dataset = createDataset(durationWaitNotify, durationBlockingQueue);

        // Tworzenie wykresu
        JFreeChart chart = ChartFactory.createBarChart(
                "Czas wykonania dla implementacji",
                "Implementacja",
                "Czas (ns)",
                dataset
        );

        // Wyświetlanie wykresu w oknie
        JFrame frame = new JFrame("Wykres");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.add(new ChartPanel(chart));
        frame.pack();
        frame.setVisible(true);
    }

    private static CategoryDataset createDataset(long durationWaitNotify, long durationBlockingQueue) {
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();
        dataset.addValue(durationWaitNotify, "Czas", "wait/notify");
        dataset.addValue(durationBlockingQueue, "Czas", "BlockingQueue");
        return dataset;
    }
}
