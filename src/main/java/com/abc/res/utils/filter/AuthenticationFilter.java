package com.abc.res.utils.filter;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
public class AuthenticationFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);
        String contextPath = req.getContextPath();
        String loginURI =  "/auth?action=login";
        String registerURI = "/auth?action=signup";
        String userDashboardURI = "/user/dashboard";
        String orderConfirmURI = "/order/confirm";
        boolean loggedIn = session != null && session.getAttribute("user_id") != null;
        boolean isAdminOrStaff = loggedIn && (session.getAttribute("ut_id").equals(1) || session.getAttribute("ut_id").equals(2));

        String requestURI = req.getRequestURI();
        String queryString = req.getQueryString();

        String fullRequestURI;
        if (queryString != null) {
            fullRequestURI = requestURI + "?" + queryString;
        } else {
            fullRequestURI = requestURI;
        }

        if (fullRequestURI.equals(loginURI) || fullRequestURI.equals(registerURI)) {
            if (loggedIn) {
                redirectBasedOnRole(req, res);
            } else {
                chain.doFilter(request, response);
            }
        } else if (fullRequestURI.equals(userDashboardURI) || fullRequestURI.startsWith(contextPath + "/user")) {
            if (isAdminOrStaff) {
                chain.doFilter(request, response);
            } else {
                res.sendRedirect(loginURI);
            }
        } else if (fullRequestURI.equals(orderConfirmURI)) {
            if (loggedIn) {
                chain.doFilter(request, response);
            } else {
                res.sendRedirect(loginURI);
            }
        } else {
            chain.doFilter(request, response);
        }
    }

    private void redirectBasedOnRole(HttpServletRequest req, HttpServletResponse res) throws IOException {
        Integer userTypeId = (Integer) req.getSession().getAttribute("ut_id");
        String contextPath = req.getContextPath();
        if (userTypeId != null) {
            switch (userTypeId) {
                case 1:
                case 2:
                    res.sendRedirect(contextPath + "/user/dashboard");
                    break;
                default:
                    res.sendRedirect(contextPath + "/");
                    break;
            }
        } else {
            res.sendRedirect(contextPath + "/");
        }
    }

    @Override
    public void destroy() {}
}