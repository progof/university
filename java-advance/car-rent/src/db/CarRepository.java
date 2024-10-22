package db;

import java.util.ArrayList;
import java.util.List;

import model.Car;

public class CarRepository {
    List<Car> cars = new ArrayList<>();
    private static CarRepository instance = new CarRepository();

    private CarRepository() {
        this.cars.add(new Car("Toyota", "Corolla", 2019, "White", "ABC-1234"));
        this.cars.add(new Car("Toyota", "Camry", 2018, "Black", "DEF-5678"));
        this.cars.add(new Car("Honda", "Civic", 2017, "Red", "GHI-9101"));
        this.cars.add(new Car("Honda", "Accord", 2016, "Blue", "JKL-1121"));
        this.cars.add(new Car("Nissan", "Sentra", 2015, "Silver", "MNO-3141"));
        this.cars.add(new Car("Nissan", "Altima", 2014, "Gray", "PQR-5161"));
        this.cars.add(new Car("BMW", "X5", 2019, "Black", "STU-7181"));
    }

    public boolean rentCar(String plate) {
        for (Car car : this.cars) {
            if (car.getPlate().equals(plate) && !car.isRent()) {
                car.setRent(true);
                return true;
            }
        }
        return false;
    }

    public List<Car> getCars() {
        return this.cars;
    }

    public static CarRepository getInstance() {
        return instance;
    }
}
