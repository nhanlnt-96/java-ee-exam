package com.main.entity;

import javax.persistence.*;
import java.util.Arrays;
import java.util.Base64;
import java.util.Date;

@Entity
@Table(name = "movies")
@NamedQueries({@NamedQuery(name = "Movies.HQL.getByName", query = "SELECT m FROM Movies m where m.name = :name"), @NamedQuery(name = "Movies.HQL.getByNameAndNotMoviesId", query = "SELECT m FROM Movies m where m.name = :name and m.movieId != :movieId")})
public class Movies {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "movie_id")
    private Integer movieId;

    @Column(name = "name")
    private String name;

    @Column(name = "director")
    private String director;

    @Column(name = "description")
    private String description;

    @Column(name = "publish_date")
    private Date publishDate;

    @Column(name = "image")
    private String image;

    @Column(name = "movie_link")
    private String movieLink;

    @ManyToOne()
    @JoinColumn(name = "category_id")
    private Category category;

    public Integer getMovieId() {
        return movieId;
    }

    public void setMovieId(Integer movieId) {
        this.movieId = movieId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getMovieLink() {
        return movieLink;
    }

    public void setMovieLink(String movieLink) {
        this.movieLink = movieLink;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return "Movies{" + "movieId=" + movieId + ", name='" + name + '\'' + ", director='" + director + '\'' + ", description='" + description + '\'' + ", publishDate=" + publishDate + ", image=" + image + ", movieLink='" + movieLink + '\'' + ", category=" + category + '}';
    }
}
