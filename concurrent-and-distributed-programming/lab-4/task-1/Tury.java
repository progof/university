class Sync {
    public int tura = 1;
}

class T1 extends Thread {
    private final Sync s;

    public T1(Sync s) {
        this.s = s;
    }

    @Override
    public void run() {
        for (int i = 0; i < 10; i++) {
            synchronized (s) {
                while (s.tura != 1) {
                    try {
                        s.wait();
                    } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                    }
                }
                System.out.println("Wątek 1");
                s.tura = 2;
                s.notify();
            }
        }
    }
}

class T2 extends Thread {
    private final Sync s;

    public T2(Sync s) {
        this.s = s;
    }

    @Override
    public void run() {
        for (int i = 0; i < 10; i++) {
            synchronized (s) {
                while (s.tura != 2) {
                    try {
                        s.wait();
                    } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                    }
                }
                System.out.println("Wątek 2");
                s.tura = 1;
                s.notify();
            }
        }
    }
}

public class Tury {
    public static void main(String[] args) {
        Sync s = new Sync();
        T1 t1 = new T1(s);
        T2 t2 = new T2(s);
        t1.start();
        t2.start();
    }
}
