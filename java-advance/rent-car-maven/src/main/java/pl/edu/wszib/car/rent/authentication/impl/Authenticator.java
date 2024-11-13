package pl.edu.wszib.car.rent.authentication.impl;

import org.apache.commons.codec.digest.DigestUtils;
import pl.edu.wszib.car.rent.authentication.IAuthenticator;
import pl.edu.wszib.car.rent.db.impl.UserRepository;
import pl.edu.wszib.car.rent.model.User;

public class Authenticator implements IAuthenticator {
    private static Authenticator instance = new Authenticator();
    private UserRepository userRepository = UserRepository.getInstance();
    private String seed = "sy2eL273fTUxQoH3Zlm7wM4ZzK3bR4Gh";

    private Authenticator() {
    }

    @Override
    public boolean authenticate(User user) {
        User userFromDb = this.userRepository.getUser(user.getLogin());
        return userFromDb != null &&
                userFromDb.getPassword()
                        .equals(DigestUtils.md5Hex(user.getPassword()+seed));
    }

    public static Authenticator getInstance() {
        return instance;
    }
}
