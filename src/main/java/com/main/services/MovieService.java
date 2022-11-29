package com.main.services;

import com.main.dao.MoviesDAO;
import com.main.entity.Movies;

import java.util.List;

public class MovieService {
    private MoviesDAO moviesDAO;

    public MovieService() {
        this.moviesDAO = new MoviesDAO();
    }

    public List<Movies> moviesList() {
        return moviesDAO.getListAll();
    }

    public Movies getById(Integer movieId) {
        return moviesDAO.getById(movieId);
    }

    public void delete(Integer movieId) {
        moviesDAO.deleteById(movieId);
    }


    public String create(Movies movie) {
        Movies existMovies = moviesDAO.getByName(movie.getName());

        if (existMovies != null) {
            return "The movie name already exists";
        }

        moviesDAO.create(movie);
        return null;
    }


    public String update(Movies movie) {
        Movies existMovies = moviesDAO.getByNameAndNotMoviesId(movie);

        if (existMovies != null) {
            return "The movie name already exists";
        }

        moviesDAO.update(movie);
        return null;
    }


    public List<Movies> searchMoviesByName(String name) {
        return moviesDAO.getMoviessByName(name);
    }
}
