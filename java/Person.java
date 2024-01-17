import java.util.Arrays;
import java.util.Comparator;

public class Person {
    private String firstName;
    private String lastName;
    private int age;

    public Person(String firstName, String lastName, int age) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.age = age;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public int getAge() {
        return age;
    }

    @Override
    public String toString() {
        return "Person {" + "firstName: '" + firstName + '\'' + ", lastName: '" + lastName + '\'' + ", age: " + age + '}';
    }

    public static void main(String[] args) {
        Person[] people = {
                new Person("Tom", "Lee", 63),
                new Person("William", "White", 27),
                new Person("Bob", "Barax", 35),
                new Person("Jacek", "Pietrowski", 40),
                new Person("Lucy", "Nest", 22),
                new Person("Adam", "Newton", 51),
        };

        System.out.println("Original array:");
        printArray(people);

        Arrays.sort(people, Comparator.comparing(Person::getFirstName));
        System.out.println("\nSorted by first name:");
        printArray(people);

        Arrays.sort(people, Comparator.comparing(Person::getLastName));
        System.out.println("\nSorted by last name:");
        printArray(people);

        Arrays.sort(people, Comparator.comparingInt(Person::getAge));
        System.out.println("\nSorted by age:");
        printArray(people);
    }

    private static void printArray(Person[] people) {
        for (Person person : people) {
            System.out.println(person);
        }
    }

    private static void sort(Person[] array, Comparator<Person> comparator) {
        Arrays.sort(array, comparator);
    }
}
