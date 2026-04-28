package com.news.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

@WebFilter(urlPatterns = {"/categories", "/news", "/article-click", "/history",
                          "/dashboard.jsp", "/categories.jsp", "/articleDetails.jsp"})
public class AuthFilter implements Filter {

    @Override public void init(FilterConfig cfg) {}
    @Override public void destroy() {}

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest  hReq  = (HttpServletRequest)  req;
        HttpServletResponse hRes  = (HttpServletResponse) res;
        HttpSession         session = hReq.getSession(false);
        boolean loggedIn = session != null && session.getAttribute("loggedInUser") != null;
        if (loggedIn) {
            chain.doFilter(req, res);
        } else {
            hRes.sendRedirect(hReq.getContextPath() + "/login.jsp?error=Please+login+first");
        }
    }
}
