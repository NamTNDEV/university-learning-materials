/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entities;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class Explore {

    private int id;
    private String code;
    private Date createdAt;
    private Date updatedAt;
    private String controller;
    private String type;

    public Explore(int id, String code, Date createdAt, Date updatedAt, String controller, String type) {
        this.id = id;
        this.code = code;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.controller = controller;
        this.type = type;
    }

    public Explore() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getController() {
        return controller;
    }

    public void setController(String controller) {
        this.controller = controller;
    }

    @Override
    public String toString() {
        return "Explore{" + "id=" + id + ", code=" + code + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", controller=" + controller + ", type=" + type + '}';
    }

}
