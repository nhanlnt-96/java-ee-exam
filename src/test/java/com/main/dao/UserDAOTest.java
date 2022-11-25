package com.main.dao;

import com.main.entity.User;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

import static org.junit.Assert.*;

public class UserDAOTest {
    private static UserDAO userDAO;

    @BeforeAll
    public static void setup() {
        userDAO = new UserDAO();
    }

    @Test
    public void testGetTotalRecord() {
        fail("Not yet implemented");
    }

    @Test
    public void testCreateUser() {
        User newUser = new User("nhanlnt@hotmail.com", "Thien Nhan", "Nhan1996##");
        User insertedUser = userDAO.create(newUser);

        assertTrue(insertedUser.getUserId() > 0);
    }
}
