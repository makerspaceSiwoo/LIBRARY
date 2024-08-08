package com.lib.pjh.service;

import java.security.SecureRandom;

public class CodeGenerator {
    private static final String CHAR_SET = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$";

    public static String generateCode(int length) {
        SecureRandom random = new SecureRandom();
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < length; i++) {
            int index = random.nextInt(CHAR_SET.length());
            builder.append(CHAR_SET.charAt(index));
        }
        return builder.toString();
    }
}