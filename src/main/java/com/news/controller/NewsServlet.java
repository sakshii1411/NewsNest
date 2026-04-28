package com.news.controller;

import com.news.dao.ActivityDAO;
import com.news.dao.CategoryDAO;
import com.news.model.*;
import com.news.util.NewsApiClient;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/news")
public class NewsServlet extends HttpServlet {
    private final CategoryDAO   categoryDAO   = new CategoryDAO();
    private final ActivityDAO   activityDAO   = new ActivityDAO();
    private final NewsApiClient newsApiClient = new NewsApiClient();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        User user = (User) req.getSession().getAttribute("loggedInUser");

        List<String> preferred = categoryDAO.getUserPreferredCategoryNames(user.getUserId());
        if (preferred.isEmpty()) {
            res.sendRedirect(req.getContextPath() + "/categories?error=Please+select+your+preferences+first");
            return;
        }

        String filterCategory = req.getParameter("category");

        // ── Layer 1: personalised feed ──────────────────────────────────────
        List<Article> allArticles = new ArrayList<Article>();
        Set<String>   seenUrls   = new LinkedHashSet<String>();

        List<String> toFetch = (filterCategory != null
                && !filterCategory.trim().isEmpty()
                && !filterCategory.equalsIgnoreCase("all"))
                ? Collections.singletonList(filterCategory.toLowerCase())
                : preferred;

        for (String cat : toFetch) {
            List<Article> fetched = newsApiClient.fetchTopHeadlinesByCategory(cat);
            for (Article a : fetched) {
                if (seenUrls.add(a.getUrl())) allArticles.add(a);
            }
        }

        // ── Layer 2: behavioural recommendation ─────────────────────────────
        String        topCategory = activityDAO.getTopCategoryForUser(user.getUserId());
        List<Article> recommended = new ArrayList<Article>();

        if (topCategory != null && !topCategory.trim().isEmpty()) {
            recommended = newsApiClient.fetchTopHeadlinesByCategory(topCategory);
        }

        // Fallback mock recommendations when API key not set or no clicks yet
        if (recommended.isEmpty()) {
            recommended = getMockRecommended();
        }

        // ── Recent activity ──────────────────────────────────────────────────
        List<Map<String, Object>> recentActivity =
                activityDAO.getRecentActivity(user.getUserId(), 8);

        // Fallback mock activity when user has not clicked anything yet
        if (recentActivity.isEmpty()) {
            recentActivity = getMockActivity();
        }

        // ── Stats ────────────────────────────────────────────────────────────
        int totalClicks = activityDAO.getTotalClicks(user.getUserId());

        req.setAttribute("preferredCategories", preferred);
        req.setAttribute("personalizedFeed",    allArticles);
        req.setAttribute("recommendedArticles", recommended);
        req.setAttribute("topCategory",         topCategory != null ? topCategory : "technology");
        req.setAttribute("totalClicks",         totalClicks);
        req.setAttribute("recentActivity",      recentActivity);
        req.setAttribute("activeCategory",      filterCategory != null ? filterCategory : "all");
        req.getRequestDispatcher("/dashboard.jsp").forward(req, res);
    }

    // ── Mock fallback data ───────────────────────────────────────────────────

    private List<Article> getMockRecommended() {
        List<Article> list = new ArrayList<Article>();

        String[][] data = {
            {"OpenAI launches GPT-5 with real-time reasoning capabilities",
             "https://openai.com", "technology", "OpenAI Blog",
             "https://placehold.co/400x260/1a1a2e/6366f1?text=AI+News"},
            {"Apple Vision Pro 2 unveiled at WWDC 2026",
             "https://apple.com", "technology", "Apple Newsroom",
             "https://placehold.co/400x260/1a1a2e/a855f7?text=Apple"},
            {"NASA confirms water ice discovered on Mars south pole",
             "https://nasa.gov", "science", "NASA",
             "https://placehold.co/400x260/1a1a2e/06b6d4?text=NASA"},
            {"Global EV sales surpass 20 million in Q1 2026",
             "https://reuters.com", "business", "Reuters",
             "https://placehold.co/400x260/1a1a2e/10b981?text=EV+News"},
            {"Meta releases open-source AI model beating GPT-4",
             "https://meta.com", "technology", "Meta AI",
             "https://placehold.co/400x260/1a1a2e/f59e0b?text=Meta+AI"}
        };

        for (String[] d : data) {
            Article a = new Article();
            a.setTitle(d[0]);
            a.setUrl(d[1]);
            a.setCategory(d[2]);
            a.setSource(d[3]);
            a.setImageUrl(d[4]);
            a.setDescription("Stay informed with the latest developments in " + d[2] + ". Click to read the full story.");
            list.add(a);
        }
        return list;
    }

    private List<Map<String, Object>> getMockActivity() {
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

        String[][] data = {
            {"Tesla unveils next-gen autonomous driving chip",   "technology"},
            {"Champions League semi-final results 2026",        "sports"},
            {"New study links Mediterranean diet to longevity", "health"},
            {"Fed holds interest rates steady in April 2026",   "business"},
            {"James Webb telescope captures black hole merger",  "science"},
            {"Top 10 summer blockbusters to watch this year",   "entertainment"}
        };

        for (String[] d : data) {
            Map<String, Object> row = new LinkedHashMap<String, Object>();
            row.put("articleTitle", d[0]);
            row.put("category",     d[1]);
            row.put("source",       "NewsNest Sample");
            row.put("articleUrl",   "#");
            row.put("clickTime",    null);
            list.add(row);
        }
        return list;
    }
}
