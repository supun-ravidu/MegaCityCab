package com.reservation.utils;

import org.mindrot.jbcrypt.BCrypt;

public class UserUtils {
    // Method to hash the password
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

    // Method to check if the password matches the stored hashed password
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}
