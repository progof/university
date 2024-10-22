package pl.edu.wszib.car.rent.core;

import pl.edu.wszib.car.rent.db.CarRepository;
import pl.edu.wszib.car.rent.db.ICarRepository;
import pl.edu.wszib.car.rent.gui.IGUI;
import pl.edu.wszib.car.rent.gui.GUI;
import pl.edu.wszib.car.rent.authentication.Authenticator;

public class Core implements ICore {
    private ICarRepository carRepository = CarRepository.getInstance();
    private IGUI gui = GUI.getInstance();
    private Authenticator authenticator = Authenticator.getInstance();
    private static final Core instance = new Core();

    private Core() {
    }

    public void run() {

        boolean running = this.authenticator.authenticate(this.gui.askForCredentials());
        while (running) {
            switch (this.gui.showMenuAndReadChoice()) {
                case "1":
                    this.gui.listCars(this.carRepository.getCars());
                    break;
                case "2":
                    this.gui.showResultMessage(this.carRepository.rentCar(this.gui.readPlate()));
                    break;
                case "3":
                    running = false;
                    break;
                default:
                    System.out.println("Incorrect choice !!");
                    break;
            }
        }
    }

    public static Core getInstance() {
        return instance;
    }
}
