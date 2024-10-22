class SimpleLock {
    private boolean isLocked = false;
    private Thread lockingThread = null;

    public synchronized void lock() throws InterruptedException {
        while (isLocked) {
            wait();
        }
        isLocked = true;
        lockingThread = Thread.currentThread();
    }

    public synchronized void unlock() {
        if (Thread.currentThread() != lockingThread) {
            throw new IllegalStateException("Current thread did not hold the lock");
        }
        isLocked = false;
        lockingThread = null;
        notify();
    }
}

class Counter {
    private int _val;
    private SimpleLock lock = new SimpleLock();

    public Counter(int n) {
        _val = n;
    }

    public void inc() {
        try {
            lock.lock();
            _val++;
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        } finally {
            lock.unlock();
        }
    }

    public void dec() {
        try {
            lock.lock();
            _val--;
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        } finally {
            lock.unlock();
        }
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

    public void run() {
        for (int i = 0; i < 100_000_000; i++) {
            counter.inc();
        }
    }
}

class DThread extends Thread {
    private Counter counter;

    public DThread(Counter counter) {
        this.counter = counter;
    }

    public void run() {
        for (int i = 0; i < 100_000_000; i++) {
            counter.dec();
        }
    }
}

public class RaceCustomLock {
    public static void main(String[] args) {
        Counter cnt = new Counter(0);

        IThread incThread = new IThread(cnt);
        DThread decThread = new DThread(cnt);

        incThread.start();
        decThread.start();

        try {
            incThread.join();
            decThread.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        System.out.println("stan=" + cnt.value());
    }
}
