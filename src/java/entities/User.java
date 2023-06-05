/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.Date;

/**
 * @author Admin
 */
public class User implements Serializable {
    private String id;
    private String username;
    private String password;
    private String fullname;
    private String email;
    private String educationlevel;
    private String roleid;

    private Date createdAt;
    private Date updatedAt;

    private Boolean active;

    public User() {
    }

    public User(String id, String fullName, String email, String educationLevel, String roleID) {
        this.id = id;
        this.fullname = fullName;
        this.email = email;
        this.educationlevel = educationLevel;
        this.roleid = roleID;
    }

    public User(String id, String username, String password, String fullname, String email, String educationlevel, String roleid) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.email = email;
        this.educationlevel = educationlevel;
        this.roleid = roleid;
    }

    public User(String id, String username, String password, String fullname, String email, String educationlevel, String roleid, Date createdAt, Date updatedAt, Boolean active) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.email = email;
        this.educationlevel = educationlevel;
        this.roleid = roleid;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.active = active;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullname;
    }

    public void setFullName(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEducationLevel() {
        return educationlevel;
    }

    public void setEducationLevel(String educationlevel) {
        this.educationlevel = educationlevel;
    }

    public String getRoleID() {
        return roleid;
    }

    public void setRoleID(String roleid) {
        this.roleid = roleid;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }
}
