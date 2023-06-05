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
public class ProgramLearningObjective extends Objective {

    String mapToPO;

    public ProgramLearningObjective() {
    }

    public ProgramLearningObjective(int id, String name, String description, String createdAt, String updatedAt) {
        super(id, name, description, createdAt, updatedAt);
    }

    public ProgramLearningObjective(String mapToPO, int id, String name, String description, String createdAt, String updatedAt) {
        super(id, name, description, createdAt, updatedAt);
        this.mapToPO = mapToPO;
    }

    public String getMapToPO() {
        return mapToPO;
    }

    public void setMapToPO(String mapToPO) {
        this.mapToPO = mapToPO;
    }

}
