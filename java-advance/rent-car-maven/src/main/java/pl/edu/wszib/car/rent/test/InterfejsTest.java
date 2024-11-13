package pl.edu.wszib.car.rent.test;

import pl.edu.wszib.car.rent.gui.IGUI;
import pl.edu.wszib.car.rent.model.Car;
import pl.edu.wszib.car.rent.model.User;

import java.util.List;

public class InterfejsTest implements IGUI {
    @Override
    public String showMenuAndReadChoice() {
        return "";
    }

    @Override
    public void listCars(List<Car> cars) {

    }

    @Override
    public String readPlate() {
        return "";
    }

    @Override
    public void showResultMessage(boolean result) {

    }

    @Override
    public User aksForCredentials() {
        return null;
    }
}
