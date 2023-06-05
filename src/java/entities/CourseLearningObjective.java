/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entities;

/**
 *
 * @author quocb
 */
public class CourseLearningObjective extends Objective {

    private int syllabusID;
    private int mapToPLO;

    public CourseLearningObjective() {
    }

    public CourseLearningObjective(int syllabusID, int id, String name, String description, String createdAt, String updatedAt) {
        super(id, name, description, createdAt, updatedAt);
        this.syllabusID = syllabusID;
    }

    public int getSyllabusID() {
        return syllabusID;
    }

    public void setSyllabusID(int syllabusID) {
        this.syllabusID = syllabusID;
    }

    public int getMapToPLO() {
        return mapToPLO;
    }

    public void setMapToPLO(int mapToPLO) {
        this.mapToPLO = mapToPLO;
    }
    
    

}