package GUI;

import java.util.List;

import model.Car;

public interface GUIInterface {
    String showMenu();

    void listCars(List<Car> cars);

    String readPlate();

    void showRentResult(boolean result);
}
