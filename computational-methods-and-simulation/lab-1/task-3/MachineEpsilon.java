public class MachineEpsilon {
    public static void main(String[] args) {
        double epsilon = 1.0;

        while ((epsilon / 2) + 1 > 1) {
            epsilon /= 2;
        }

        System.out.println("Maszynowe epsilon: " + epsilon);
    }
}
