public class SequenceTask1 {

    public static void main(String[] args) {
        float x0_float = 0.01f;
        double x0_double = 0.01;

        int iterations = 50;

        System.out.println("Reprezentacja float:");
        calculateSequenceFloat(x0_float, iterations);

        System.out.println("\nReprezentacja double:");
        calculateSequenceDouble(x0_double, iterations);
    }

    public static void calculateSequenceFloat(float x, int iterations) {
        for (int i = 0; i < iterations; i++) {
            System.out.printf("n = %d, x = %.10f\n", i, x);
            x = x + 3.0f * x * (1 - x);
        }
    }

    public static void calculateSequenceDouble(double x, int iterations) {
        for (int i = 0; i < iterations; i++) {
            System.out.printf("n = %d, x = %.15f\n", i, x);
            x = x + 3.0 * x * (1 - x);
        }
    }
}
