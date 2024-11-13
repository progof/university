// import java.util.concurrent.*;
// import java.util.concurrent.atomic.AtomicInteger;
// import java.util.concurrent.locks.Condition;
// import java.util.concurrent.locks.Lock;
// import java.util.concurrent.locks.ReentrantLock;

// public class ReaderWriterProblem {

// // Implementacja z użyciem Semaforów
// static class LibraryWithSemaphores {
// private final Semaphore readLock = new Semaphore(1, true);
// private final Semaphore writeLock = new Semaphore(1, true);
// private final AtomicInteger readersCount = new AtomicInteger(0);

// public void startReading() throws InterruptedException {
// readLock.acquire();
// if (readersCount.incrementAndGet() == 1) {
// writeLock.acquire();
// }
// readLock.release();
// }

// public void finishReading() throws InterruptedException {
// readLock.acquire();
// if (readersCount.decrementAndGet() == 0) {
// writeLock.release();
// }
// readLock.release();
// }

// public void startWriting() throws InterruptedException {
// writeLock.acquire();
// }

// public void finishWriting() {
// writeLock.release();
// }
// }

// // Implementacja z użyciem Zmiennych Warunkowych
// static class LibraryWithConditions {
// private final Lock lock = new ReentrantLock(true);
// private final Condition canRead = lock.newCondition();
// private final Condition canWrite = lock.newCondition();
// private int readers = 0;
// private int writers = 0;
// private boolean isWriting = false;

// public void startReading() throws InterruptedException {
// lock.lock();
// try {
// while (writers > 0 || isWriting) {
// canRead.await();
// }
// readers++;
// } finally {
// lock.unlock();
// }
// }

// public void finishReading() {
// lock.lock();
// try {
// readers--;
// if (readers == 0) {
// canWrite.signal();
// }
// } finally {
// lock.unlock();
// }
// }

// public void startWriting() throws InterruptedException {
// lock.lock();
// try {
// writers++;
// while (readers > 0 || isWriting) {
// canWrite.await();
// }
// isWriting = true;
// } finally {
// lock.unlock();
// }
// }

// public void finishWriting() {
// lock.lock();
// try {
// isWriting = false;
// writers--;
// if (writers == 0) {
// canRead.signalAll();
// } else {
// canWrite.signal();
// }
// } finally {
// lock.unlock();
// }
// }
// }

// // Test wydajności dla obu implementacji
// public static void main(String[] args) throws InterruptedException {
// int readersCount = 50; // Przykładowa liczba czytelników
// int writersCount = 5; // Przykładowa liczba pisarzy

// System.out.println("Testing LibraryWithSemaphores:");
// LibraryWithSemaphores libraryWithSemaphores = new LibraryWithSemaphores();
// testLibrary(libraryWithSemaphores, readersCount, writersCount);

// System.out.println("\nTesting LibraryWithConditions:");
// LibraryWithConditions libraryWithConditions = new LibraryWithConditions();
// testLibrary(libraryWithConditions, readersCount, writersCount);
// }

// private static void testLibrary(Object library, int readersCount, int
// writersCount) throws InterruptedException {
// ExecutorService executor = Executors.newFixedThreadPool(readersCount +
// writersCount);
// long startTime = System.currentTimeMillis();

// for (int i = 0; i < readersCount; i++) {
// executor.submit(() -> {
// try {
// if (library instanceof LibraryWithSemaphores) {
// ((LibraryWithSemaphores) library).startReading();
// Thread.sleep(100);
// ((LibraryWithSemaphores) library).finishReading();
// } else if (library instanceof LibraryWithConditions) {
// ((LibraryWithConditions) library).startReading();
// Thread.sleep(100);
// ((LibraryWithConditions) library).finishReading();
// }
// } catch (InterruptedException e) {
// Thread.currentThread().interrupt();
// }
// });
// }

// for (int i = 0; i < writersCount; i++) {
// executor.submit(() -> {
// try {
// if (library instanceof LibraryWithSemaphores) {
// ((LibraryWithSemaphores) library).startWriting();
// Thread.sleep(200);
// ((LibraryWithSemaphores) library).finishWriting();
// } else if (library instanceof LibraryWithConditions) {
// ((LibraryWithConditions) library).startWriting();
// Thread.sleep(200);
// ((LibraryWithConditions) library).finishWriting();
// }
// } catch (InterruptedException e) {
// Thread.currentThread().interrupt();
// }
// });
// }

// executor.shutdown();
// executor.awaitTermination(1, TimeUnit.MINUTES);

// long endTime = System.currentTimeMillis();
// System.out.println("Execution time: " + (endTime - startTime) + " ms");
// }
// }
