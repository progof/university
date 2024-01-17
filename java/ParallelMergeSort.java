import java.util.Arrays;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveAction;

public class ParallelMergeSort extends RecursiveAction {
    private static final int THRESHOLD = 10000; 
    private double[] array;
    private int low;
    private int high;

    public ParallelMergeSort(double[] array, int low, int high) {
        this.array = array;
        this.low = low;
        this.high = high;
    }

    @Override
    protected void compute() {
        if (high - low <= THRESHOLD) {
            Arrays.sort(array, low, high);
        } else {
            int mid = low + (high - low) / 2;

            ParallelMergeSort leftTask = new ParallelMergeSort(array, low, mid);
            ParallelMergeSort rightTask = new ParallelMergeSort(array, mid, high);
            invokeAll(leftTask, rightTask);

            merge(mid);
        }
    }

    private void merge(int mid) {
        int leftSize = mid - low;
        int rightSize = high - mid;

        double[] leftArray = Arrays.copyOfRange(array, low, mid);
        double[] rightArray = Arrays.copyOfRange(array, mid, high);

        int leftIndex = 0;
        int rightIndex = 0;
        int currentIndex = low;

        while (leftIndex < leftSize && rightIndex < rightSize) {
            if (leftArray[leftIndex] < rightArray[rightIndex]) {
                array[currentIndex++] = leftArray[leftIndex++];
            } else {
                array[currentIndex++] = rightArray[rightIndex++];
            }
        }

        while (leftIndex < leftSize) {
            array[currentIndex++] = leftArray[leftIndex++];
        }

        while (rightIndex < rightSize) {
            array[currentIndex++] = rightArray[rightIndex++];
        }
    }

    public static void main(String[] args) {
        double[] array = new double[1000000];
        for (int i = 0; i < array.length; i++) {
            array[i] = Math.random();
        }

        ForkJoinPool forkJoinPool = new ForkJoinPool();

        ParallelMergeSort task = new ParallelMergeSort(array, 0, array.length);
        forkJoinPool.invoke(task);

        boolean isSorted = true;
        for (int i = 1; i < array.length; i++) {
            if (array[i - 1] > array[i]) {
                isSorted = false;
                break;
            }
        }

        if (isSorted) {
            System.out.println("Sorting completed successfully.");
        } else {
            System.out.println("Error when sorting.");
        }
    }
}
