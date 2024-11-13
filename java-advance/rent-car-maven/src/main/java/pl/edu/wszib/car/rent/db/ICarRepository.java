package pl.edu.wszib.car.rent.db;

import pl.edu.wszib.car.rent.model.Car;

import java.util.List;

public interface ICarRepository {
    boolean rentCar(String plate);
    List<Car> getCars();
}
