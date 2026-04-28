package com.news.controller;

import com.news.dao.CategoryDAO;
import com.news.model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/categories")
public class CategoryServlet extends HttpServlet {
    private final CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("loggedInUser");
        List<Category> all      = categoryDAO.getAllCategories();
        List<String>   selected = categoryDAO.getUserPreferredCategoryNames(user.getUserId());
        req.setAttribute("categories",         all);
        req.setAttribute("selectedCategories", selected);
        req.getRequestDispatcher("/categories.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("loggedInUser");
        String[] ids = req.getParameterValues("categoryIds");
        if (ids == null || ids.length == 0) {
            res.sendRedirect(req.getContextPath() + "/categories?error=Please+select+at+least+one+category");
            return;
        }
        List<Integer> idList = new ArrayList<>();
        try {
            for (String id : ids) idList.add(Integer.parseInt(id));
        } catch (NumberFormatException e) {
            res.sendRedirect(req.getContextPath() + "/categories?error=Invalid+category+selection");
            return;
        }
        if (categoryDAO.saveUserPreferences(user.getUserId(), idList)) {
            res.sendRedirect(req.getContextPath() + "/news");
        } else {
            res.sendRedirect(req.getContextPath() + "/categories?error=Failed+to+save+preferences");
        }
    }
}
