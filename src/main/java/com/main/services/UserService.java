package com.main.services;

import com.main.dao.UserDAO;
import com.main.entity.User;

public class UserService {
    private UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAO();
    }

    public String createUser(User user) {
        User existUserWithEmail = userDAO.getUserByEmail(user.getEmail());

        if (existUserWithEmail != null) {
            return "The email is already used by the other account";
        }

        userDAO.create(user);
        return null;
    }

    public User getUserById(Integer userId) {
        return this.userDAO.getUserByUserId(userId);
    }

    public String update(User user) {
        User existUserWithEmail = userDAO.getUserByEmailAndNotUserId(user);

        if (existUserWithEmail != null) {
            return "The email is already used by the other account";
        }

        userDAO.update(user);
        return null;
    }

    public void deleteUser(Integer userId) {
        this.userDAO.deleteById(userId);
    }


    public String checkLogin(String email, String password) {
        if (!userDAO.checkLogin(email, password)) {
            return "Wrong username & password";
        }

        return null;

    }
}
