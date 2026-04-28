package com.news.controller;

import com.news.dao.UserDAO;
import com.news.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.sendRedirect(req.getContextPath() + "/register.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String name    = req.getParameter("name");
        String email   = req.getParameter("email");
        String pass    = req.getParameter("password");
        String confirm = req.getParameter("confirmPassword");

        if (blank(name) || blank(email) || blank(pass) || blank(confirm)) {
            res.sendRedirect(req.getContextPath() + "/register.jsp?error=Please+fill+all+fields");
            return;
        }
        if (!pass.equals(confirm)) {
            res.sendRedirect(req.getContextPath() + "/register.jsp?error=Passwords+do+not+match");
            return;
        }
        email = email.trim().toLowerCase();
        if (userDAO.emailExists(email)) {
            res.sendRedirect(req.getContextPath() + "/register.jsp?error=Email+already+registered");
            return;
        }
        User u = new User();
        u.setName(name.trim());
        u.setEmail(email);
        u.setPassword(pass);
        if (userDAO.registerUser(u)) {
            res.sendRedirect(req.getContextPath() + "/login.jsp?success=Account+created!+Please+login.");
        } else {
            res.sendRedirect(req.getContextPath() + "/register.jsp?error=Registration+failed.+Try+again.");
        }
    }

    private boolean blank(String s) { return s == null || s.isBlank(); }
}
