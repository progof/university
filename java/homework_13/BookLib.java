import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

record Book(String name, int releaseYear, String isbn) {
    String getBookInfo() {
        return "Book[name=" + name + ", releaseYear=" + releaseYear + ", isbn=" + isbn + "]";
    }
}

public class BookLib {
    public static void main(String[] args) {
        List<Book> bookList = List.of(
                new Book("The Fellowship of the Ring", 1954, "0395489318"),
                new Book("The Two Towers", 1954, "0345339711"),
                new Book("The Return of the King", 1955, "0618129111"));

        Map<String, String> isbnToTitleMap = bookList.stream()
                .collect(Collectors.toMap(Book::isbn, Book::name));

        Map<Integer, Book> releaseYearToBookMap = bookList.stream()
                .collect(Collectors.toMap(Book::releaseYear, b -> b, (existing, replacement) -> existing));

        System.out.println("ISBN to Title Map:");
        isbnToTitleMap.forEach((isbn, title) -> System.out.println(isbn + " -> " + title));

        System.out.println();

        System.out.println("Release Year to Book Map:");
        releaseYearToBookMap.forEach((year, book) -> System.out.println(year + " -> " + book.getBookInfo()));

        System.out.println();

        System.out.println("Books by Release Year:");
        Map<Integer, List<Book>> booksByReleaseYear = bookList.stream()
                .collect(Collectors.groupingBy(Book::releaseYear));

        booksByReleaseYear.forEach((year, books) -> {
            System.out.println(year + " -> " + books.stream()
                    .map(Book::getBookInfo)
                    .collect(Collectors.toList()));
        });
    }
}
