package pl.edu.wszib.car.rent.test;

public class AlgorytmDB extends Algorytm {
    @Override
    void krok1() {
        System.out.printf("Wczytuje z bazy");
    }

    @Override
    void krok5() {
        System.out.printf("Zapisuje do bazy");
    }
}
