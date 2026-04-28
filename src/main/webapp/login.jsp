<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Login — NewsNest</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
  *{box-sizing:border-box;}
  body{font-family:'Inter',sans-serif;min-height:100vh;margin:0;display:flex;align-items:center;justify-content:center;
       background:radial-gradient(ellipse 80% 70% at 30% 20%,rgba(99,102,241,.38),transparent),
                  radial-gradient(ellipse 60% 60% at 70% 80%,rgba(168,85,247,.28),transparent),#04071a;
       color:#fff;}
  .card-wrap{width:100%;max-width:460px;padding:24px 16px;}
  .glass{background:rgba(255,255,255,.07);border:1px solid rgba(255,255,255,.13);backdrop-filter:blur(22px);-webkit-backdrop-filter:blur(22px);border-radius:26px;padding:40px 36px;}
  .brand-icon{width:66px;height:66px;border-radius:20px;background:linear-gradient(135deg,#6366f1,#a855f7);display:flex;align-items:center;justify-content:center;font-size:1.6rem;margin:0 auto 20px;}
  h2{font-weight:800;font-size:1.65rem;text-align:center;margin-bottom:6px;}
  .sub{color:rgba(255,255,255,.55);text-align:center;margin-bottom:28px;font-size:.94rem;}
  .form-label{font-weight:600;font-size:.9rem;margin-bottom:7px;color:rgba(255,255,255,.85);}
  .input-group-text{background:rgba(255,255,255,.1);border:1px solid rgba(255,255,255,.15);color:rgba(255,255,255,.7);}
  .form-control{background:rgba(255,255,255,.09);border:1px solid rgba(255,255,255,.15);color:#fff;height:50px;border-radius:0;}
  .form-control::placeholder{color:rgba(255,255,255,.4);}
  .form-control:focus{background:rgba(255,255,255,.13);border-color:rgba(99,102,241,.6);color:#fff;box-shadow:0 0 0 3px rgba(99,102,241,.2);}
  .input-group>.form-control:first-child{border-radius:0 0 0 0;}
  .input-group{border-radius:14px;overflow:hidden;}
  .input-group .input-group-text:first-child{border-radius:14px 0 0 14px;}
  .input-group .form-control:last-child,.input-group .input-group-text:last-child{border-radius:0 14px 14px 0;}
  .input-group .form-control:only-of-type{border-radius:0;}
  .btn-login{background:linear-gradient(135deg,#6366f1,#a855f7);color:#fff;border:none;height:52px;border-radius:14px;font-weight:700;font-size:1.02rem;width:100%;transition:.25s;margin-top:6px;}
  .btn-login:hover{transform:translateY(-2px);box-shadow:0 10px 28px rgba(99,102,241,.45);color:#fff;}
  .link-text{text-align:center;color:rgba(255,255,255,.5);font-size:.9rem;margin-top:22px;}
  .link-text a{color:#a78bfa;font-weight:600;text-decoration:none;}
  .link-text a:hover{color:#c4b5fd;}
  .alert{border-radius:12px;font-size:.9rem;border:none;}
  .toggle-pw{cursor:pointer;background:rgba(255,255,255,.1);border:1px solid rgba(255,255,255,.15);}
  .toggle-pw:hover{background:rgba(255,255,255,.16);}
  .back-link{display:flex;align-items:center;gap:6px;color:rgba(255,255,255,.45);text-decoration:none;font-size:.88rem;margin-bottom:20px;width:fit-content;}
  .back-link:hover{color:rgba(255,255,255,.8);}
</style>
</head>
<body>
<div class="card-wrap">
  <a href="<%= request.getContextPath() %>/index.jsp" class="back-link"><i class="bi bi-arrow-left"></i>Back to Home</a>
  <div class="glass">
    <div class="brand-icon"><i class="bi bi-newspaper"></i></div>
    <h2>Welcome Back</h2>
    <p class="sub">Login to your personalised news dashboard</p>

    <%  String err = request.getParameter("error");
        String suc = request.getParameter("success");
        if (err != null && !err.isBlank()) { %>
    <div class="alert alert-danger text-dark bg-white"><i class="bi bi-exclamation-triangle-fill me-2"></i><%= err %></div>
    <% } if (suc != null && !suc.isBlank()) { %>
    <div class="alert alert-success text-dark bg-white"><i class="bi bi-check-circle-fill me-2"></i><%= suc %></div>
    <% } %>

    <form action="<%= request.getContextPath() %>/login" method="post">
      <div class="mb-3">
        <label class="form-label">Email Address</label>
        <div class="input-group">
          <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
          <input type="email" name="email" class="form-control" placeholder="you@example.com" required autocomplete="email">
        </div>
      </div>
      <div class="mb-4">
        <label class="form-label">Password</label>
        <div class="input-group">
          <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
          <input type="password" id="pw" name="password" class="form-control" placeholder="Your password" required autocomplete="current-password">
          <span class="input-group-text toggle-pw" onclick="togglePw('pw','ti')"><i class="bi bi-eye-fill" id="ti"></i></span>
        </div>
      </div>
      <button type="submit" class="btn-login"><i class="bi bi-box-arrow-in-right me-2"></i>Login</button>
    </form>
    <p class="link-text">Don't have an account? <a href="<%= request.getContextPath() %>/register.jsp">Register here</a></p>
  </div>
</div>
<script>
function togglePw(id,ic){
  const i=document.getElementById(id),ico=document.getElementById(ic);
  i.type=i.type==='password'?'text':'password';
  ico.className=i.type==='text'?'bi bi-eye-slash-fill':'bi bi-eye-fill';
}
</script>
</body></html>
