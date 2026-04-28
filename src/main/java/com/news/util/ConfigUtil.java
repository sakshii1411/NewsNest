package com.news.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public final class ConfigUtil {
    private static final Properties PROPS = new Properties();

    static {
        try (InputStream in = ConfigUtil.class.getClassLoader().getResourceAsStream("config.properties")) {
            if (in == null) throw new IllegalStateException("config.properties not found");
            PROPS.load(in);
        } catch (IOException e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    private ConfigUtil() {}

    public static String get(String key) {
        return PROPS.getProperty(key);
    }
}
