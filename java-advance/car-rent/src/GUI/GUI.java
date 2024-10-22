package GUI;

import java.util.List;
import java.util.Scanner;

import model.Car;

public class GUI implements GUIInterface {

    private Scanner scanner = new Scanner(System.in);

    @Override
    public String showMenu() {
        System.out.println("1. List cars");
        System.out.println("2. Rent car");
        System.out.println("3. Exit");
        return scanner.nextLine();
    }

    @Override
    public void listCars(List<Car> cars) {
        for (Car car : cars) {

            System.out.println(
                    car.getBrand() + " " + car.getModel() + " " + car.getYear() + " " + car.getColor()
                            + " " + car.getPlate() + " " + (car.isRent() ? "Rented" : "Available"));
        }
    }

    @Override
    public String readPlate() {
        System.out.println("Enter plate number: ");
        ;
        return scanner.nextLine();
    }

    @Override
    public void showRentResult(boolean result) {
        System.out.println(result ? "Car rented" : "Car not found or already rented");
    }
}
