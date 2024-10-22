package core;

import GUI.GUI;
import GUI.GUIInterface;
import GUI.GUIv2;
import db.CarRepository;

public class Core {

    private CarRepository carRepository = CarRepository.getInstance();
    private GUIInterface gui = GUIv2.getInstance();
    private static final Core instance = new Core();

    private Core() {
    }

    public void run() {

        boolean isRunning = true;
        while (isRunning) {

            switch (this.gui.showMenu()) {
                case "1":
                    this.gui.listCars(this.carRepository.getCars());
                    break;
                case "2":
                    this.gui.showRentResult(this.carRepository.rentCar(this.gui.readPlate()));

                    break;
                case "3":
                    isRunning = false;
                    break;

                default:
                    System.out.println("Invalid option");
                    break;
            }
        }

    }

    public static Core getInstance() {
        return instance;
    }

}
