package com.main.controllers.admin;

import com.main.entity.Category;
import com.main.entity.Movies;
import com.main.services.CategoryService;
import com.main.services.MovieService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/manage-movies")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1,    // if file > 1MB, store disk instead RAM
        maxFileSize = 1024 * 1024 * 10,            // maximum file size = 10MB
        maxRequestSize = 1024 * 1024 * 100        //maximum request size = 100MB
)
public class MoviesController extends HttpServlet {
    private MovieService movieService;
    private CategoryService categoryService;

    public MoviesController() {
        super();
        movieService = new MovieService();
        categoryService = new CategoryService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String theCommand = request.getParameter("command");

        if (theCommand == null) {
            theCommand = "LIST";
        }

        switch (theCommand) {
            case "LIST":
                getList(request, response);
                break;
            case "NEW":
                showNewForm(request, response);
                break;
            case "LOAD":
                showEditForm(request, response);
                break;
            case "DELETE":
                delete(request, response);
                break;
            default:
                getList(request, response);
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
                insert(request, response);
                break;
            case "UPDATE":
                update(request, response);
                break;
            default:
                getList(request, response);
        }
    }

    private void getList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // get data
        List<Movies> moviesList = movieService.moviesList();

        /// pass data to JSP
        request.setAttribute("moviesList", moviesList);

        RequestDispatcher dispatcher = request.getRequestDispatcher("movies-list.jsp");
        dispatcher.forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Category> categoryList = categoryService.listCategory();

        HttpSession session = request.getSession();
        session.setAttribute("theMovie", null);
        session.setAttribute("categoryList", categoryList);

        response.sendRedirect("movies-form.jsp");
    }


    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Integer theMovieId = Integer.valueOf(request.getParameter("movieId"));

        Movies movieToUpdate = movieService.getById(theMovieId);
        session.setAttribute("theMovie", movieToUpdate);

        List<Category> categoryList = categoryService.listCategory();
        request.getSession().setAttribute("categoryList", categoryList);

        response.sendRedirect("movies-form.jsp");
    }

    private void insert(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Movies newMovie = new Movies();

        System.out.println("category: " + request.getParameter("category"));
        System.out.println("name: " + request.getParameter("name"));
        System.out.println("director: " + request.getParameter("director"));
        System.out.println("movieLink: " + request.getParameter("movieLink"));
        System.out.println("description: " + request.getParameter("description"));

        Integer categoryId = Integer.parseInt(request.getParameter("category"));
        Category category = categoryService.getById(categoryId);

        newMovie.setName(request.getParameter("name"));
        newMovie.setDirector(request.getParameter("director"));
        newMovie.setDescription(request.getParameter("description"));
        newMovie.setCategory(category);
        newMovie.setMovieLink(request.getParameter("movieLink"));

        try {
            DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date publishDate = dateFormat.parse(request.getParameter("publishDate"));
            newMovie.setPublishDate(publishDate);
        } catch (ParseException e) {
            e.printStackTrace();
            throw new ServletException("The format date is yyyy-MM-dd");
        }

        Part filePart = request.getPart("image");

        if (filePart != null & filePart.getSize() > 0) {
            long size = filePart.getSize();
            byte[] imageBytes = new byte[(int) size];

            InputStream inputStream = filePart.getInputStream();
            inputStream.read(imageBytes);
            inputStream.close();

            newMovie.setImage(imageBytes);
        }

        System.out.println("new movie" + newMovie);

        String errorMessage = this.movieService.create(newMovie);
        if (errorMessage != null) {
            request.setAttribute("message", errorMessage);
            request.setAttribute("theMovie", newMovie);
            RequestDispatcher rd = request.getRequestDispatcher("movies-form.jsp");
            rd.forward(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/admin/");
    }


    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
//		Integer movieId = Integer.valueOf(request.getParameter("movieId"));
//		String name = request.getParameter("name");
//
//		Movie productToUpdate = new Movie(movieId, name);
//		String errorMessage = productService.update(productToUpdate);
//
//		if (errorMessage != null) {
//			request.setAttribute("message", errorMessage);
//			RequestDispatcher rd = request.getRequestDispatcher("product-form.jsp");
//			rd.forward(request, response);
//			return;
//		}
//
//		response.sendRedirect("manage_product?command=LIST");
    }


    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Integer movieId = Integer.valueOf(request.getParameter("movieId"));
        movieService.delete(movieId);

        response.sendRedirect("manage_product?command=LIST");
    }
}
