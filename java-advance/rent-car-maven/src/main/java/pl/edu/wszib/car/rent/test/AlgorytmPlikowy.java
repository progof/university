package pl.edu.wszib.car.rent.test;

public class AlgorytmPlikowy extends Algorytm {
    @Override
    void krok1() {
        System.out.printf("Wczytywanie z pliku");
    }

    @Override
    void krok5() {
        System.out.printf("Zapis do pliku");
    }
}
