package pl.edu.wszib.car.rent.db;

import pl.edu.wszib.car.rent.model.User;

import java.util.List;

public interface IUserRepository {
    User getUser(String login);
    List<User> getUsers();
}
