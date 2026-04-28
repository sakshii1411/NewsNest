package com.news.controller;

import com.news.dao.UserDAO;
import com.news.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String email = req.getParameter("email");
        String pass  = req.getParameter("password");

        if (blank(email) || blank(pass)) {
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=Please+enter+email+and+password");
            return;
        }
        User user = userDAO.loginUser(email.trim(), pass);
        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("loggedInUser", user);
            res.sendRedirect(req.getContextPath() + "/news");
        } else {
            res.sendRedirect(req.getContextPath() + "/login.jsp?error=Invalid+email+or+password");
        }
    }

    private boolean blank(String s) { return s == null || s.isBlank(); }
}
