<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String title  = request.getParameter("title");
  String desc   = request.getParameter("description");
  String url    = request.getParameter("url");
  String source = request.getParameter("source");
  String cat    = request.getParameter("category");
  String imgUrl = request.getParameter("imageUrl");

  if (title  == null || title.isBlank())  title  = "News Article";
  if (desc   == null || desc.isBlank())   desc   = "No description available for this article.";
  if (source == null || source.isBlank()) source = "Unknown Source";
  if (cat    == null || cat.isBlank())    cat    = "general";
  if (imgUrl == null || imgUrl.isBlank()) imgUrl = "https://placehold.co/1200x500/1a1a2e/6366f1?text=NewsNest";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title><%= title %> — NewsNest</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<style>
  body{font-family:'Inter',sans-serif;min-height:100vh;margin:0;
       background:radial-gradient(ellipse 70% 60% at 30% 10%,rgba(99,102,241,.35),transparent),#04071a;color:#fff;}
  nav{background:rgba(4,7,26,.8);backdrop-filter:blur(18px);border-bottom:1px solid rgba(255,255,255,.08);padding:12px 0;}
  .brand{font-weight:800;color:#fff;text-decoration:none;display:flex;align-items:center;gap:8px;}
  .brand-dot{width:34px;height:34px;border-radius:10px;background:linear-gradient(135deg,#6366f1,#a855f7);display:flex;align-items:center;justify-content:center;}
  .nav-btn{background:rgba(255,255,255,.08);border:1px solid rgba(255,255,255,.12);color:rgba(255,255,255,.8);border-radius:10px;font-weight:600;font-size:.85rem;padding:7px 14px;text-decoration:none;transition:.2s;display:inline-flex;align-items:center;gap:6px;}
  .nav-btn:hover{background:rgba(255,255,255,.14);color:#fff;}
  .wrap{max-width:880px;margin:0 auto;padding:44px 16px 64px;}
  .art-card{background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.1);border-radius:24px;overflow:hidden;}
  .art-img{width:100%;height:400px;object-fit:cover;display:block;}
  .art-body{padding:34px;}
  .cat-pill{display:inline-flex;align-items:center;gap:6px;background:rgba(99,102,241,.2);border:1px solid rgba(99,102,241,.35);color:#a5b4fc;padding:6px 14px;border-radius:999px;font-size:.82rem;font-weight:700;text-transform:capitalize;margin-bottom:18px;}
  h1{font-size:clamp(1.5rem,3vw,2.2rem);font-weight:800;line-height:1.2;margin-bottom:14px;}
  .src-line{color:rgba(255,255,255,.5);font-size:.9rem;margin-bottom:22px;}
  .desc{color:rgba(255,255,255,.78);font-size:1.03rem;line-height:1.8;margin-bottom:28px;}
  .btn-open{background:linear-gradient(135deg,#6366f1,#a855f7);color:#fff;border:none;border-radius:14px;padding:14px 28px;font-weight:700;font-size:1rem;text-decoration:none;display:inline-flex;align-items:center;gap:9px;transition:.25s;}
  .btn-open:hover{transform:translateY(-2px);box-shadow:0 10px 28px rgba(99,102,241,.45);color:#fff;}
  .btn-back{background:rgba(255,255,255,.08);border:1px solid rgba(255,255,255,.14);color:#fff;border-radius:14px;padding:14px 28px;font-weight:700;font-size:1rem;text-decoration:none;display:inline-flex;align-items:center;gap:9px;transition:.25s;}
  .btn-back:hover{background:rgba(255,255,255,.14);color:#fff;}
  .info-box{background:rgba(99,102,241,.1);border:1px solid rgba(99,102,241,.2);border-radius:16px;padding:16px 18px;color:rgba(255,255,255,.7);font-size:.9rem;margin-top:24px;}
  @media(max-width:576px){.art-img{height:220px;}.art-body{padding:20px;}}
</style>
</head>
<body>
<nav>
  <div class="container d-flex justify-content-between align-items-center">
    <a class="brand" href="<%= request.getContextPath() %>/news"><span class="brand-dot"><i class="bi bi-newspaper"></i></span>NewsNest</a>
    <div class="d-flex gap-2">
      <a href="<%= request.getContextPath() %>/news" class="nav-btn"><i class="bi bi-arrow-left"></i>Dashboard</a>
      <a href="<%= request.getContextPath() %>/logout" class="nav-btn" style="background:rgba(239,68,68,.15);border-color:rgba(239,68,68,.3);color:#fca5a5;"><i class="bi bi-box-arrow-right"></i>Logout</a>
    </div>
  </div>
</nav>

<div class="wrap">
  <div class="art-card">
    <img src="<%= imgUrl %>" class="art-img" alt="article image" onerror="this.src='https://placehold.co/1200x500/1a1a2e/6366f1?text=NewsNest'">
    <div class="art-body">
      <div class="cat-pill"><i class="bi bi-tag-fill"></i><%= cat %></div>
      <h1><%= title %></h1>
      <p class="src-line"><i class="bi bi-broadcast me-2"></i>Source: <strong><%= source %></strong></p>
      <p class="desc"><%= desc %></p>
      <div class="d-flex flex-wrap gap-3">
        <% if (url != null && !url.isBlank() && !url.equals("#")) { %>
        <a href="<%= url %>" target="_blank" class="btn-open"><i class="bi bi-box-arrow-up-right"></i>Read Full Article</a>
        <% } %>
        <a href="<%= request.getContextPath() %>/news" class="btn-back"><i class="bi bi-house-door"></i>Back to Feed</a>
      </div>
      <div class="info-box"><i class="bi bi-lightbulb me-2"></i>This article appeared in your feed based on your preferences and reading history. The more you read, the smarter your recommendations become.</div>
    </div>
  </div>
</div>
</body></html>
