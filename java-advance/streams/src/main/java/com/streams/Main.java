package com.streams;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class Main {

    public static void main(String[] args) {
        List<Integer> numbers = Arrays.asList(45, 39, 17, 25, 10, 4);
        System.out.println("\n" + "Average: " + calculateAverageExcluding9and7(numbers) + "\n");

        List<Integer> numbersForSquares = Arrays.asList(3, 10, 9, 4);
        System.out.println("Results not containing numbers 9: " + calculateSquaresAndAddNine(numbersForSquares) + "\n");

        List<String> strings = Arrays.asList("aa", "cy", "b", "yycd", "c");
        System.out.println("Strings with 'y',omitting those of 'yy': " + modifyStrings(strings) + "\n");
    }

    public static double calculateAverageExcluding9and7(List<Integer> numbers) {
        return numbers.stream()
                .filter(n -> !(n % 10 == 9 || n % 10 == 7))
                .mapToInt(Integer::intValue)
                .average()
                .orElse(0.0);
    }

    public static List<Integer> calculateSquaresAndAddNine(List<Integer> numbers) {
        return numbers.stream()
                .map(n -> n * n + 9)
                .filter(n -> !String.valueOf(n).contains("9"))
                .collect(Collectors.toList());
    }

    public static List<String> modifyStrings(List<String> strings) {
        return strings.stream()
                .map(s -> s + "y")
                .filter(s -> !s.contains("yy"))
                .collect(Collectors.toList());
    }
}
