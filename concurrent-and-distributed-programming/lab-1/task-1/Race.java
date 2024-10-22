import java.util.HashSet;

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

public class Race {
    public static void main(String[] args) {
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

        System.out.println("stan=" + cnt.value());
    }
}
