package pl.edu.wszib.car.rent.gui;

import pl.edu.wszib.car.rent.model.Car;
import pl.edu.wszib.car.rent.model.User;

import java.util.List;
import java.util.Scanner;

public class GUI implements IGUI {
    private Scanner scanner = new Scanner(System.in);
    private static GUI instance = new GUI();

    private GUI() {
    }

    public String showMenuAndReadChoice() {
        System.out.println("1. List cars");
        System.out.println("2. Rent car");
        System.out.println("3. Exit");

        return scanner.nextLine();
    }

    public void listCars(List<Car> cars) {
        for (Car car : cars) {
            System.out.println(car.getBrand() + " " +
                    car.getModel() + " " + car.getColor() + " " +
                    car.getYear() + " " + car.getPlate() + " " + car.isRent());
        }
    }

    public String readPlate() {
        System.out.println("Enter plate:");
        return scanner.nextLine();
    }

    public void showResultMessage(boolean result) {
        System.out.println(result ? "Success !!" : "Error !!");
    }

    public User askForCredentials() {
        User user = new User();

        System.out.println("Enter login:");
        user.setLogin(scanner.nextLine());
        System.out.println("Enter password:");
        user.setPassword(scanner.nextLine());

        return user;
    }

    public static GUI getInstance() {
        return instance;
    }
}
