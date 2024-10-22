package pl.edu.wszib.car.rent.model;

public class Car {
    private String brand;
    private String model;
    private int year;
    private String color;
    private String plate;
    private boolean rent;

    public Car(String brand, String model, int year, String color, String plate, boolean rent) {
        this.brand = brand;
        this.model = model;
        this.year = year;
        this.color = color;
        this.plate = plate;
        this.rent = rent;
    }

    public Car(String brand, String model, int year, String color, String plate) {
        this(brand, model, year, color, plate, false);
    }

    public Car() {
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getPlate() {
        return plate;
    }

    public void setPlate(String plate) {
        this.plate = plate;
    }

    public boolean isRent() {
        return rent;
    }

    public void setRent(boolean rent) {
        this.rent = rent;
    }
}
