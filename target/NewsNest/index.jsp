<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>NewsNest — Personalized News Aggregator</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800;900&display=swap" rel="stylesheet">
<style>
  *{box-sizing:border-box;margin:0;padding:0;}
  body{font-family:'Inter',sans-serif;background:#04071a;color:#fff;min-height:100vh;overflow-x:hidden;}

  /* ─── Animated background ─── */
  .hero-bg{
    position:fixed;inset:0;z-index:0;
    background:radial-gradient(ellipse 80% 60% at 50% -10%,rgba(99,102,241,.45),transparent),
               radial-gradient(ellipse 60% 50% at 80% 80%,rgba(168,85,247,.28),transparent),
               radial-gradient(ellipse 50% 40% at 10% 90%,rgba(34,211,238,.18),transparent),#04071a;
  }
  .hero-bg::after{
    content:'';position:absolute;inset:0;
    background:url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='.65' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='.03'/%3E%3C/svg%3E");
    opacity:.4;
  }
  .wrap{position:relative;z-index:1;}

  /* ─── Nav ─── */
  nav{background:rgba(4,7,26,.7);backdrop-filter:blur(20px);border-bottom:1px solid rgba(255,255,255,.07);padding:14px 0;}
  .nav-brand{font-size:1.35rem;font-weight:800;color:#fff;text-decoration:none;display:flex;align-items:center;gap:10px;}
  .brand-dot{width:38px;height:38px;border-radius:12px;background:linear-gradient(135deg,#6366f1,#a855f7);display:flex;align-items:center;justify-content:center;font-size:1.1rem;}

  /* ─── Hero ─── */
  .hero{min-height:calc(100vh - 70px);display:flex;align-items:center;padding:60px 0;}
  .hero-eyebrow{display:inline-flex;align-items:center;gap:8px;background:rgba(99,102,241,.18);border:1px solid rgba(99,102,241,.35);color:#a5b4fc;padding:7px 16px;border-radius:999px;font-size:.88rem;font-weight:600;margin-bottom:24px;}
  .hero-title{font-size:clamp(2.4rem,6vw,4.8rem);font-weight:900;line-height:1.08;letter-spacing:-1px;margin-bottom:24px;}
  .hero-title .accent{background:linear-gradient(90deg,#a78bfa,#38bdf8);-webkit-background-clip:text;-webkit-text-fill-color:transparent;}
  .hero-sub{font-size:1.15rem;color:rgba(255,255,255,.65);max-width:540px;line-height:1.7;margin-bottom:36px;}
  .btn-cta-primary{background:linear-gradient(135deg,#6366f1,#a855f7);color:#fff;border:none;padding:15px 32px;border-radius:14px;font-weight:700;font-size:1rem;text-decoration:none;display:inline-flex;align-items:center;gap:10px;transition:.25s;box-shadow:0 0 0 0 rgba(99,102,241,0);}
  .btn-cta-primary:hover{transform:translateY(-3px);box-shadow:0 12px 30px rgba(99,102,241,.4);color:#fff;}
  .btn-cta-outline{background:rgba(255,255,255,.07);color:#fff;border:1px solid rgba(255,255,255,.18);padding:15px 32px;border-radius:14px;font-weight:700;font-size:1rem;text-decoration:none;display:inline-flex;align-items:center;gap:10px;transition:.25s;}
  .btn-cta-outline:hover{background:rgba(255,255,255,.13);color:#fff;transform:translateY(-3px);}

  /* ─── Stats row ─── */
  .stat-row{display:flex;gap:32px;margin-top:48px;flex-wrap:wrap;}
  .stat-item .val{font-size:2rem;font-weight:800;background:linear-gradient(90deg,#a78bfa,#38bdf8);-webkit-background-clip:text;-webkit-text-fill-color:transparent;}
  .stat-item .lbl{font-size:.85rem;color:rgba(255,255,255,.5);margin-top:2px;}

  /* ─── Feature cards ─── */
  .features{padding:80px 0;}
  .feat-card{background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.09);border-radius:22px;padding:28px;transition:.3s;height:100%;}
  .feat-card:hover{background:rgba(255,255,255,.09);transform:translateY(-6px);border-color:rgba(99,102,241,.35);}
  .feat-icon{width:52px;height:52px;border-radius:16px;background:linear-gradient(135deg,#6366f1,#a855f7);display:flex;align-items:center;justify-content:center;font-size:1.35rem;margin-bottom:18px;}
  .feat-title{font-size:1.1rem;font-weight:700;margin-bottom:8px;}
  .feat-text{color:rgba(255,255,255,.55);font-size:.94rem;line-height:1.65;}

  /* ─── Divider ─── */
  .section-label{font-size:.82rem;font-weight:700;letter-spacing:2px;text-transform:uppercase;color:rgba(99,102,241,.8);margin-bottom:14px;}
  .section-heading{font-size:clamp(1.7rem,3.5vw,2.6rem);font-weight:800;line-height:1.2;margin-bottom:14px;}

  /* ─── CTA bottom ─── */
  .cta-bottom{background:linear-gradient(135deg,rgba(99,102,241,.25),rgba(168,85,247,.18));border:1px solid rgba(99,102,241,.3);border-radius:28px;padding:56px;text-align:center;}

  /* ─── Footer ─── */
  footer{border-top:1px solid rgba(255,255,255,.07);padding:28px 0;text-align:center;color:rgba(255,255,255,.35);font-size:.88rem;}
</style>
</head>
<body>
<div class="hero-bg"></div>
<div class="wrap">

<!-- Nav -->
<nav>
  <div class="container d-flex justify-content-between align-items-center">
    <a class="nav-brand" href="#">
      <span class="brand-dot"><i class="bi bi-newspaper"></i></span>
      NewsNest
    </a>
    <div class="d-flex gap-2">
      <a href="<%= request.getContextPath() %>/login.jsp" class="btn btn-outline-light btn-sm px-4" style="border-radius:10px;">Login</a>
      <a href="<%= request.getContextPath() %>/register.jsp" class="btn btn-sm px-4" style="background:linear-gradient(135deg,#6366f1,#a855f7);color:#fff;border:none;border-radius:10px;">Get Started</a>
    </div>
  </div>
</nav>

<!-- Hero -->
<section class="hero">
  <div class="container">
    <div class="row align-items-center g-5">
      <div class="col-lg-7">
        <div class="hero-eyebrow"><i class="bi bi-stars"></i>AI-Powered Personalisation</div>
        <h1 class="hero-title">Your news,<br><span class="accent">perfectly curated.</span></h1>
        <p class="hero-sub">NewsNest learns from your reading habits to deliver articles you actually care about — powered by a two-layer behavioural recommendation engine.</p>
        <div class="d-flex flex-wrap gap-3">
          <a href="<%= request.getContextPath() %>/register.jsp" class="btn-cta-primary"><i class="bi bi-person-plus-fill"></i>Create Free Account</a>
          <a href="<%= request.getContextPath() %>/login.jsp"    class="btn-cta-outline"><i class="bi bi-box-arrow-in-right"></i>Sign In</a>
        </div>
        <div class="stat-row">
          <div class="stat-item"><div class="val">7+</div><div class="lbl">News Categories</div></div>
          <div class="stat-item"><div class="val">Live</div><div class="lbl">Real-Time API Feed</div></div>
          <div class="stat-item"><div class="val">2-Layer</div><div class="lbl">Recommendation Engine</div></div>
        </div>
      </div>
      <div class="col-lg-5 d-none d-lg-block">
        <!-- decorative visual -->
        <div style="background:rgba(99,102,241,.12);border:1px solid rgba(99,102,241,.25);border-radius:28px;padding:28px;">
          <% String[] cats={"technology","sports","health","business","science","entertainment","general"};
             String[] icons={"bi-cpu-fill","bi-trophy-fill","bi-heart-pulse-fill","bi-briefcase-fill","bi-stars","bi-film","bi-newspaper"};
             String[] colours={"#6366f1","#f59e0b","#10b981","#3b82f6","#8b5cf6","#ec4899","#06b6d4"};
             for(int i=0;i<cats.length;i++){%>
          <div style="display:flex;align-items:center;gap:12px;padding:10px 0;border-bottom:1px solid rgba(255,255,255,.07);">
            <div style="width:38px;height:38px;border-radius:11px;background:<%= colours[i] %>22;display:flex;align-items:center;justify-content:center;color:<%= colours[i] %>;font-size:1.05rem;flex-shrink:0;"><i class="bi <%= icons[i] %>"></i></div>
            <span style="font-weight:600;text-transform:capitalize;font-size:.95rem;"><%= cats[i] %></span>
            <div style="flex:1;height:6px;background:rgba(255,255,255,.07);border-radius:999px;overflow:hidden;"><div style="height:100%;width:<%= (int)(Math.random()*60)+30 %>%;background:<%= colours[i] %>;border-radius:999px;"></div></div>
          </div>
          <% } %>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Features -->
<section class="features">
  <div class="container">
    <div class="text-center mb-5">
      <div class="section-label">How It Works</div>
      <h2 class="section-heading">Smart news, zero noise</h2>
      <p style="color:rgba(255,255,255,.55);max-width:520px;margin:0 auto;font-size:1rem;">A two-layer engine that combines your explicit preferences with your reading behaviour.</p>
    </div>
    <div class="row g-4">
      <div class="col-md-4">
        <div class="feat-card">
          <div class="feat-icon"><i class="bi bi-sliders2"></i></div>
          <div class="feat-title">Choose Your Interests</div>
          <div class="feat-text">Select from 7 topic categories — Technology, Sports, Business, Health, Science, Entertainment, and General. Your selections power Layer 1.</div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="feat-card">
          <div class="feat-icon" style="background:linear-gradient(135deg,#06b6d4,#3b82f6);"><i class="bi bi-activity"></i></div>
          <div class="feat-title">Learns as You Read</div>
          <div class="feat-text">Every article you open is recorded. Layer 2 automatically detects your dominant topic and adds a targeted supplementary feed to your dashboard.</div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="feat-card">
          <div class="feat-icon" style="background:linear-gradient(135deg,#f59e0b,#ef4444);"><i class="bi bi-shield-lock-fill"></i></div>
          <div class="feat-title">Secure by Design</div>
          <div class="feat-text">Passwords are hashed with BCrypt. Session-based authentication with a Servlet filter chain protects every route that requires login.</div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- CTA -->
<section class="container pb-5">
  <div class="cta-bottom">
    <h2 style="font-size:2rem;font-weight:800;margin-bottom:12px;">Ready to read smarter?</h2>
    <p style="color:rgba(255,255,255,.65);margin-bottom:28px;">Create your free account and get a personalised feed in under a minute.</p>
    <a href="<%= request.getContextPath() %>/register.jsp" class="btn-cta-primary" style="margin:0 auto;display:inline-flex;"><i class="bi bi-person-plus-fill"></i>Get Started — It's Free</a>
  </div>
</section>

<footer><div class="container">NewsNest &copy; 2025 &nbsp;·&nbsp; MIT World Peace University &nbsp;·&nbsp; Java Servlet + REST API</div></footer>
</div>
</body>
</html>
