package pl.edu.wszib.car.rent.test;

public abstract class Algorytm {

    public void policz() {
        krok1();
        krok2();
        krok3();
        krok4();
        krok5();
    }

    abstract void krok1();

    private void krok2() {
        System.out.println("Krok 2");
    }
    private void krok3() {
        System.out.println("Krok 3");
    }
    private void krok4() {
        System.out.println("Krok 4");
    }
    abstract void krok5();
}
