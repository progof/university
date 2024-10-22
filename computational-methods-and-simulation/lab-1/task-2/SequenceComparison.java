public class SequenceComparison {
    public static void main(String[] args) {
        final int N = 50;
        float[] floatSequence1 = new float[N];
        float[] floatSequence2 = new float[N];
        double[] doubleSequence1 = new double[N];
        double[] doubleSequence2 = new double[N];

        floatSequence1[0] = 0.01f;
        floatSequence2[0] = 0.01f;
        doubleSequence1[0] = 0.01;
        doubleSequence2[0] = 0.01;

        for (int n = 0; n < N - 1; n++) {
            floatSequence1[n + 1] = floatSequence1[n] + 3.0f * floatSequence1[n] * (1 - floatSequence1[n]);
            doubleSequence1[n + 1] = doubleSequence1[n] + 3.0 * doubleSequence1[n] * (1 - doubleSequence1[n]);
        }

        for (int n = 0; n < N - 1; n++) {
            floatSequence2[n + 1] = 4.0f * floatSequence2[n] - 3.0f * floatSequence2[n] * floatSequence2[n];
            doubleSequence2[n + 1] = 4.0 * doubleSequence2[n] - 3.0 * doubleSequence2[n] * doubleSequence2[n];
        }

        System.out.println("n\tfloat (Wzór 1)\tdouble (Wzór 1)\tfloat (Wzór 2)\tdouble (Wzór 2)");
        for (int n = 0; n < N; n++) {
            System.out.printf("%d\t%.7f\t%.7f\t%.7f\t%.7f%n",
                    n,
                    floatSequence1[n], doubleSequence1[n],
                    floatSequence2[n], doubleSequence2[n]);
        }
    }
}
