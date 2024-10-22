package pl.edu.wszib.car.rent.db;

import java.util.List;

import pl.edu.wszib.car.rent.model.User;

public interface IUserRepository {
    void addUser(User user);

    void removeUser(String login);

    User getUser(String login);

    List<User> getAllUsers();
}