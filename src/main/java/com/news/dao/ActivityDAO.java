package com.news.dao;

import com.news.model.Article;
import com.news.util.DBConnection;

import java.sql.*;
import java.util.*;

public class ActivityDAO {

    public boolean logArticleClick(int userId, Article article) {
        String sql = "INSERT INTO user_activity (user_id, article_title, article_url, category, source, image_url) VALUES (?,?,?,?,?,?)";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt   (1, userId);
            ps.setString(2, article.getTitle());
            ps.setString(3, article.getUrl()      != null ? article.getUrl()      : "");
            ps.setString(4, article.getCategory() != null ? article.getCategory() : "general");
            ps.setString(5, article.getSource()   != null ? article.getSource()   : "Unknown");
            ps.setString(6, article.getImageUrl() != null ? article.getImageUrl() : "");
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("[ActivityDAO] logArticleClick: " + e.getMessage());
            return false;
        }
    }

    public String getTopCategoryForUser(int userId) {
        String sql = "SELECT category, COUNT(*) AS cnt FROM user_activity " +
                     "WHERE user_id = ? GROUP BY category ORDER BY cnt DESC LIMIT 1";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getString("category");
        } catch (SQLException e) {
            System.out.println("[ActivityDAO] getTopCategoryForUser: " + e.getMessage());
        }
        return null;
    }

    public List<Map<String, Object>> getRecentActivity(int userId, int limit) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT article_title, article_url, category, source, click_time " +
                     "FROM user_activity WHERE user_id = ? ORDER BY click_time DESC LIMIT ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                row.put("articleTitle", rs.getString("article_title"));
                row.put("articleUrl",   rs.getString("article_url"));
                row.put("category",     rs.getString("category"));
                row.put("source",       rs.getString("source"));
                Timestamp ts = rs.getTimestamp("click_time");
                row.put("clickTime", ts != null ? ts.toLocalDateTime() : null);
                list.add(row);
            }
        } catch (SQLException e) {
            System.out.println("[ActivityDAO] getRecentActivity: " + e.getMessage());
        }
        return list;
    }

    public Map<String, Integer> getCategoryClickCounts(int userId) {
        Map<String, Integer> counts = new LinkedHashMap<>();
        String sql = "SELECT category, COUNT(*) AS cnt FROM user_activity " +
                     "WHERE user_id = ? GROUP BY category ORDER BY cnt DESC";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) counts.put(rs.getString("category"), rs.getInt("cnt"));
        } catch (SQLException e) {
            System.out.println("[ActivityDAO] getCategoryClickCounts: " + e.getMessage());
        }
        return counts;
    }

    public int getTotalClicks(int userId) {
        String sql = "SELECT COUNT(*) FROM user_activity WHERE user_id = ?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.out.println("[ActivityDAO] getTotalClicks: " + e.getMessage());
        }
        return 0;
    }
}
