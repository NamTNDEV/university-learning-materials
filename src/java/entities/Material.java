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
public class Material {

    private int id;
    private String name;
    private String materialUri;
    private int syllabusID;

    public Material() {
    }

    public Material(int id, String name, String materialUri, int syllabusID) {
        this.id = id;
        this.name = name;
        this.materialUri = materialUri;
        this.syllabusID = syllabusID;
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

    public String getMaterialUri() {
        return materialUri;
    }

    public void setMaterialUri(String materialUri) {
        this.materialUri = materialUri;
    }

    public int getSyllabusID() {
        return syllabusID;
    }

    public void setSyllabusID(int syllabusID) {
        this.syllabusID = syllabusID;
    }

}
