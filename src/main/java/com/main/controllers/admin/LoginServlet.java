package com.main.controllers.admin;

import com.main.dao.UserDAO;
import com.main.entity.User;
import com.main.services.UserService;
import com.main.utils.BCrypt;
import com.mysql.cj.log.Log;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/admin/admin-login")
public class LoginServlet extends HttpServlet {
    private UserService userService;

    public LoginServlet() {
        super();
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getSession().removeAttribute("userEmail");
        response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String errorMessage = userService.checkLogin(email, password);

        if (errorMessage != null) {
            request.setAttribute("message", errorMessage);

            /// http://localhost:8080/ebook/admin/login.jsp
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("login.jsp");
            requestDispatcher.forward(request, response);
            return;
        }

        request.getSession().setAttribute("userEmail", email);

        /// http://localhost:8080/ebook/admin/
        response.sendRedirect(request.getContextPath() + "/admin/");
    }
}
