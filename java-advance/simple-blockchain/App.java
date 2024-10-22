import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

// Класс для представления блока
class Block {
    private String previousHash;
    private String data;
    private String hash;
    private int nonce;

    // Конструктор для создания блока
    public Block(String previousHash, String data) {
        this.previousHash = previousHash;
        this.data = data;
        this.nonce = 0;
        this.hash = mineBlock(); // Поиск хеша, который удовлетворяет условию
    }

    // Метод для поиска хеша, оканчивающегося на 5 нулей
    public String mineBlock() {
        String target = "00000"; // Целевая строка из 5 нулей
        String calculatedHash;
        do {
            nonce++;
            calculatedHash = calculateHash();
        } while (!calculatedHash.endsWith(target)); // Проверка на окончание хеша
        return calculatedHash;
    }

    // Вычисление хеша блока на основе данных, предыдущего хеша и nonce
    public String calculateHash() {
        try {
            return App.hashString(previousHash + data + nonce, "SHA-256");
        } catch (NoSuchAlgorithmException e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }

    // Получение хеша блока
    public String getHash() {
        return hash;
    }

    // Получение предыдущего хеша блока
    public String getPreviousHash() {
        return previousHash;
    }

    @Override
    public String toString() {
        return String.format(
                "Block Details:\n" +
                        "--------------------------------------\n" +
                        "Previous Hash : %s\n" +
                        "Data          : %s\n" +
                        "Hash          : %s\n" +
                        "Nonce         : %d\n" +
                        "--------------------------------------",
                previousHash, data, hash, nonce);
    }
}

// Основной класс приложения
public class App {

    // Метод для хеширования строки
    public static String hashString(String input, String algorithm) throws NoSuchAlgorithmException {
        MessageDigest digest = MessageDigest.getInstance(algorithm);
        byte[] hashBytes = digest.digest(input.getBytes());

        StringBuilder hexString = new StringBuilder();
        for (byte b : hashBytes) {
            String hex = Integer.toHexString(0xff & b);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }
        return hexString.toString();
    }

    // Метод для создания блокчейна и добавления 10 блоков
    public static void main(String[] args) {
        // Создание списка для хранения блоков (блокчейна)
        List<Block> blockchain = new ArrayList<>();

        // Создание первого блока (генезис-блок)
        Block genesisBlock = new Block("0", "Genesis Block");
        blockchain.add(genesisBlock);
        System.out.println("Block 1:\n" + genesisBlock);

        // Добавление последующих блоков
        for (int i = 2; i <= 10; i++) {
            Block previousBlock = blockchain.get(blockchain.size() - 1);
            Block newBlock = new Block(previousBlock.getHash(), "Block " + i + " data");
            blockchain.add(newBlock);
            System.out.println("Block " + i + ":\n" + newBlock);
        }

        // Вывод всех блоков в блокчейне
        System.out.println("\nFull Blockchain:");
        for (Block block : blockchain) {
            System.out.println(block);
        }
    }
}
