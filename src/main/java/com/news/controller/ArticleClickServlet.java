package com.news.controller;

import com.news.dao.ActivityDAO;
import com.news.model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/article-click")
public class ArticleClickServlet extends HttpServlet {
    private final ActivityDAO activityDAO = new ActivityDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("loggedInUser");

        Article a = new Article();
        a.setTitle(req.getParameter("title"));
        a.setUrl(req.getParameter("url"));
        a.setCategory(req.getParameter("category"));
        a.setSource(req.getParameter("source"));
        a.setImageUrl(req.getParameter("imageUrl"));
        a.setDescription(req.getParameter("description"));

        if (user != null && a.getTitle() != null && a.getUrl() != null) {
            activityDAO.logArticleClick(user.getUserId(), a);
        }

        // Redirect to article details view
        String redirect = req.getContextPath() + "/articleDetails.jsp"
                + "?title="       + enc(a.getTitle())
                + "&description=" + enc(a.getDescription())
                + "&url="         + enc(a.getUrl())
                + "&source="      + enc(a.getSource())
                + "&category="    + enc(a.getCategory())
                + "&imageUrl="    + enc(a.getImageUrl());
        res.sendRedirect(redirect);
    }

    private String enc(String v) {
        return URLEncoder.encode(v == null ? "" : v, StandardCharsets.UTF_8);
    }
}
