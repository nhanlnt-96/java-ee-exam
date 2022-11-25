package com.main.dao;

import com.main.entity.Movies;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MoviesDAO extends JpaDAO<Movies> {
    public MoviesDAO() {
        super(Movies.class);
    }

    @Override
    public Movies create(Movies object) {
        return super.create(object);
    }

    @Override
    public Movies update(Movies object) {
        return super.update(object);
    }

    @Override
    public Movies getById(Object objectId) {
        return super.getById(objectId);
    }

    @Override
    public List<Movies> getListAll() {
        return super.getListAll();
    }

    @Override
    public void deleteById(Object objectId) {
        super.deleteById(objectId);
    }

    @Override
    public long getTotalRecord() {
        return super.getTotalRecord();
    }


    public Movies getByName(String name) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("name", name);

        List<Movies> moviesList = super.getNamedEqueryWithParams("Movies.HQL.getByName", params);

        /// get first record
        if (moviesList != null && moviesList.size() > 0) {
            return moviesList.get(0);
        }

        return null;
    }


    public Movies getByNameAndNotMoviesId(Movies movies) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("name", movies.getName());
        params.put("moviesId", movies.getMovieId());

        List<Movies> moviesList = super.getNamedEqueryWithParams("Movies.HQL.getByNameAndNotMoviesId", params);

        /// get first record
        if (moviesList != null && moviesList.size() > 0) {
            return moviesList.get(0);
        }

        return null;
    }

    public List<Movies> getMoviessByName(String name) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("name", name);

        List<Movies> moviesList = super.getNamedEqueryWithParams("Movies.HQL.getByName", params);

        return moviesList;
    }
}
