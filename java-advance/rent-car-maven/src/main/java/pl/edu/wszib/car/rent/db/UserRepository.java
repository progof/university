package pl.edu.wszib.car.rent.db;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.codec.digest.DigestUtils;

import pl.edu.wszib.car.rent.model.User;

public class UserRepository {
    List<User> users = new ArrayList<>();
    private static UserRepository instance = new UserRepository();

    private UserRepository() {
        this.users.add(new User("admin", DigestUtils.sha256Hex("adminH3rf3#kd3KJL343tNK$fm3KJ@Io3t3/f23fKf4p02")));
        this.users.add(new User("user", DigestUtils.sha256Hex("userH3rf3#kd3KJL343tNK$fm3KJ@Io3t3/f23fKf4p02")));
    }

    public static UserRepository getInstance() {
        return instance;
    }

    public User getUser(String login) {
        for (User user : this.users) {
            if (user.getLogin().equals(login)) {
                return user;
            }
        }
        return null;
    }

    public List<User> getUsers() {
        return users;
    }
}
