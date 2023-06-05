/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.util.Date;

/**
 *
 * @author giahu
 */
public class Syllabus {

    private int id;
    private String name;
    private int credit;
    private String description;
    private String tasks;
    private int scoringScale;
    private boolean status;
    private int minScore;
    private String createdAt;
    private String updatedAt;
    private boolean isApproved;
    private String subjectID;
    private String decisionNo;
    private String note;
    private String timeAllocation;
    private String tool;
    private int degreeLevelID;
    private boolean active;

    public Syllabus() {
    }

    public Syllabus(String subjectID, int credit, String description, String tasks, int scoringScale, int minScore) {
        this.subjectID = subjectID;
        this.credit = credit;
        this.description = description;
        this.tasks = tasks;
        this.scoringScale = scoringScale;
        this.minScore = minScore;
    }

    public Syllabus( int credit, String description, String tasks, int scoringScale, boolean status, int minScore, boolean isApproved, String subjectID, String decisionNo, String note, String timeAllocation, String tool, int degreeLevelID, boolean active) {
        this.credit = credit;
        this.description = description;
        this.tasks = tasks;
        this.scoringScale = scoringScale;
        this.status = status;
        this.minScore = minScore;
        this.isApproved = isApproved;
        this.subjectID = subjectID;
        this.decisionNo = decisionNo;
        this.note = note;
        this.timeAllocation = timeAllocation;
        this.tool = tool;
        this.degreeLevelID = degreeLevelID;
        this.active = active;
    }

    
    

    public Syllabus(int id, String name, int credit, String description, String tasks, int scoringScale, boolean status, int minScore, String createdAt, String updatedAt, boolean isApproved, String subjectID) {
        this.id = id;
        this.name = name;
        this.credit = credit;
        this.description = description;
        this.tasks = tasks;
        this.scoringScale = scoringScale;
        this.status = status;
        this.minScore = minScore;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.isApproved = isApproved;
        this.subjectID = subjectID;
    }

    public Syllabus(int id, String name, int credit, String description, String tasks, int scoringScale, boolean status, int minScore, String createdAt, String updatedAt, boolean isApproved, String subjectID, boolean active) {
        this.id = id;
        this.name = name;
        this.credit = credit;
        this.description = description;
        this.tasks = tasks;
        this.scoringScale = scoringScale;
        this.status = status;
        this.minScore = minScore;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.isApproved = isApproved;
        this.subjectID = subjectID;
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

    public int getCredit() {
        return credit;
    }

    public void setCredit(int credit) {
        this.credit = credit;
    }

    public String getDescription() {
        return description.replaceAll("\"", "");
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTasks() {
        return tasks;
    }

    public void setTasks(String tasks) {
        this.tasks = tasks;
    }

    public int getScoringScale() {
        return scoringScale;
    }

    public void setScoringScale(int scoringScale) {
        this.scoringScale = scoringScale;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getMinScore() {
        return minScore;
    }

    public void setMinScore(int minScore) {
        this.minScore = minScore;
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

    public boolean isIsApproved() {
        return isApproved;
    }

    public void setIsApproved(boolean isApproved) {
        this.isApproved = isApproved;
    }

    public String getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(String subjectID) {
        this.subjectID = subjectID;
    }

    public String getDecisionNo() {
        return decisionNo;
    }

    public void setDecisionNo(String decisionNo) {
        this.decisionNo = decisionNo;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getTimeAllocation() {
        return timeAllocation;
    }

    public void setTimeAllocation(String timeAllocation) {
        this.timeAllocation = timeAllocation;
    }

    public String getTool() {
        return tool;
    }

    public void setTool(String tool) {
        this.tool = tool;
    }

    public int getDegreeLevelID() {
        return degreeLevelID;
    }

    public void setDegreeLevelID(int degreeLevelID) {
        this.degreeLevelID = degreeLevelID;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

  

}