package com.akconstruction.model;

public class Project {
    private int id;
    private String title;
    private String category;
    private String image;
    private String description;

    public Project() {}

    public Project(int id, String title, String category, String image, String description) {
        this.id = id;
        this.title = title;
        this.category = category;
        this.image = image;
        this.description = description;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
