package com.news.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class UserActivity implements Serializable {
    private int       activityId;
    private int       userId;
    private String    articleTitle;
    private String    articleUrl;
    private String    category;
    private String    source;
    private String    imageUrl;
    private Timestamp clickTime;

    public int       getActivityId()              { return activityId; }
    public void      setActivityId(int id)        { this.activityId = id; }
    public int       getUserId()                  { return userId; }
    public void      setUserId(int id)            { this.userId = id; }
    public String    getArticleTitle()            { return articleTitle; }
    public void      setArticleTitle(String t)    { this.articleTitle = t; }
    public String    getArticleUrl()              { return articleUrl; }
    public void      setArticleUrl(String u)      { this.articleUrl = u; }
    public String    getCategory()                { return category; }
    public void      setCategory(String c)        { this.category = c; }
    public String    getSource()                  { return source; }
    public void      setSource(String s)          { this.source = s; }
    public String    getImageUrl()                { return imageUrl; }
    public void      setImageUrl(String i)        { this.imageUrl = i; }
    public Timestamp getClickTime()               { return clickTime; }
    public void      setClickTime(Timestamp t)    { this.clickTime = t; }
}
