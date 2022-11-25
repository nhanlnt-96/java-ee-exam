package com.main.utils;

public class BCrypt {
    public static String hashPassword(String password) {
        return at.favre.lib.crypto.bcrypt.BCrypt.withDefaults().hashToString(12, password.toCharArray());
    }

    public static boolean verifyPassword(String passwordInput, String passwordHashed) {
        return at.favre.lib.crypto.bcrypt.BCrypt.verifyer().verify(passwordInput.toCharArray(), passwordHashed).verified;
    }
}
