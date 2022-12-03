package com.main.filter;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/admin/*")
public class AdminLoginFilter implements Filter {
    public AdminLoginFilter() {
    }

    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;

        /**
         * getSession(parameter)
         * parameter = true: if not exist then create session
         * parameter = false: if not exist return null, else get session
         */
        HttpSession session = httpRequest.getSession(false);

        boolean isLoggedIn = session != null && session.getAttribute("userEmail") != null;

        /**
         * Exception cases
         */
        String loginURI = httpRequest.getContextPath() + "/admin/admin-login";
        boolean isLoginRequest = httpRequest.getRequestURI().equals(loginURI);
        boolean isLoginPage = httpRequest.getRequestURI().endsWith("login.jsp");

        if (isLoggedIn || isLoginRequest || isLoginPage) {
            chain.doFilter(request, response);
        } else {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/admin-login");
            dispatcher.forward(httpRequest, response);
        }
    }
}
