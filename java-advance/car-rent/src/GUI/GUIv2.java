package GUI;

import java.util.List;
import java.util.Scanner;

import model.Car;

public class GUIv2 implements GUIInterface {
    private Scanner scanner = new Scanner(System.in);

    private static final GUIv2 instance = new GUIv2();

    private GUIv2() {
    }

    public String showMenu() {
        System.out.println("1. List cars [NEW]");
        System.out.println("2. Rent car");
        System.out.println("3. Exit");
        return scanner.nextLine();
    }

    public void listCars(List<Car> cars) {
        for (Car car : cars) {

            System.out.println(
                    car.getBrand() + " " + car.getModel() + " " + car.getYear() + " " + car.getColor()
                            + " " + car.getPlate() + " " + (car.isRent() ? "Rented" : "Available"));
        }
    }

    public String readPlate() {
        System.out.println("Enter plate number: ");
        ;
        return scanner.nextLine();
    }

    public void showRentResult(boolean result) {
        System.out.println(result ? "Car rented" : "Car not found or already rented");
    }

    public static GUIv2 getInstance() {
        return instance;
    }
}
