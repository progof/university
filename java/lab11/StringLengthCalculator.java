import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.*;
import java.util.stream.Collectors;


public class StringLengthCalculator {

    public static void main(String[] args) {
        try {
            String content = Files.readString(Paths.get("input.dat"));
            String[] words = content.split("\\s+");

            ExecutorService executorService = Executors.newFixedThreadPool(words.length);

            List<Callable<String>> tasks = Arrays.stream(words)
                    .map(word -> (Callable<String>) () -> "The length of string '" + word + "': " + word.length())
                    .collect(Collectors.toList());

            List<Future<String>> futures = executorService.invokeAll(tasks);

            for (Future<String> future : futures) {
                System.out.println(future.get());
            }

            executorService.shutdown();
        } catch (IOException | InterruptedException | ExecutionException e) {
            e.printStackTrace();
        }
    }
}
