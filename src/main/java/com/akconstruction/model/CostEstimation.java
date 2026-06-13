package com.akconstruction.model;

import java.sql.Timestamp;

public class CostEstimation {
    private int id;
    private int propertyId;
    private double foundationCost;
    private double wallCost;
    private double roofCost;
    private double electricalCost;
    private double plumbingCost;
    private double flooringCost;
    private double paintingCost;
    private double interiorCost;
    private double laborCost;
    private double totalCost;
    private Timestamp createdAt;

    public CostEstimation() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getPropertyId() { return propertyId; }
    public void setPropertyId(int propertyId) { this.propertyId = propertyId; }

    public double getFoundationCost() { return foundationCost; }
    public void setFoundationCost(double foundationCost) { this.foundationCost = foundationCost; }

    public double getWallCost() { return wallCost; }
    public void setWallCost(double wallCost) { this.wallCost = wallCost; }

    public double getRoofCost() { return roofCost; }
    public void setRoofCost(double roofCost) { this.roofCost = roofCost; }

    public double getElectricalCost() { return electricalCost; }
    public void setElectricalCost(double electricalCost) { this.electricalCost = electricalCost; }

    public double getPlumbingCost() { return plumbingCost; }
    public void setPlumbingCost(double plumbingCost) { this.plumbingCost = plumbingCost; }

    public double getFlooringCost() { return flooringCost; }
    public void setFlooringCost(double flooringCost) { this.flooringCost = flooringCost; }

    public double getPaintingCost() { return paintingCost; }
    public void setPaintingCost(double paintingCost) { this.paintingCost = paintingCost; }

    public double getInteriorCost() { return interiorCost; }
    public void setInteriorCost(double interiorCost) { this.interiorCost = interiorCost; }

    public double getLaborCost() { return laborCost; }
    public void setLaborCost(double laborCost) { this.laborCost = laborCost; }

    public double getTotalCost() { return totalCost; }
    public void setTotalCost(double totalCost) { this.totalCost = totalCost; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
