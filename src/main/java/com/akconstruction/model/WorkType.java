package com.akconstruction.model;

import java.sql.Timestamp;

public class WorkType {
    private int id;
    private String name;
    private String description;
    private String category;
    private String status;
    private Timestamp createdAt;

    public WorkType() {}

    public WorkType(String name, String description, String category) {
        this.name = name;
        this.description = description;
        this.category = category;
        this.status = "ACTIVE";
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
