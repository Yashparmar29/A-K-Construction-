package com.akconstruction.model;

import java.sql.Timestamp;

public class HousePlan {
    private int id;
    private int propertyId;
    private double buildableArea;
    private double openArea;
    private double parkingArea;
    private double gardenArea;
    private String floorDetails;
    private String roomDimensions;
    private String recommendations;
    private boolean approved;
    private String architectDrawingUrl;
    private Timestamp createdAt;

    public HousePlan() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getPropertyId() { return propertyId; }
    public void setPropertyId(int propertyId) { this.propertyId = propertyId; }

    public double getBuildableArea() { return buildableArea; }
    public void setBuildableArea(double buildableArea) { this.buildableArea = buildableArea; }

    public double getOpenArea() { return openArea; }
    public void setOpenArea(double openArea) { this.openArea = openArea; }

    public double getParkingArea() { return parkingArea; }
    public void setParkingArea(double parkingArea) { this.parkingArea = parkingArea; }

    public double getGardenArea() { return gardenArea; }
    public void setGardenArea(double gardenArea) { this.gardenArea = gardenArea; }

    public String getFloorDetails() { return floorDetails; }
    public void setFloorDetails(String floorDetails) { this.floorDetails = floorDetails; }

    public String getRoomDimensions() { return roomDimensions; }
    public void setRoomDimensions(String roomDimensions) { this.roomDimensions = roomDimensions; }

    public String getRecommendations() { return recommendations; }
    public void setRecommendations(String recommendations) { this.recommendations = recommendations; }

    public boolean isApproved() { return approved; }
    public void setApproved(boolean approved) { this.approved = approved; }

    public String getArchitectDrawingUrl() { return architectDrawingUrl; }
    public void setArchitectDrawingUrl(String architectDrawingUrl) { this.architectDrawingUrl = architectDrawingUrl; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
