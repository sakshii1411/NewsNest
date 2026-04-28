package com.news.model;

import java.io.Serializable;

public class Category implements Serializable {
    private int    categoryId;
    private String categoryName;

    public Category() {}
    public Category(int id, String name) { this.categoryId = id; this.categoryName = name; }

    public int    getCategoryId()            { return categoryId; }
    public void   setCategoryId(int id)      { this.categoryId = id; }
    public String getCategoryName()          { return categoryName; }
    public void   setCategoryName(String n)  { this.categoryName = n; }
}
