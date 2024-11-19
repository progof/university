import java.util.concurrent.Semaphore;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

class Fork {
    private final Lock lock = new ReentrantLock();

    public void pickUp() {
        lock.lock(); // Zajmujemy widelec
    }

    public void putDown() {
        lock.unlock(); // Zwolniamy widelec
    }
}

class Philosopher extends Thread {
    private final int id;
    private final Fork leftFork;
    private final Fork rightFork;
    private final Butler butler;
    private int eatCount = 0;

    public Philosopher(int id, Fork leftFork, Fork rightFork, Butler butler) {
        this.id = id;
        this.leftFork = leftFork;
        this.rightFork = rightFork;
        this.butler = butler;
    }

    @Override
    public void run() {
        try {
            while (eatCount < 20) { // Filozof je 20 razy
                think();
                butler.requestPermission(); // Lokaj zezwala na podniesienie widelców
                leftFork.pickUp(); // Podnosimy lewy widelec
                System.out.println("Philosopher-" + id + " picked up the left fork.");
                rightFork.pickUp(); // Podnosimy prawy widelec
                System.out.println("Philosopher-" + id + " picked up the right fork.");
                eat(); // Filozof je
                leftFork.putDown(); // Odkładamy lewy widelec
                System.out.println("Philosopher-" + id + " put down the left fork.");
                rightFork.putDown(); // Odkładamy prawy widelec
                System.out.println("Philosopher-" + id + " put down the right fork.");
                butler.releasePermission(); // Lokaj zwalnia miejsce
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }

    private void think() throws InterruptedException {
        System.out.println("Philosopher-" + id + " is thinking.");
        Thread.sleep((long) (Math.random() * 100)); // Filozof myśli
    }

    private void eat() throws InterruptedException {
        System.out.println("Philosopher-" + id + " is eating.");
        eatCount++;
        Thread.sleep((long) (Math.random() * 100)); // Filozof je
        System.out.println("Philosopher-" + id + " has finished eating " + eatCount + " times.");
    }

    public int getEatCount() {
        return eatCount;
    }
}

class Butler {
    private final Semaphore semaphore;

    public Butler(int numberOfSpots) {
        this.semaphore = new Semaphore(numberOfSpots); // Lokaj pozwala na dostęp tylko do 4 filozofów
    }

    public void requestPermission() throws InterruptedException {
        semaphore.acquire(); // Czekamy, aż pojawi się wolne miejsce
    }

    public void releasePermission() {
        semaphore.release(); // Zwolniamy miejsce dla innego filozofa
    }
}

public class PhilosophersWithButler {
    public static void main(String[] args) {
        int numberOfPhilosophers = 5;
        Fork[] forks = new Fork[numberOfPhilosophers];
        for (int i = 0; i < numberOfPhilosophers; i++) {
            forks[i] = new Fork(); // Tworzymy widelce
        }

        Butler butler = new Butler(numberOfPhilosophers - 1); // Lokaj może kontrolować dostęp do 4 filozofów naraz
        Philosopher[] philosophers = new Philosopher[numberOfPhilosophers];

        long startTime = System.currentTimeMillis(); // Czas rozpoczęcia pomiaru

        for (int i = 0; i < numberOfPhilosophers; i++) {
            philosophers[i] = new Philosopher(i, forks[i], forks[(i + 1) % numberOfPhilosophers], butler);
            philosophers[i].start(); // Uruchamiamy każdy wątek filozofa
        }

        for (Philosopher philosopher : philosophers) {
            try {
                philosopher.join(); // Czekamy, aż filozofowie skończą jeść
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }

        long endTime = System.currentTimeMillis(); // Czas zakończenia pomiaru

        System.out.println("\nStatistics:");
        for (Philosopher philosopher : philosophers) {
            System.out
                    .println("Philosopher-" + philosopher.getName() + " ate " + philosopher.getEatCount() + " times.");
        }

        System.out.println("\nProgram execution time: " + (endTime - startTime) + " ms");
    }
}
