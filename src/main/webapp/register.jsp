<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Register — NewsNest</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
<style>
  *{box-sizing:border-box;}
  body{font-family:'Inter',sans-serif;min-height:100vh;margin:0;display:flex;align-items:center;justify-content:center;
       background:radial-gradient(ellipse 80% 70% at 70% 20%,rgba(168,85,247,.35),transparent),
                  radial-gradient(ellipse 60% 60% at 20% 80%,rgba(99,102,241,.28),transparent),#04071a;color:#fff;}
  .card-wrap{width:100%;max-width:520px;padding:24px 16px;}
  .glass{background:rgba(255,255,255,.07);border:1px solid rgba(255,255,255,.13);backdrop-filter:blur(22px);-webkit-backdrop-filter:blur(22px);border-radius:26px;padding:40px 36px;}
  .brand-icon{width:66px;height:66px;border-radius:20px;background:linear-gradient(135deg,#6366f1,#a855f7);display:flex;align-items:center;justify-content:center;font-size:1.6rem;margin:0 auto 20px;}
  h2{font-weight:800;font-size:1.65rem;text-align:center;margin-bottom:6px;}
  .sub{color:rgba(255,255,255,.55);text-align:center;margin-bottom:28px;font-size:.94rem;}
  .form-label{font-weight:600;font-size:.9rem;margin-bottom:7px;color:rgba(255,255,255,.85);}
  .input-group{border-radius:14px;overflow:hidden;}
  .input-group-text{background:rgba(255,255,255,.1);border:1px solid rgba(255,255,255,.15);color:rgba(255,255,255,.7);}
  .form-control{background:rgba(255,255,255,.09);border:1px solid rgba(255,255,255,.15);color:#fff;height:50px;}
  .form-control::placeholder{color:rgba(255,255,255,.4);}
  .form-control:focus{background:rgba(255,255,255,.13);border-color:rgba(99,102,241,.6);color:#fff;box-shadow:0 0 0 3px rgba(99,102,241,.2);}
  .btn-reg{background:linear-gradient(135deg,#6366f1,#a855f7);color:#fff;border:none;height:52px;border-radius:14px;font-weight:700;font-size:1.02rem;width:100%;transition:.25s;margin-top:6px;}
  .btn-reg:hover{transform:translateY(-2px);box-shadow:0 10px 28px rgba(99,102,241,.45);color:#fff;}
  .link-text{text-align:center;color:rgba(255,255,255,.5);font-size:.9rem;margin-top:22px;}
  .link-text a{color:#a78bfa;font-weight:600;text-decoration:none;}
  .alert{border-radius:12px;font-size:.9rem;border:none;}
  .toggle-pw{cursor:pointer;background:rgba(255,255,255,.1);border:1px solid rgba(255,255,255,.15);}
  .back-link{display:flex;align-items:center;gap:6px;color:rgba(255,255,255,.45);text-decoration:none;font-size:.88rem;margin-bottom:20px;}
  .back-link:hover{color:rgba(255,255,255,.8);}
</style>
</head>
<body>
<div class="card-wrap">
  <a href="<%= request.getContextPath() %>/index.jsp" class="back-link"><i class="bi bi-arrow-left"></i>Back to Home</a>
  <div class="glass">
    <div class="brand-icon"><i class="bi bi-newspaper"></i></div>
    <h2>Create Account</h2>
    <p class="sub">Join NewsNest and start your personalised news journey</p>

    <% String err = request.getParameter("error");
       if (err != null && !err.isBlank()) { %>
    <div class="alert alert-danger text-dark bg-white"><i class="bi bi-exclamation-triangle-fill me-2"></i><%= err %></div>
    <% } %>

    <form action="<%= request.getContextPath() %>/register" method="post">
      <div class="mb-3">
        <label class="form-label">Full Name</label>
        <div class="input-group">
          <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
          <input type="text" name="name" class="form-control" placeholder="Your full name" required>
        </div>
      </div>
      <div class="mb-3">
        <label class="form-label">Email Address</label>
        <div class="input-group">
          <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
          <input type="email" name="email" class="form-control" placeholder="you@example.com" required autocomplete="email">
        </div>
      </div>
      <div class="row g-3 mb-4">
        <div class="col-sm-6">
          <label class="form-label">Password</label>
          <div class="input-group">
            <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
            <input type="password" id="pw1" name="password" class="form-control" placeholder="Create password" required>
            <span class="input-group-text toggle-pw" onclick="tp('pw1','ti1')"><i class="bi bi-eye-fill" id="ti1"></i></span>
          </div>
        </div>
        <div class="col-sm-6">
          <label class="form-label">Confirm Password</label>
          <div class="input-group">
            <span class="input-group-text"><i class="bi bi-shield-lock-fill"></i></span>
            <input type="password" id="pw2" name="confirmPassword" class="form-control" placeholder="Repeat password" required>
            <span class="input-group-text toggle-pw" onclick="tp('pw2','ti2')"><i class="bi bi-eye-fill" id="ti2"></i></span>
          </div>
        </div>
      </div>
      <button type="submit" class="btn-reg"><i class="bi bi-person-plus-fill me-2"></i>Create Account</button>
    </form>
    <p class="link-text">Already have an account? <a href="<%= request.getContextPath() %>/login.jsp">Login here</a></p>
  </div>
</div>
<script>
function tp(id,ic){
  const i=document.getElementById(id),ico=document.getElementById(ic);
  i.type=i.type==='password'?'text':'password';
  ico.className=i.type==='text'?'bi bi-eye-slash-fill':'bi bi-eye-fill';
}
</script>
</body></html>
