/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

/**
 *
 * @author giahu
 */
public class Curriculum {

    private int id;
    private String code;
    private String name;
    private String description;
    private String decisionNo;
    private String viName;
    private String createdAt;
    private String updatedAt;
    private Boolean active;

    public Curriculum() {
    }

    public Curriculum(int id, String code, String name, String description, String decisionNo, String viName, String createdAt, String updatedAt) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.description = description;
        this.decisionNo = decisionNo;
        this.viName = viName;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Curriculum(int id, String code, String name, String description, String decisionNo, String viName, String createdAt, String updatedAt, Boolean active) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.description = description;
        this.decisionNo = decisionNo;
        this.viName = viName;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.active = active;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDecisionNo() {
        return decisionNo;
    }

    public void setDecisionNo(String decisionNo) {
        this.decisionNo = decisionNo;
    }

    public String getViName() {
        return viName;
    }

    public void setViName(String viName) {
        this.viName = viName;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }
    
}
