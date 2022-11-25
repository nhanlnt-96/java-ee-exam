package com.main.controllers.admin;

import com.main.dao.UserDAO;
import com.main.entity.User;
import com.main.services.UserService;
import com.main.utils.BCrypt;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/admin/add-new-user")
public class AddUserFormServlet extends HttpServlet {
    private UserDAO userDAO;
    private UserService userService;

    public AddUserFormServlet() {
        this.userDAO = new UserDAO();
        this.userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("user-form.jsp");
        requestDispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String theCommand = request.getParameter("command");

        if (theCommand == null) {
            theCommand = "LIST";
        }

        switch (theCommand) {
            case "INSERT":
                createNewUser(request, response);
                break;
//            case "UPDATE":
//                updateUser(request, response);
//                break;
//            default:
//                getUserList(request, response);
        }
    }

    private void createNewUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("message", null);

        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String password = request.getParameter("password");

        User newUser = new User(email, fullName, BCrypt.hashPassword(password));
        String errorMessage = userService.createUser(newUser);

        if (errorMessage != null) {
            request.setAttribute("message", errorMessage);
            request.setAttribute("theUser", newUser);
            RequestDispatcher rd = request.getRequestDispatcher("user-form.jsp");
            rd.forward(request, response);
            return;
        }

        response.sendRedirect("manage_user?command=LIST");
    }
}
