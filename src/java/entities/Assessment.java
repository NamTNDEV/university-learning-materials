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
public class Assessment {

    private int id;
    private String category;
    private String type;
    private int part;
    private double weight;
    private String completionCriteria;
    private String duration;
    private String questionType;
    private String numberOfQuestion;
    private String knowledgeScope;
    private String gradingGuide;
    private String note;
    private int syllabusID;
    private boolean active;
    private String mapToCLO;

    public Assessment() {
    }

    public Assessment(int id, String categoy, String type, int part, double weight, String completionCriteria, String duration, String questionType, String numberOfQuestion, String knowledgeScope, String gradingGuide, String note, int syllabusID) {
        this.id = id;
        this.category = categoy;
        this.type = type;
        this.part = part;
        this.weight = weight;
        this.completionCriteria = completionCriteria;
        this.duration = duration;
        this.questionType = questionType;
        this.numberOfQuestion = numberOfQuestion;
        this.knowledgeScope = knowledgeScope;
        this.gradingGuide = gradingGuide;
        this.note = note;
        this.syllabusID = syllabusID;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getPart() {
        return part;
    }

    public void setPart(int part) {
        this.part = part;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public String getCompletionCriteria() {
        return completionCriteria;
    }

    public void setCompletionCriteria(String completionCriteria) {
        this.completionCriteria = completionCriteria;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }


    public String getQuestionType() {
        return questionType;
    }

    public void setQuestionType(String questionType) {
        this.questionType = questionType;
    }

    public String getNumberOfQuestion() {
        return numberOfQuestion;
    }

    public void setNumberOfQuestion(String numberOfQuestion) {
        this.numberOfQuestion = numberOfQuestion;
    }

    public String getKnowledgeScope() {
        return knowledgeScope;
    }

    public void setKnowledgeScope(String knowledgeScope) {
        this.knowledgeScope = knowledgeScope;
    }

    public String getGradingGuide() {
        return gradingGuide;
    }

    public void setGradingGuide(String gradingGuide) {
        this.gradingGuide = gradingGuide;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getSyllabusID() {
        return syllabusID;
    }

    public void setSyllabusID(int syllabusID) {
        this.syllabusID = syllabusID;
    }

    public void setMapToCLO(String mapToCLO) {
        this.mapToCLO = mapToCLO;
    }

    public String getMapToCLO() {
        return mapToCLO;
    }

}