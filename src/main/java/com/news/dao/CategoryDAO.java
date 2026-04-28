package com.news.dao;

import com.news.model.Category;
import com.news.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT category_id, category_name FROM categories ORDER BY category_name";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Category cat = new Category();
                cat.setCategoryId(rs.getInt("category_id"));
                cat.setCategoryName(rs.getString("category_name"));
                list.add(cat);
            }
        } catch (Exception e) {
            System.out.println("[CategoryDAO] getAllCategories: " + e.getMessage());
        }
        return list;
    }

    public List<String> getUserPreferredCategoryNames(int userId) {
        List<String> prefs = new ArrayList<>();
        String sql = "SELECT c.category_name FROM user_preferences up " +
                     "JOIN categories c ON up.category_id = c.category_id " +
                     "WHERE up.user_id = ? ORDER BY c.category_name";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) prefs.add(rs.getString("category_name"));
        } catch (Exception e) {
            System.out.println("[CategoryDAO] getUserPreferredCategoryNames: " + e.getMessage());
        }
        return prefs;
    }

    public boolean saveUserPreferences(int userId, List<Integer> categoryIds) {
        String del = "DELETE FROM user_preferences WHERE user_id = ?";
        String ins = "INSERT INTO user_preferences (user_id, category_id) VALUES (?, ?)";
        Connection c = null;
        try {
            c = DBConnection.getConnection();
            c.setAutoCommit(false);
            try (PreparedStatement ps = c.prepareStatement(del)) {
                ps.setInt(1, userId);
                ps.executeUpdate();
            }
            if (categoryIds != null && !categoryIds.isEmpty()) {
                try (PreparedStatement ps = c.prepareStatement(ins)) {
                    for (Integer id : categoryIds) {
                        if (id != null) {
                            ps.setInt(1, userId);
                            ps.setInt(2, id);
                            ps.addBatch();
                        }
                    }
                    ps.executeBatch();
                }
            }
            c.commit();
            return true;
        } catch (Exception e) {
            System.out.println("[CategoryDAO] saveUserPreferences: " + e.getMessage());
            try { if (c != null) c.rollback(); } catch (Exception ex) { /* ignore */ }
            return false;
        } finally {
            try { if (c != null) { c.setAutoCommit(true); c.close(); } } catch (Exception ex) { /* ignore */ }
        }
    }
}
