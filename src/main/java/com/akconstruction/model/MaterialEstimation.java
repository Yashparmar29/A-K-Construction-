package com.akconstruction.model;

import java.sql.Timestamp;

public class MaterialEstimation {
    private int id;
    private int propertyId;
    private int cementBags;
    private double steelKg;
    private int bricksPcs;
    private double sandCft;
    private double aggregateCft;
    private double paintLiters;
    private double tilesSqft;
    private Timestamp createdAt;

    public MaterialEstimation() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getPropertyId() { return propertyId; }
    public void setPropertyId(int propertyId) { this.propertyId = propertyId; }

    public int getCementBags() { return cementBags; }
    public void setCementBags(int cementBags) { this.cementBags = cementBags; }

    public double getSteelKg() { return steelKg; }
    public void setSteelKg(double steelKg) { this.steelKg = steelKg; }

    public int getBricksPcs() { return bricksPcs; }
    public void setBricksPcs(int bricksPcs) { this.bricksPcs = bricksPcs; }

    public double getSandCft() { return sandCft; }
    public void setSandCft(double sandCft) { this.sandCft = sandCft; }

    public double getAggregateCft() { return aggregateCft; }
    public void setAggregateCft(double aggregateCft) { this.aggregateCft = aggregateCft; }

    public double getPaintLiters() { return paintLiters; }
    public void setPaintLiters(double paintLiters) { this.paintLiters = paintLiters; }

    public double getTilesSqft() { return tilesSqft; }
    public void setTilesSqft(double tilesSqft) { this.tilesSqft = tilesSqft; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
