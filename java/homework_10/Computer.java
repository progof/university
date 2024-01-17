
public class Computer {
    private final String CPU;
    private final String RAM;
    private final String HDD;

    private final String graphicCard;
    private final String display;
    private final String operatingSystem;

    private Computer(ComputerBuilder builder) {
        this.CPU = builder.CPU;
        this.RAM = builder.RAM;
        this.HDD = builder.HDD;
        this.graphicCard = builder.graphicCard;
        this.display = builder.display;
        this.operatingSystem = builder.operatingSystem;
    }

    public String getCPU() {
        return CPU;
    }

    public String getRAM() {
        return RAM;
    }

    public String getHDD() {
        return HDD;
    }

    public String getGraphicCard() {
        return graphicCard;
    }

    public String getDisplay() {
        return display;
    }

    public String getOperatingSystem() {
        return operatingSystem;
    }

    public static class ComputerBuilder {

        private final String CPU;
        private final String RAM;
        private final String HDD;

        private String graphicCard = "";
        private String display = "";
        private String operatingSystem = "";

        public ComputerBuilder(String CPU, String RAM, String HDD) {
            this.CPU = CPU;
            this.RAM = RAM;
            this.HDD = HDD;
        }

        public ComputerBuilder withGraphicCard(String graphicCard) {
            this.graphicCard = graphicCard;
            return this;
        }

        public ComputerBuilder withDisplay(String display) {
            this.display = display;
            return this;
        }

        public ComputerBuilder withOperatingSystem(String operatingSystem) {
            this.operatingSystem = operatingSystem;
            return this;
        }

        public Computer build() {
            return new Computer(this);
        }
    }

    public static void main(String[] args) {
        Computer computer1 = new ComputerBuilder("Intel i7", "16GB", "2TB SSD")
                .withGraphicCard("NVIDIA GeForce RTX 3070")
                .withOperatingSystem("Windows 11")
                .withDisplay("27-inch 4K")
                .build();

        Computer computer2 = new ComputerBuilder("AMD Ryzen 7", "32GB", "2TB HDD")
                .withOperatingSystem("Ubuntu 23")
                .withDisplay("20-inch HD")
                .build();

        Computer computer3 = new ComputerBuilder("Apple M3 Pro", "18GB", "512GB HDD")
                .withOperatingSystem("MacOS Sonoma")
                .withDisplay("16-inch HD")
                .build();

        System.out.println("Computer 1:");
        System.out.println("CPU: " + computer1.getCPU());
        System.out.println("RAM: " + computer1.getRAM());
        System.out.println("HDD: " + computer1.getHDD());
        System.out.println("Graphic Card: " + computer1.getGraphicCard());
        System.out.println("Display: " + computer1.getDisplay());
        System.out.println("Operating System: " + computer1.getOperatingSystem());
        System.out.println();

        System.out.println("Computer 2:");
        System.out.println("CPU: " + computer2.getCPU());
        System.out.println("RAM: " + computer2.getRAM());
        System.out.println("HDD: " + computer2.getHDD());
        System.out.println("Graphic Card: " + computer2.getGraphicCard());
        System.out.println("Display: " + computer2.getDisplay());
        System.out.println("Operating System: " + computer2.getOperatingSystem());
        System.out.println();

        System.out.println("Computer 3:");
        System.out.println("CPU: " + computer3.getCPU());
        System.out.println("RAM: " + computer3.getRAM());
        System.out.println("HDD: " + computer3.getHDD());
        System.out.println("Graphic Card: " + computer3.getGraphicCard());
        System.out.println("Display: " + computer3.getDisplay());
        System.out.println("Operating System: " + computer3.getOperatingSystem());
    }
}
