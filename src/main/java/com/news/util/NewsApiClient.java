package com.news.util;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.news.model.Article;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class NewsApiClient {

    public List<Article> fetchTopHeadlinesByCategory(String category) {
        List<Article> articles = new ArrayList<>();
        try {
            String apiKey   = ConfigUtil.get("news.api.key");
            String baseUrl  = ConfigUtil.get("news.api.base.url");
            String country  = ConfigUtil.get("news.default.country");

            if (apiKey == null || apiKey.isBlank() || apiKey.startsWith("YOUR_")) {
                System.out.println("[NewsAPI] API key not configured — returning empty list.");
                return articles;
            }
            if (baseUrl == null || baseUrl.isBlank()) baseUrl = "https://newsapi.org/v2/top-headlines";
            if (country  == null || country.isBlank())  country  = "us";

            String endpoint = baseUrl + "?country=" + country + "&category=" + category + "&apiKey=" + apiKey;
            URL url = new URL(endpoint);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setConnectTimeout(8000);
            conn.setReadTimeout(8000);

            int code = conn.getResponseCode();
            BufferedReader reader = new BufferedReader(new InputStreamReader(
                    code >= 200 && code < 300 ? conn.getInputStream() : conn.getErrorStream()));

            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) sb.append(line);
            reader.close();
            conn.disconnect();

            JsonObject root = JsonParser.parseString(sb.toString()).getAsJsonObject();
            if (!"ok".equals(safe(root, "status"))) {
                System.out.println("[NewsAPI] Error response: " + sb);
                return articles;
            }

            JsonArray arr = root.getAsJsonArray("articles");
            for (int i = 0; i < arr.size(); i++) {
                JsonObject obj = arr.get(i).getAsJsonObject();
                String articleUrl = safe(obj, "url");
                String title      = safe(obj, "title");
                if (title.isBlank() || articleUrl.isBlank() || !articleUrl.startsWith("http")) continue;
                if (title.equals("[Removed]")) continue;

                Article a = new Article();
                a.setTitle(title);
                a.setDescription(safe(obj, "description").isBlank() ? "No description available." : safe(obj, "description"));
                a.setUrl(articleUrl);
                a.setImageUrl(safe(obj, "urlToImage"));
                a.setPublishedAt(safe(obj, "publishedAt"));
                a.setCategory(category);

                String sourceName = "Unknown Source";
                if (obj.has("source") && obj.get("source").isJsonObject()) {
                    String s = safe(obj.getAsJsonObject("source"), "name");
                    if (!s.isBlank()) sourceName = s;
                }
                a.setSource(sourceName);
                articles.add(a);
            }
        } catch (Exception e) {
            System.out.println("[NewsAPI] Exception: " + e.getMessage());
        }
        return articles;
    }

    private String safe(JsonObject obj, String key) {
        return (obj.has(key) && !obj.get(key).isJsonNull()) ? obj.get(key).getAsString() : "";
    }
}
