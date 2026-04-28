package com.news.model;

import java.io.Serializable;

public class User implements Serializable {
    private int    userId;
    private String name;
    private String email;
    private String password;

    public int    getUserId()           { return userId; }
    public void   setUserId(int id)     { this.userId = id; }
    public String getName()             { return name; }
    public void   setName(String name)  { this.name = name; }
    public String getEmail()            { return email; }
    public void   setEmail(String e)    { this.email = e; }
    public String getPassword()         { return password; }
    public void   setPassword(String p) { this.password = p; }
}
