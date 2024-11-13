package pl.edu.wszib.car.rent.authentication;

import pl.edu.wszib.car.rent.model.User;

public interface IAuthenticator {
    boolean authenticate(User user);
}
