package com.akconstruction.model;

import java.sql.Timestamp;

public class PropertyDetail {
    private int id;
    private int userId;
    private String ownerName;
    private String email;
    private String phone;
    private double length;
    private double width;
    private double plotArea;
    private int floors;
    private int bedrooms;
    private int bathrooms;
    private String kitchenType;
    private String parking;
    private String garden;
    private String pool;
    private String office;
    private String budgetRange;
    private String style;
    private String vastu;
    private String city;
    private String state;
    private String country;
    private String notes;
    private Timestamp createdAt;

    public PropertyDetail() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getOwnerName() { return ownerName; }
    public void setOwnerName(String ownerName) { this.ownerName = ownerName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public double getLength() { return length; }
    public void setLength(double length) { this.length = length; }

    public double getWidth() { return width; }
    public void setWidth(double width) { this.width = width; }

    public double getPlotArea() { return plotArea; }
    public void setPlotArea(double plotArea) { this.plotArea = plotArea; }

    public int getFloors() { return floors; }
    public void setFloors(int floors) { this.floors = floors; }

    public int getBedrooms() { return bedrooms; }
    public void setBedrooms(int bedrooms) { this.bedrooms = bedrooms; }

    public int getBathrooms() { return bathrooms; }
    public void setBathrooms(int bathrooms) { this.bathrooms = bathrooms; }

    public String getKitchenType() { return kitchenType; }
    public void setKitchenType(String kitchenType) { this.kitchenType = kitchenType; }

    public String getParking() { return parking; }
    public void setParking(String parking) { this.parking = parking; }

    public String getGarden() { return garden; }
    public void setGarden(String garden) { this.garden = garden; }

    public String getPool() { return pool; }
    public void setPool(String pool) { this.pool = pool; }

    public String getOffice() { return office; }
    public void setOffice(String office) { this.office = office; }

    public String getBudgetRange() { return budgetRange; }
    public void setBudgetRange(String budgetRange) { this.budgetRange = budgetRange; }

    public String getStyle() { return style; }
    public void setStyle(String style) { this.style = style; }

    public String getVastu() { return vastu; }
    public void setVastu(String vastu) { this.vastu = vastu; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getState() { return state; }
    public void setState(String state) { this.state = state; }

    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
