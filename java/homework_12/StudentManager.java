import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;

public class StudentManager {
    private Map<String, List<String>> classesMap;

    public StudentManager() {
        classesMap = new HashMap<>();
    }

    public void readStudentsFromFile(String filePath) {
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(" ");
                String studentName = parts[0];
                String classCode = parts[1];

                classesMap.computeIfAbsent(classCode, k -> new LinkedList<>()).add(studentName);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public int numberOfClasses() {
        return classesMap.size();
    }

    public List<String> studentsAttendingClass(String classCode) {
        return classesMap.getOrDefault(classCode, new LinkedList<>());
    }

    public int bigClasses(int limit) {
        return (int) classesMap.values().stream().filter(students -> students.size() > limit).count();
    }

    public List<String> bigClassesList(int limit) {
        return classesMap.entrySet().stream()
                .filter(entry -> entry.getValue().size() > limit)
                .map(Map.Entry::getKey)
                .collect(LinkedList::new, LinkedList::add, LinkedList::addAll);
    }

    public int classNumber(String student) {
        return (int) classesMap.values().stream().filter(students -> students.contains(student)).count();
    }

    public List<String> classList(String student) {
        return classesMap.entrySet().stream()
                .filter(entry -> entry.getValue().contains(student))
                .map(Map.Entry::getKey)
                .collect(LinkedList::new, LinkedList::add, LinkedList::addAll);
    }

    public static void main(String[] args) {
        StudentManager studentManager = new StudentManager();
        studentManager.readStudentsFromFile("students.txt");

        System.out.println("\nNumber of classes: " + studentManager.numberOfClasses());

        String classCodeToCheck = "C39";
        System.out.println("Students attending class " + classCodeToCheck + ": " +
                studentManager.studentsAttendingClass(classCodeToCheck));

        int limit = 3;
        System.out.println("Number of big classes (more than " + limit + " students): " +
                studentManager.bigClasses(limit));

        System.out.println("List of big classes: " + studentManager.bigClassesList(limit));

        String studentToCheck = "Connor";
        System.out.println("Number of classes for student " + studentToCheck + ": " +
                studentManager.classNumber(studentToCheck));

        System.out.println("List of classes for student " + studentToCheck + ": " +
                studentManager.classList(studentToCheck) + "\n");
    }
}
