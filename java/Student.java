import java.util.HashMap;
import java.util.Map;
import java.util.Random;

public class Student {
    private String id;
    private String firstName;
    private String lastName;
    private String faculty;
    private Map<String, Integer> subjectsAndMarks;
    private double averageMark;

    public Student(String firstName, String lastName, String faculty) {
        this.id = generateRandomID();
        this.firstName = firstName;
        this.lastName = lastName;
        this.faculty = faculty;
        this.subjectsAndMarks = new HashMap<>();
        this.averageMark = 0.0;
    }

    private String generateRandomID() {
        Random random = new Random();
        int randomID = 100_000 + random.nextInt(900_000); 
        return String.valueOf(randomID);
    }

    public String getId() {
        return id;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getFaculty() {
        return faculty;
    }

    public Map<String, Integer> getSubjectsAndMarks() {
        return subjectsAndMarks;
    }

    public double getAverageMark() {
        return averageMark;
    }

    public void calculateAverage() {
        int totalMarks = 0;
        int numberOfSubjects = 0;

        for (Integer mark : subjectsAndMarks.values()) {
            totalMarks += mark;
            numberOfSubjects++;
        }

        if (numberOfSubjects > 0) {
            averageMark = (double) totalMarks / numberOfSubjects;
        } else {
            averageMark = 0.0;
        }
    }

    public void changeMark(String subject, int newMark) {
        if (newMark >= 2 && newMark <= 5) {
            subjectsAndMarks.put(subject, newMark);
        } else {
            throw new IllegalArgumentException("The ID must consist of exactly 6 digits without the leading 0.");
        }
    }

    @Override
     public String toString() {
     return "Student{" +
            "id: '" + id + '\'' + "\n" +
            "firstName: '" + firstName + '\'' + "\n" +
            "lastName: '" + lastName + '\'' + "\n" +
            "faculty: '" + faculty + '\'' + "\n" +
             "subjectsAndMarks: " + subjectsAndMarks + "\n" +
             "averageMark: " + averageMark + "\n" +
            '}';
     }

    public static void main(String[] args) {
        Student student1 = new Student("Leonardo", "Luciano", "Сomputer science");
        student1.changeMark("Discrete mathematics", 3);
        student1.changeMark("Database", 5);
        student1.changeMark("Networks", 4);
        student1.calculateAverage();
        System.out.println(student1);

        Student student2 = new Student("Anna", "White", "Marketing");
        student2.changeMark("Product creation", 4);
        student2.changeMark("Promotion", 5);
        student2.changeMark("Marketing", 3);
        student2.calculateAverage();
        System.out.println(student2);

        Student student3 = new Student("Robert", "Lee", "Management ");
        student3.changeMark("Economy", 4);
        student3.changeMark("Sociology", 3);
        student3.calculateAverage();
        System.out.println(student3);

        Student student4 = new Student("Joe", "Lee", "Accounting");
        student4.changeMark("Economy", 3);
        student4.changeMark("Taxes", 3);
        student4.changeMark("1C program", 3);
        student4.calculateAverage();
        System.out.println(student4);
    }
}
