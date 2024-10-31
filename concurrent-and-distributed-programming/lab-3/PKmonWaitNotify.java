import java.util.ArrayList;
import java.util.List;

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

class Producent extends Thread {
    private final Bufor bufor;

    public Producent(Bufor bufor) {
        this.bufor = bufor;
    }

    public void run() {
        for (int i = 0; i < 100; ++i) {
            bufor.put(i);
            try {
                Thread.sleep(50);
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
                Thread.sleep(100);
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
        konsuPKmonWaitNotifystart();

        try {
            producent.join();
            konsument.join();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }
}
