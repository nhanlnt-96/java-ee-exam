package com.main.services;

import com.main.dao.UserDAO;
import com.main.entity.User;

public class UserService {
    private static UserDAO userDAO;

    public UserService() {
        userDAO = new UserDAO();
    }

    public String createUser(User user) {
        User existUserWithEmail = userDAO.getUserByEmail(user.getEmail());

        if (existUserWithEmail != null) {
            return "The email is already used by the other account";
        }

        userDAO.create(user);
        return null;
    }
}
