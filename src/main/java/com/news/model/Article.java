package com.news.model;

import java.io.Serializable;

public class Article implements Serializable {
    private String title;
    private String description;
    private String url;
    private String imageUrl;
    private String source;
    private String publishedAt;
    private String category;

    public String getTitle()                  { return title; }
    public void   setTitle(String t)          { this.title = t; }
    public String getDescription()            { return description; }
    public void   setDescription(String d)    { this.description = d; }
    public String getUrl()                    { return url; }
    public void   setUrl(String u)            { this.url = u; }
    public String getImageUrl()               { return imageUrl; }
    public void   setImageUrl(String i)       { this.imageUrl = i; }
    public String getSource()                 { return source; }
    public void   setSource(String s)         { this.source = s; }
    public String getPublishedAt()            { return publishedAt; }
    public void   setPublishedAt(String p)    { this.publishedAt = p; }
    public String getCategory()               { return category; }
    public void   setCategory(String c)       { this.category = c; }
}
