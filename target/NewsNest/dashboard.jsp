<%@ page import="java.util.List,java.util.Map,java.util.ArrayList,java.util.HashMap" %>
<%@ page import="com.news.model.Article,com.news.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  User user = (User) session.getAttribute("loggedInUser");
  if (user == null) { response.sendRedirect(request.getContextPath()+"/login.jsp"); return; }

  List<Article>            personalizedFeed    = (List<Article>)            request.getAttribute("personalizedFeed");
  List<Article>            recommendedArticles = (List<Article>)            request.getAttribute("recommendedArticles");
  List<String>             preferredCats       = (List<String>)             request.getAttribute("preferredCategories");
  List<Map<String,Object>> recentActivity      = (List<Map<String,Object>>) request.getAttribute("recentActivity");
  String                   topCategory         = (String)                   request.getAttribute("topCategory");
  Integer                  totalClicksAttr     = (Integer)                  request.getAttribute("totalClicks");
  String                   activeCategory      = (String)                   request.getAttribute("activeCategory");

  if (personalizedFeed    == null) personalizedFeed    = new ArrayList<Article>();
  if (recommendedArticles == null) recommendedArticles = new ArrayList<Article>();
  if (preferredCats       == null) preferredCats       = new ArrayList<String>();
  if (recentActivity      == null) recentActivity      = new ArrayList<Map<String,Object>>();
  if (activeCategory == null || activeCategory.trim().isEmpty()) activeCategory = "all";
  int totalClicks = totalClicksAttr != null ? totalClicksAttr : 0;

  java.util.Map<String,String> catIco = new HashMap<String,String>();
  catIco.put("business","bi-briefcase-fill"); catIco.put("entertainment","bi-film");
  catIco.put("general","bi-newspaper");       catIco.put("health","bi-heart-pulse-fill");
  catIco.put("science","bi-stars");           catIco.put("sports","bi-trophy-fill");
  catIco.put("technology","bi-cpu-fill");

  java.util.Map<String,String> catClr = new HashMap<String,String>();
  catClr.put("business","#3b82f6"); catClr.put("entertainment","#ec4899");
  catClr.put("general","#06b6d4");  catClr.put("health","#10b981");
  catClr.put("science","#8b5cf6");  catClr.put("sports","#f59e0b");
  catClr.put("technology","#6366f1");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Dashboard — NewsNest</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
  :root{--bg:#04071a;--glass:rgba(255,255,255,.07);--border:rgba(255,255,255,.1);--muted:rgba(255,255,255,.5);--sub:rgba(255,255,255,.7);}
  *{box-sizing:border-box;}
  body{font-family:'Inter',sans-serif;min-height:100vh;margin:0;background:linear-gradient(160deg,#04071a 0%,#0d0e2e 40%,#14063a 100%);color:#fff;}
  nav.topnav{background:rgba(4,7,26,.8);backdrop-filter:blur(20px);border-bottom:1px solid var(--border);padding:12px 0;position:sticky;top:0;z-index:100;}
  .brand{font-weight:800;font-size:1.2rem;color:#fff;text-decoration:none;display:flex;align-items:center;gap:9px;}
  .brand-dot{width:36px;height:36px;border-radius:11px;background:linear-gradient(135deg,#6366f1,#a855f7);display:flex;align-items:center;justify-content:center;}
  .nav-btn{background:rgba(255,255,255,.08);border:1px solid rgba(255,255,255,.12);color:rgba(255,255,255,.8);border-radius:10px;font-weight:600;font-size:.85rem;padding:7px 14px;text-decoration:none;transition:.2s;display:inline-flex;align-items:center;gap:6px;}
  .nav-btn:hover{background:rgba(255,255,255,.14);color:#fff;}
  .nav-btn.danger{background:rgba(239,68,68,.15);border-color:rgba(239,68,68,.3);color:#fca5a5;}
  .nav-btn.danger:hover{background:rgba(239,68,68,.25);color:#fff;}
  .hero-card{background:var(--glass);border:1px solid var(--border);backdrop-filter:blur(18px);border-radius:24px;padding:28px 30px;margin-bottom:28px;}
  .hero-name{font-size:1.8rem;font-weight:800;margin-bottom:6px;}
  .hero-sub{color:var(--sub);font-size:.95rem;margin-bottom:20px;}
  .pref-tag{display:inline-flex;align-items:center;gap:6px;background:rgba(255,255,255,.09);border:1px solid rgba(255,255,255,.12);padding:5px 12px;border-radius:999px;font-size:.8rem;font-weight:600;margin:3px 4px 3px 0;text-transform:capitalize;}
  .stat-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:12px;}
  .stat-box{background:rgba(255,255,255,.08);border:1px solid rgba(255,255,255,.1);border-radius:16px;padding:16px 18px;}
  .stat-val{font-size:1.6rem;font-weight:800;line-height:1;}
  .stat-lbl{color:var(--muted);font-size:.8rem;margin-top:4px;}
  .cat-bar{display:flex;flex-wrap:wrap;gap:8px;margin-top:20px;}
  .cat-pill{display:inline-flex;align-items:center;gap:7px;padding:8px 16px;border-radius:999px;background:rgba(255,255,255,.08);border:1px solid rgba(255,255,255,.12);color:rgba(255,255,255,.75);text-decoration:none;font-weight:600;font-size:.84rem;transition:.2s;}
  .cat-pill:hover{background:rgba(255,255,255,.14);color:#fff;}
  .cat-pill.active{background:#6366f1;border-color:#6366f1;color:#fff;box-shadow:0 0 0 3px rgba(99,102,241,.25);}
  .sec-h{font-size:1.12rem;font-weight:800;margin-bottom:18px;display:flex;align-items:center;gap:8px;}
  .sec-h .badge-count{font-size:.78rem;background:rgba(255,255,255,.12);border-radius:999px;padding:3px 9px;font-weight:600;}
  .news-card{background:var(--glass);border:1px solid var(--border);border-radius:20px;overflow:hidden;height:100%;transition:.3s;display:flex;flex-direction:column;}
  .news-card:hover{transform:translateY(-5px);border-color:rgba(99,102,241,.4);box-shadow:0 16px 40px rgba(0,0,0,.35);}
  .news-img{width:100%;height:200px;object-fit:cover;display:block;background:rgba(255,255,255,.05);}
  .news-body{padding:18px;flex:1;display:flex;flex-direction:column;}
  .news-chip{display:inline-flex;align-items:center;gap:5px;padding:4px 10px;border-radius:999px;font-size:.75rem;font-weight:700;background:rgba(99,102,241,.2);color:#a5b4fc;margin-bottom:12px;text-transform:capitalize;}
  .news-title{font-size:1rem;font-weight:700;line-height:1.4;margin-bottom:10px;flex:1;}
  .news-desc{color:var(--sub);font-size:.88rem;line-height:1.6;margin-bottom:12px;display:-webkit-box;-webkit-line-clamp:3;-webkit-box-orient:vertical;overflow:hidden;}
  .news-src{color:var(--muted);font-size:.8rem;margin-bottom:14px;}
  .btn-read{background:linear-gradient(135deg,#6366f1,#a855f7);color:#fff;border:none;border-radius:10px;padding:9px 0;font-weight:700;font-size:.88rem;width:100%;transition:.2s;text-decoration:none;display:flex;align-items:center;justify-content:center;gap:6px;}
  .btn-read:hover{transform:translateY(-1px);box-shadow:0 8px 20px rgba(99,102,241,.4);color:#fff;}
  .side-card{background:var(--glass);border:1px solid var(--border);border-radius:20px;padding:20px;}
  .rec-item{padding:12px 0;border-bottom:1px solid rgba(255,255,255,.08);}
  .rec-item:last-child{border-bottom:none;padding-bottom:0;}
  .rec-item:first-child{padding-top:0;}
  .rec-title{font-size:.9rem;font-weight:600;margin-bottom:4px;line-height:1.35;}
  .rec-src{color:var(--muted);font-size:.78rem;margin-bottom:6px;}
  .rec-link{color:#a78bfa;text-decoration:none;font-size:.82rem;font-weight:600;}
  .rec-link:hover{color:#c4b5fd;}
  .act-item{padding:10px 0;border-bottom:1px solid rgba(255,255,255,.07);}
  .act-item:last-child{border-bottom:none;padding-bottom:0;}
  .act-item:first-child{padding-top:0;}
  .act-title{font-size:.86rem;font-weight:600;margin-bottom:4px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;}
  .cat-badge-sm{display:inline-flex;align-items:center;gap:4px;padding:3px 8px;border-radius:999px;font-size:.72rem;font-weight:700;background:rgba(255,255,255,.1);color:rgba(255,255,255,.7);text-transform:capitalize;}
  .empty{background:rgba(255,255,255,.05);border:1px dashed rgba(255,255,255,.15);border-radius:16px;padding:28px;text-align:center;color:var(--sub);}
  .empty i{font-size:2rem;display:block;margin-bottom:10px;opacity:.5;}
  .main-wrap{max-width:1400px;margin:0 auto;padding:28px 16px 48px;}
  @media(max-width:768px){.stat-grid{grid-template-columns:1fr 1fr;}.hero-name{font-size:1.4rem;}}
</style>
</head>
<body>
<nav class="topnav">
  <div class="container d-flex justify-content-between align-items-center">
    <a class="brand" href="<%= request.getContextPath() %>/news">
      <span class="brand-dot"><i class="bi bi-newspaper"></i></span>NewsNest
    </a>
    <div class="d-flex align-items-center gap-2">
      <span style="color:var(--muted);font-size:.88rem;">Hi, <strong style="color:#fff;"><%= user.getName() %></strong></span>
      <a href="<%= request.getContextPath() %>/categories" class="nav-btn"><i class="bi bi-sliders2"></i>Preferences</a>
      <a href="<%= request.getContextPath() %>/logout" class="nav-btn danger"><i class="bi bi-box-arrow-right"></i>Logout</a>
    </div>
  </div>
</nav>

<div class="main-wrap">
  <div class="hero-card">
    <div class="row g-4 align-items-center">
      <div class="col-lg-8">
        <div class="hero-name">Welcome back, <%= user.getName() %> &#128075;</div>
        <div class="hero-sub">Your personalised dashboard — Layer 1 (preferences) + Layer 2 (behaviour) recommendations.</div>
        <div>
          <% if (preferredCats.isEmpty()) { %>
            <span class="pref-tag" style="color:rgba(255,255,255,.45);">No categories selected</span>
          <% } else { for (String pc : preferredCats) {
               String ico2 = catIco.containsKey(pc) ? catIco.get(pc) : "bi-tag-fill";
               String clr2 = catClr.containsKey(pc) ? catClr.get(pc) : "#6366f1"; %>
          <span class="pref-tag"><i class="bi <%= ico2 %>" style="color:<%= clr2 %>;"></i><%= pc %></span>
          <% }} %>
        </div>
        <div class="cat-bar">
          <a href="<%= request.getContextPath() %>/news?category=all" class="cat-pill <%= "all".equalsIgnoreCase(activeCategory)?"active":"" %>"><i class="bi bi-grid-fill"></i>All</a>
          <a href="<%= request.getContextPath() %>/news?category=general" class="cat-pill <%= "general".equalsIgnoreCase(activeCategory)?"active":"" %>"><i class="bi bi-newspaper"></i>General</a>
          <a href="<%= request.getContextPath() %>/news?category=business" class="cat-pill <%= "business".equalsIgnoreCase(activeCategory)?"active":"" %>"><i class="bi bi-briefcase-fill"></i>Business</a>
          <a href="<%= request.getContextPath() %>/news?category=technology" class="cat-pill <%= "technology".equalsIgnoreCase(activeCategory)?"active":"" %>"><i class="bi bi-cpu-fill"></i>Technology</a>
          <a href="<%= request.getContextPath() %>/news?category=sports" class="cat-pill <%= "sports".equalsIgnoreCase(activeCategory)?"active":"" %>"><i class="bi bi-trophy-fill"></i>Sports</a>
          <a href="<%= request.getContextPath() %>/news?category=health" class="cat-pill <%= "health".equalsIgnoreCase(activeCategory)?"active":"" %>"><i class="bi bi-heart-pulse-fill"></i>Health</a>
          <a href="<%= request.getContextPath() %>/news?category=science" class="cat-pill <%= "science".equalsIgnoreCase(activeCategory)?"active":"" %>"><i class="bi bi-stars"></i>Science</a>
          <a href="<%= request.getContextPath() %>/news?category=entertainment" class="cat-pill <%= "entertainment".equalsIgnoreCase(activeCategory)?"active":"" %>"><i class="bi bi-film"></i>Entertainment</a>
        </div>
      </div>
      <div class="col-lg-4">
        <div class="stat-grid">
          <div class="stat-box"><div class="stat-val"><%= personalizedFeed.size() %></div><div class="stat-lbl">Articles</div></div>
          <div class="stat-box"><div class="stat-val"><%= recommendedArticles.size() %></div><div class="stat-lbl">Recommended</div></div>
          <div class="stat-box"><div class="stat-val"><%= totalClicks %></div><div class="stat-lbl">Total Reads</div></div>
        </div>
        <% if (topCategory != null && !topCategory.trim().isEmpty()) { %>
        <div class="stat-box mt-3" style="background:rgba(99,102,241,.15);border-color:rgba(99,102,241,.3);">
          <div class="stat-lbl">&#128293; Top Interest (Layer 2)</div>
          <div style="font-size:1.1rem;font-weight:800;margin-top:4px;text-transform:capitalize;color:#a5b4fc;"><%= topCategory %></div>
        </div>
        <% } %>
      </div>
    </div>
  </div>

  <div class="row g-4">
    <div class="col-lg-8">
      <div class="sec-h"><i class="bi bi-lightning-charge-fill" style="color:#f59e0b;"></i>Personalised Feed <span class="badge-count"><%= personalizedFeed.size() %></span></div>
      <% if (personalizedFeed.isEmpty()) { %>
      <div class="empty"><i class="bi bi-newspaper"></i>No articles found. Add your NewsAPI key in config.properties or select more categories.</div>
      <% } else { %>
      <div class="row g-4">
        <% for (Article a : personalizedFeed) {
             String aCat  = (a.getCategory()!=null && !a.getCategory().trim().isEmpty()) ? a.getCategory() : "general";
             String aClr  = catClr.containsKey(aCat) ? catClr.get(aCat) : "#6366f1";
             String aIco  = catIco.containsKey(aCat) ? catIco.get(aCat) : "bi-tag-fill";
             String aImg  = (a.getImageUrl()!=null && !a.getImageUrl().trim().isEmpty()) ? a.getImageUrl() : "https://placehold.co/600x360/1a1a2e/6366f1?text=NewsNest";
             String aUrl  = (a.getUrl()!=null && !a.getUrl().trim().isEmpty()) ? a.getUrl() : "#";
             String aSrc  = (a.getSource()!=null && !a.getSource().trim().isEmpty()) ? a.getSource() : "Unknown";
             String aDesc = (a.getDescription()!=null) ? a.getDescription() : "";
        %>
        <div class="col-md-6">
          <div class="news-card">
            <img src="<%= aImg %>" class="news-img" alt="article" onerror="this.src='https://placehold.co/600x360/1a1a2e/6366f1?text=NewsNest'">
            <div class="news-body">
              <div class="news-chip" style="background:<%= aClr %>22;color:<%= aClr %>;"><i class="bi <%= aIco %>"></i><%= aCat %></div>
              <div class="news-title"><%= a.getTitle() %></div>
              <div class="news-desc"><%= aDesc %></div>
              <div class="news-src"><i class="bi bi-globe2 me-1"></i><%= aSrc %></div>
              <a class="btn-read" href="<%= request.getContextPath() %>/article-click?title=<%= java.net.URLEncoder.encode(a.getTitle(),"UTF-8") %>&url=<%= java.net.URLEncoder.encode(aUrl,"UTF-8") %>&category=<%= java.net.URLEncoder.encode(aCat,"UTF-8") %>&source=<%= java.net.URLEncoder.encode(aSrc,"UTF-8") %>&imageUrl=<%= java.net.URLEncoder.encode(a.getImageUrl()!=null?a.getImageUrl():"","UTF-8") %>&description=<%= java.net.URLEncoder.encode(aDesc,"UTF-8") %>">
                <i class="bi bi-box-arrow-up-right"></i>Read Article
              </a>
            </div>
          </div>
        </div>
        <% } %>
      </div>
      <% } %>
    </div>

    <div class="col-lg-4">
      <div class="side-card mb-4">
        <div class="sec-h"><i class="bi bi-stars" style="color:#a855f7;"></i>Recommended <span class="badge-count">Layer 2</span></div>
        <% if (recommendedArticles.isEmpty()) { %>
        <div class="empty" style="padding:16px;"><i class="bi bi-stars" style="font-size:1.4rem;"></i>Read articles to unlock recommendations.</div>
        <% } else { for (Article a : recommendedArticles) {
             String rUrl  = (a.getUrl()!=null && !a.getUrl().trim().isEmpty()) ? a.getUrl() : "#";
             String rCat  = (a.getCategory()!=null) ? a.getCategory() : "general";
             String rSrc  = (a.getSource()!=null) ? a.getSource() : "Source";
             String rDesc = (a.getDescription()!=null) ? a.getDescription() : "";
             String rImg  = (a.getImageUrl()!=null) ? a.getImageUrl() : "";
        %>
        <div class="rec-item">
          <div class="rec-title"><%= a.getTitle() %></div>
          <div class="rec-src"><i class="bi bi-globe2 me-1"></i><%= rSrc %></div>
          <a href="<%= request.getContextPath() %>/article-click?title=<%= java.net.URLEncoder.encode(a.getTitle(),"UTF-8") %>&url=<%= java.net.URLEncoder.encode(rUrl,"UTF-8") %>&category=<%= java.net.URLEncoder.encode(rCat,"UTF-8") %>&source=<%= java.net.URLEncoder.encode(rSrc,"UTF-8") %>&imageUrl=<%= java.net.URLEncoder.encode(rImg,"UTF-8") %>&description=<%= java.net.URLEncoder.encode(rDesc,"UTF-8") %>" class="rec-link">Open article <i class="bi bi-arrow-right-short"></i></a>
        </div>
        <% } } %>
      </div>

      <div class="side-card">
        <div class="sec-h"><i class="bi bi-clock-history" style="color:#06b6d4;"></i>Recent Activity</div>
        <% if (recentActivity.isEmpty()) { %>
        <div class="empty" style="padding:16px;"><i class="bi bi-clock" style="font-size:1.4rem;"></i>No reading history yet.</div>
        <% } else { for (Map<String,Object> row : recentActivity) {
             String raCat = row.get("category")!=null ? (String)row.get("category") : "general";
             String raClr = catClr.containsKey(raCat) ? catClr.get(raCat) : "#6366f1";
             String raIco = catIco.containsKey(raCat) ? catIco.get(raCat) : "bi-tag-fill";
        %>
        <div class="act-item">
          <div class="act-title"><%= row.get("articleTitle")!=null ? row.get("articleTitle") : "Article" %></div>
          <span class="cat-badge-sm" style="background:<%= raClr %>22;color:<%= raClr %>;"><i class="bi <%= raIco %> me-1"></i><%= raCat %></span>
        </div>
        <% } } %>
      </div>
    </div>
  </div>
</div>
</body></html>
