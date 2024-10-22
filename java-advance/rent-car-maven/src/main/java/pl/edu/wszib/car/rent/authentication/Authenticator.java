package pl.edu.wszib.car.rent.authentication;

import org.apache.commons.codec.digest.DigestUtils;

import pl.edu.wszib.car.rent.db.UserRepository;
import pl.edu.wszib.car.rent.model.User;

public class Authenticator {
    private static Authenticator instance = new Authenticator();
    private UserRepository userRepository = UserRepository.getInstance();
    private String seed = "H3rf3#kd3KJL343tNK$fm3KJ@Io3t3/f23fKf4p02";

    private Authenticator() {
    }

    public boolean authenticate(User user) {
        User userFromDB = this.userRepository.getUser(user.getLogin());

        return userFromDB != null &&
                user.getPassword()
                        .equals(DigestUtils.sha256Hex(user.getPassword() + this.seed));
    }

    public static Authenticator getInstance() {
        return instance;
    }
}
