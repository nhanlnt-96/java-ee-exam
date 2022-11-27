package com.main.entity;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "categories")
@NamedQueries({
        @NamedQuery(name="Category.HQL.getByName",
                query = "SELECT c FROM Category c where c.name = :name"),
        @NamedQuery(name="Category.HQL.getByNameAndNotCategoryId",
                query = "SELECT c FROM Category c where c.name = :name and c.categoryId != :categoryId")
})
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "category_id")
    private Integer categoryId;

    @Column(name = "name")
    private String name;

    @OneToMany(mappedBy = "category")
    private Set<Movies> movies;

    public Category() {
    }


    public Category(String name) {
        this.name = name;
    }


    public Category(Integer categoryId, String name) {
        this.categoryId = categoryId;
        this.name = name;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Set<Movies> getMovies() {
        return movies;
    }

    public void setMovies(Set<Movies> movies) {
        this.movies = movies;
    }

    @Override
    public String toString() {
        return "Category{" + "categoryId=" + categoryId + ", name='" + name + '\'' + ", movies=" + movies + '}';
    }
}
