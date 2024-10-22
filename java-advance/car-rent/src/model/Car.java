package model;

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

    public Car(String brand, String model, int year,
            String color, String plate) {
        this(brand, model, year, color, plate, false);
    }

    public String getPlate() {
        return plate;
    }

    public void setRent(boolean rent) {
        this.rent = rent;
    }

    public boolean isRent() {
        return rent;
    }

    public String getBrand() {
        return brand;
    }

    public String getModel() {
        return model;
    }

    public int getYear() {
        return year;
    }

    public String getColor() {
        return color;
    }
}
