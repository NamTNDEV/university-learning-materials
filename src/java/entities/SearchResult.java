/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entities;

/**
 *
 * @author quocb
 */
public class SearchResult {
    private int id;
    private String name;
    private String slug;
    private String root_slug;

    public SearchResult() {
    }

    public SearchResult(int id, String name, String slug, String root_slug) {
        this.id = id;
        this.name = name;
        this.slug = slug;
        this.root_slug = root_slug;
    }

    public String getRoot_slug() {
        return root_slug;
    }

    public void setRoot_slug(String root_slug) {
        this.root_slug = root_slug;
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

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }
    
    
}
