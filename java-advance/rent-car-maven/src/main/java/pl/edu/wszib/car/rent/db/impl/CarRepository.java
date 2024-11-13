package pl.edu.wszib.car.rent.db.impl;

import pl.edu.wszib.car.rent.db.ICarRepository;
import pl.edu.wszib.car.rent.model.Car;

import java.util.ArrayList;
import java.util.List;

public class CarRepository implements ICarRepository {
    List<Car> cars = new ArrayList<>();
    private static CarRepository instance = new CarRepository();

    private CarRepository() {
        this.cars.add(new Car("Toyota",  "Corolla",
                2020,  "Red",  "KR11"));
        this.cars.add(new Car("Kia",  "Ceed",
                2021,  "Yellow",  "KR22"));
        this.cars.add(new Car("BMW",  "5",
                2022,  "Black",  "KR33"));
        this.cars.add(new Car("Mercedes",  "C",
                2019,  "White",  "KR44"));
        this.cars.add(new Car("Honda",  "Civic",
                2020,  "Red",  "KR55"));
    }

    @Override
    public boolean rentCar(String plate) {
        for(Car car : this.cars) {
            if(car.getPlate().equals(plate) && !car.isRent()) {
                car.setRent(true);
                return true;
            }
        }
        return false;
    }

    @Override
    public List<Car> getCars() {
        return this.cars;
    }

    public static CarRepository getInstance() {
        return instance;
    }
}
