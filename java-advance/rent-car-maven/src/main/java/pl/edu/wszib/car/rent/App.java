package pl.edu.wszib.car.rent;

import pl.edu.wszib.car.rent.core.Core;
import pl.edu.wszib.car.rent.db.CarRepository;

public class App {
    public static void main(String[] args) {
        Core.getInstance().run();
    }
}
