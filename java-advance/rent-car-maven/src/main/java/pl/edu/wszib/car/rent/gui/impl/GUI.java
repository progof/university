package pl.edu.wszib.car.rent.gui.impl;

import pl.edu.wszib.car.rent.gui.IGUI;
import pl.edu.wszib.car.rent.model.Car;
import pl.edu.wszib.car.rent.model.User;

import java.util.List;
import java.util.Scanner;

public class GUI implements IGUI {
    private Scanner scanner = new Scanner(System.in);

    private static GUI instance = new GUI();

    private GUI() {
    }

    @Override
    public String showMenuAndReadChoice() {
        System.out.println("1. List cars");
        System.out.println("2. Rent car");
        System.out.println("3. Exit");

        return scanner.nextLine();
    }

    @Override
    public void listCars(List<Car> cars) {
        for(Car car : cars) {
            System.out.println(car.getBrand() + " " +
                    car.getModel() + " " + car.getColor() + " " +
                    car.getYear() + " " + car.getPlate() + " " + car.isRent());
        }
    }

    @Override
    public String readPlate() {
        System.out.println("Enter plate:");
        return scanner.nextLine();
    }

    @Override
    public void showResultMessage(boolean result) {
        System.out.println(result ? "Success !!" : "Error !!");
    }

    @Override
    public User aksForCredentials() {
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
