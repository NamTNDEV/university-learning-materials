/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entities;

/**
 *
 * @author duyba
 */
public class Question {
    private int id;
    private String name;
    private String details;
    private int sessionID;
    private boolean active;
    private int sessionIndexTable;

    public Question() {
    }

    public Question(int id, String name, String details, int sessionID, boolean active) {
        this.id = id;
        this.name = name;
        this.details = details;
        this.sessionID = sessionID;
        this.active = active;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public int getSessionID() {
        return sessionID;
    }

    public void setSessionID(int sessionID) {
        this.sessionID = sessionID;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public int getSessionIndexTable() {
        return sessionIndexTable;
    }

    public void setSessionIndexTable(int sessionIndexTable) {
        this.sessionIndexTable = sessionIndexTable;
    }
    
    
    
}