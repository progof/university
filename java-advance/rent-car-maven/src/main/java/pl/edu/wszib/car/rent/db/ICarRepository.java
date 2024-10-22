package pl.edu.wszib.car.rent.db;

import java.util.List;

import pl.edu.wszib.car.rent.model.Car;

public interface ICarRepository {
    void addCar(Car car);

    void removeCar(String plate);

    Car getCar(String plate);

    List<Car> getAllCars();

}