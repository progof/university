interface Vehicle {
    void start();
    void stop();
}

class Car implements Vehicle {
    private String make;
    private String color;
    private String model;
    private int year;

    public Car (String make, String color, String model, int year) {
        this.make = make;
        this.color = color;
        this.model = model;
        this.year = year;
    }

    @Override
    public void start() {
        System.out.println("Car: " + make + " is starting...");
    }

    @Override
    public void stop() {
        System.out.println("Car: " + make + " is stopping...");
    }

    @Override
    public String toString() {
        return year + " " + color + " " + make + " " + model;
    }
}

public class CarSimulation {
    public static void main(String[] args) {
        Car car1 = new Car("Lexus", "Blue", "X350", 2023);
        Car car2 = new Car("Porche", "Red", "Cayan", 2021);
        Car car3 = new Car("Mercedez-Benz", "Black", "E200", 2021);

        car1.start();
        car1.stop();

        car2.start();
        car2.stop();

        car3.start();
        car3.stop();

        System.out.println("Car 1: " + car1.toString());
        System.out.println("Car 2: " + car2.toString());
        System.out.println("Car 3: " + car3.toString());
    }
}
