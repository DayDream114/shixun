package com.ecjtu.pojo;

public class User {
    private int id;
    private String username;
    private String password;
    private String tel;
    private String role;

    public User() {
    }

    public User(String username, String tel, String role) {
        this.username = username;
        this.tel = tel;
        this.role = role;
    }

    public User(int id, String username, String password, String tel, String role) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.tel = tel;
        this.role = role;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", tel='" + tel + '\'' +
                ", role='" + role + '\'' +
                '}';
    }
}
