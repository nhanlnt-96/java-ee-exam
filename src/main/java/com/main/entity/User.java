package com.main.entity;

import javax.persistence.*;

@Entity
@Table(name = "users")
@NamedQueries({
        @NamedQuery(name="User.HQL.findByEmail", query = "SELECT u FROM User u where u.email = :email"),
        @NamedQuery(name="User.HQL.getUserById", query = "SELECT u FROM User u where u.userId = :userId"),
        @NamedQuery(name="User.HQL.findByEmailAndNotUserId", query = "SELECT u FROM User u where u.email = :email and u.userId != :userId"),
        @NamedQuery(name="User.HQL.checkLogin", query = "SELECT u FROM User u where u.email = :email and u.password = :password")
})
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Integer userId;

    @Column(name = "email")
    private String email;

    @Column(name = "full_name")
    private String fullName;

    @Column(name = "password")
    private String password;

    public User(String email, String fullName, String password) {
        this.email = email;
        this.fullName = fullName;
        this.password = password;
    }

    public User() {
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "User{" + "userId=" + userId + ", email='" + email + '\'' + ", fullName='" + fullName + '\'' + ", password='" + password + '\'' + '}';
    }
}
