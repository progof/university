package pl.edu.wszib.car.rent.model;

import lombok.*;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class Truck {
    private String brand;
    private String model;
    private int year;
    private String color;
    private String plate;
    private boolean rent;
    private int capacity;

    public Truck(String brand, String model, int year, String color, String plate, boolean rent, int capacity) {
        this.brand = brand;
        this.model = model;
        this.year = year;
        this.color = color;
        this.plate = plate;
        this.rent = rent;
        this.capacity = capacity;
    }

}
