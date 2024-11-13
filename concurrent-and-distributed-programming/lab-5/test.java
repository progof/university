// import java.util.concurrent.*;
// import java.util.concurrent.atomic.AtomicInteger;
// import java.util.concurrent.locks.Condition;
// import java.util.concurrent.locks.Lock;
// import java.util.concurrent.locks.ReentrantLock;

// public class ReaderWriterProblem {

// static class LibraryWithSemaphores {
// private final Semaphore writeLock = new Semaphore(1, true);
// private final AtomicInteger readersCount = new AtomicInteger(0);
// private final boolean prioritizeWriters;

// public LibraryWithSemaphores(boolean prioritizeWriters) {
// this.prioritizeWriters = prioritizeWriters;
// }

// public void startReading() throws InterruptedException {
// if (prioritizeWriters) {
// writeLock.acquire();
// writeLock.release();
// }
// readersCount.incrementAndGet();
// if (readersCount.get() == 1) {
// writeLock.acquire();
// }
// }

// public void finishReading() {
// if (readersCount.decrementAndGet() == 0) {
// writeLock.release();
// }
// }

// public void startWriting() throws InterruptedException {
// writeLock.acquire();
// }

// public void finishWriting() {
// writeLock.release();
// }
// }

// static class LibraryWithConditions {
// private final Lock lock = new ReentrantLock(true);
// private final Condition canRead = lock.newCondition();
// private final Condition canWrite = lock.newCondition();
// private int readers = 0;
// private int writers = 0;
// private boolean isWriting = false;
// private final boolean prioritizeWriters;

// public LibraryWithConditions(boolean prioritizeWriters) {
// this.prioritizeWriters = prioritizeWriters;
// }

// public void startReading() throws InterruptedException {
// lock.lock();
// try {
// while (writers > 0 || isWriting || (prioritizeWriters && writers > 0)) {
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

// public static void main(String[] args) throws InterruptedException {
// int[] readersCounts = { 10, 50, 100 };
// int[] writersCounts = { 1, 5, 10 };
// boolean prioritizeWriters = true;

// for (int readersCount : readersCounts) {
// for (int writersCount : writersCounts) {
// System.out.println("\n[Config] Readers: " + readersCount + ", Writers: " +
// writersCount);

// System.out.println("\n--- Testing LibraryWithSemaphores ---");
// LibraryWithSemaphores libraryWithSemaphores = new
// LibraryWithSemaphores(prioritizeWriters);
// testLibrary(libraryWithSemaphores, readersCount, writersCount);

// System.out.println("\n--- Testing LibraryWithConditions ---");
// LibraryWithConditions libraryWithConditions = new
// LibraryWithConditions(prioritizeWriters);
// testLibrary(libraryWithConditions, readersCount, writersCount);
// System.out.println("-----------------------------------\n");
// }
// }
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
// Thread.sleep(50);
// ((LibraryWithSemaphores) library).finishReading();
// } else if (library instanceof LibraryWithConditions) {
// ((LibraryWithConditions) library).startReading();
// Thread.sleep(50);
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
// Thread.sleep(100);
// ((LibraryWithSemaphores) library).finishWriting();
// } else if (library instanceof LibraryWithConditions) {
// ((LibraryWithConditions) library).startWriting();
// Thread.sleep(100);
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
// System.out.println("Execution time: " + (endTime - startTime) + " ms\n");
// }
// }