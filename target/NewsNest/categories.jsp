<%@ page import="java.util.List" %>
<%@ page import="com.news.model.Category" %>
<%@ page import="com.news.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  User user = (User) session.getAttribute("loggedInUser");
  List<Category> categories = (List<Category>) request.getAttribute("categories");
  List<String> selected = (List<String>) request.getAttribute("selectedCategories");

  // Category metadata
  String[] catIcons   = {"bi-briefcase-fill","bi-film","bi-newspaper","bi-heart-pulse-fill","bi-stars","bi-trophy-fill","bi-cpu-fill"};
  String[] catColors  = {"#3b82f6","#ec4899","#06b6d4","#10b981","#8b5cf6","#f59e0b","#6366f1"};
  String[] catDescs   = {"Markets & finance news","Movies, music & celebs","Top stories worldwide","Wellness & medicine","Discoveries & research","Live sports & results","Gadgets & innovation"};
  // match order: business, entertainment, general, health, science, sports, technology
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Choose Interests — NewsNest</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
  *{box-sizing:border-box;}
  body{font-family:'Inter',sans-serif;min-height:100vh;margin:0;
       background:radial-gradient(ellipse 70% 60% at 20% 20%,rgba(99,102,241,.35),transparent),
                  radial-gradient(ellipse 60% 50% at 80% 80%,rgba(168,85,247,.25),transparent),#04071a;color:#fff;}
  nav{background:rgba(4,7,26,.7);backdrop-filter:blur(18px);border-bottom:1px solid rgba(255,255,255,.08);padding:14px 0;}
  .brand{font-weight:800;font-size:1.25rem;color:#fff;text-decoration:none;display:flex;align-items:center;gap:8px;}
  .brand-dot{width:34px;height:34px;border-radius:10px;background:linear-gradient(135deg,#6366f1,#a855f7);display:flex;align-items:center;justify-content:center;}
  .btn-soft{background:rgba(255,255,255,.09);border:1px solid rgba(255,255,255,.14);color:#fff;border-radius:10px;font-weight:600;font-size:.88rem;padding:7px 16px;text-decoration:none;transition:.2s;}
  .btn-soft:hover{background:rgba(255,255,255,.15);color:#fff;}
  .btn-danger-soft{background:rgba(239,68,68,.18);border:1px solid rgba(239,68,68,.3);color:#fca5a5;border-radius:10px;font-weight:600;font-size:.88rem;padding:7px 16px;text-decoration:none;transition:.2s;}
  .btn-danger-soft:hover{background:rgba(239,68,68,.28);color:#fff;}
  .main{max-width:820px;margin:0 auto;padding:44px 16px;}
  .page-badge{display:inline-flex;align-items:center;gap:7px;background:rgba(99,102,241,.18);border:1px solid rgba(99,102,241,.3);color:#a5b4fc;padding:6px 14px;border-radius:999px;font-size:.82rem;font-weight:600;margin-bottom:16px;}
  h2{font-size:2rem;font-weight:800;margin-bottom:8px;}
  .sub{color:rgba(255,255,255,.55);margin-bottom:32px;font-size:.97rem;}
  .info-box{background:rgba(99,102,241,.12);border:1px solid rgba(99,102,241,.22);border-radius:14px;padding:13px 16px;font-size:.9rem;color:rgba(255,255,255,.75);margin-bottom:28px;}
  .cat-card{position:relative;display:block;width:100%;padding:18px;border-radius:18px;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.1);transition:all .25s;cursor:pointer;}
  .cat-card:hover{background:rgba(255,255,255,.11);border-color:rgba(255,255,255,.2);transform:translateY(-2px);}
  .cat-card input[type=checkbox]{display:none;}
  .cat-card:has(input:checked){background:rgba(99,102,241,.18);border-color:rgba(99,102,241,.5);box-shadow:0 0 0 3px rgba(99,102,241,.15);}
  .cat-inner{display:flex;align-items:center;gap:14px;}
  .cat-icon{width:46px;height:46px;border-radius:14px;display:flex;align-items:center;justify-content:center;font-size:1.2rem;flex-shrink:0;background:rgba(255,255,255,.1);}
  .cat-text{flex:1;}
  .cat-name{font-weight:700;text-transform:capitalize;margin-bottom:2px;}
  .cat-desc{font-size:.83rem;color:rgba(255,255,255,.5);}
  .cat-check{width:26px;height:26px;border-radius:50%;border:2px solid rgba(255,255,255,.25);display:flex;align-items:center;justify-content:center;font-size:.85rem;color:transparent;transition:.25s;flex-shrink:0;}
  .cat-card:has(input:checked) .cat-check{background:#6366f1;border-color:#6366f1;color:#fff;}
  .btn-save{background:linear-gradient(135deg,#6366f1,#a855f7);color:#fff;border:none;height:52px;border-radius:14px;font-weight:700;font-size:1rem;padding:0 32px;transition:.25s;}
  .btn-save:hover{transform:translateY(-2px);box-shadow:0 10px 28px rgba(99,102,241,.45);color:#fff;}
  .alert{border-radius:12px;border:none;font-size:.9rem;}
</style>
</head>
<body>
<nav>
  <div class="container d-flex justify-content-between align-items-center">
    <a class="brand" href="<%= request.getContextPath() %>/news"><span class="brand-dot"><i class="bi bi-newspaper"></i></span>NewsNest</a>
    <div class="d-flex align-items-center gap-2">
      <span style="color:rgba(255,255,255,.55);font-size:.9rem;">Hi, <strong style="color:#fff;"><%= user!=null?user.getName():"User" %></strong></span>
      <a href="<%= request.getContextPath() %>/news" class="btn-soft"><i class="bi bi-house-door me-1"></i>Dashboard</a>
      <a href="<%= request.getContextPath() %>/logout" class="btn-danger-soft"><i class="bi bi-box-arrow-right me-1"></i>Logout</a>
    </div>
  </div>
</nav>

<div class="main">
  <div class="page-badge"><i class="bi bi-stars"></i>Personalisation Setup</div>
  <h2>Choose Your Interests</h2>
  <p class="sub">Select the topics you love and we'll build a news dashboard just for you. Pick multiple for the best recommendations.</p>

  <% String errMsg = request.getParameter("error");
     if (errMsg != null && !errMsg.isBlank()) { %>
  <div class="alert alert-danger text-dark bg-white mb-3"><i class="bi bi-exclamation-triangle-fill me-2"></i><%= errMsg %></div>
  <% } %>

  <div class="info-box"><i class="bi bi-info-circle me-2"></i>The more categories you select, the richer your personalised feed becomes. Your reading behaviour will further refine recommendations automatically.</div>

  <form action="<%= request.getContextPath() %>/categories" method="post">
    <div class="row g-3">
      <% if (categories != null) {
           int idx = 0;
           for (Category cat : categories) {
             boolean isChecked = selected != null && selected.contains(cat.getCategoryName());
             String icon  = idx < catIcons.length  ? catIcons[idx]  : "bi-tag-fill";
             String color = idx < catColors.length ? catColors[idx] : "#6366f1";
             String desc  = idx < catDescs.length  ? catDescs[idx]  : "Trending stories";
             idx++;
      %>
      <div class="col-md-6">
        <label class="cat-card">
          <input type="checkbox" name="categoryIds" value="<%= cat.getCategoryId() %>" <%= isChecked?"checked":"" %>>
          <div class="cat-inner">
            <div class="cat-icon" style="background:<%= color %>22;color:<%= color %>;"><i class="bi <%= icon %>"></i></div>
            <div class="cat-text">
              <div class="cat-name"><%= cat.getCategoryName() %></div>
              <div class="cat-desc"><%= desc %></div>
            </div>
            <div class="cat-check"><i class="bi bi-check-lg"></i></div>
          </div>
        </label>
      </div>
      <% } } %>
    </div>
    <div class="d-flex flex-wrap gap-3 mt-4">
      <button type="submit" class="btn-save"><i class="bi bi-check2-circle me-2"></i>Save Preferences</button>
      <a href="<%= request.getContextPath() %>/news" class="btn-soft px-4 d-inline-flex align-items-center" style="height:52px;"><i class="bi bi-arrow-left me-2"></i>Back</a>
    </div>
  </form>
</div>
</body></html>
