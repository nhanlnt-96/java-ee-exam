package com.main.controllers.admin;

import com.main.dao.UserDAO;
import com.main.entity.User;
import com.main.services.UserService;
import com.main.utils.BCrypt;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/manage-user")
public class UserController extends HttpServlet {
    private UserDAO userDAO;
    private UserService userService;

    public UserController() {
        this.userDAO = new UserDAO();
        this.userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String theCommand = request.getParameter("command");

        if (theCommand == null) {
            theCommand = "LIST";
        }

        switch (theCommand) {
            case "LIST":
                getUserList(request, response);
                break;
            case "NEW":
                showNewForm(request, response);
                break;
            case "LOAD":
                showEditForm(request, response);
                break;
            case "DELETE":
                deleteUser(request, response);
                break;
            default:
                getUserList(request, response);
        }
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
            case "UPDATE":
                updateUser(request, response);
                break;
            default:
                getUserList(request, response);
        }
    }

    private void getUserList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // get data
        List<User> userList = this.userDAO.getListAll();

        /// pass data to JSP
        request.setAttribute("userList", userList);

        RequestDispatcher dispatcher = request.getRequestDispatcher("user-list.jsp");
        dispatcher.forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Integer theUserId = Integer.valueOf(request.getParameter("userId"));

        User userToUpdate = this.userService.getUserById(theUserId);
        session.setAttribute("theUser", userToUpdate);

        response.sendRedirect("user-form.jsp");
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        session.setAttribute("theUser", null);

        response.sendRedirect("user-form.jsp");
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

        response.sendRedirect("manage-user?command=LIST");
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Integer userId = Integer.valueOf(request.getParameter("userId"));
        String fullName = request.getParameter("fullName");
        String password = request.getParameter("password");

        User userToUpdate = userService.getUserById(userId);
        userToUpdate.setFullName(fullName);
        if (!password.isEmpty()) {
            System.out.println(password);
            userToUpdate.setPassword(BCrypt.verifyPassword(password, userToUpdate.getPassword()) ? password : BCrypt.hashPassword(password));
        } else {
            System.out.println(userToUpdate.getPassword());
            userToUpdate.setPassword(userToUpdate.getPassword());
        }
        String errorMessage = this.userService.update(userToUpdate);

        if (errorMessage != null) {
            request.setAttribute("message", errorMessage);
            RequestDispatcher rd = request.getRequestDispatcher("user-form.jsp");
            rd.forward(request, response);
            return;
        }

        response.sendRedirect("manage-user?command=LIST");
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer userId = Integer.valueOf(request.getParameter("userId"));
        userService.deleteUser(userId);

        response.sendRedirect("manage-user?command=LIST");
    }
}
