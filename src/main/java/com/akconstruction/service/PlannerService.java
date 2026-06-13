package com.akconstruction.service;

import com.akconstruction.model.*;
import com.akconstruction.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
public class PlannerService {

    @Autowired
    private PropertyDetailRepository propertyDetailRepository;

    @Autowired
    private HousePlanRepository housePlanRepository;

    @Autowired
    private CostEstimationRepository costEstimationRepository;

    @Autowired
    private MaterialEstimationRepository materialEstimationRepository;

    @Transactional
    public int generateAndSavePlan(PropertyDetail pd) {
        // 1. Save Property Details and get the generated ID
        int propertyId = propertyDetailRepository.save(pd);
        pd.setId(propertyId);

        // 2. Perform Civil Engineering and Planning Calculations
        double plotArea = pd.getLength() * pd.getWidth();
        pd.setPlotArea(plotArea);

        // Standard Indian municipal bylaws: ~70% ground coverage max
        double buildableArea = plotArea * 0.70; 
        double openArea = plotArea * 0.30;

        double parkingArea = pd.getParking().equalsIgnoreCase("Yes") ? Math.min(180.0, openArea * 0.6) : 0.0;
        double gardenArea = pd.getGarden().equalsIgnoreCase("Yes") ? Math.min(120.0, (openArea - parkingArea) * 0.8) : 0.0;

        // Ensure areas don't exceed limits
        if (parkingArea + gardenArea > openArea) {
            parkingArea = openArea * 0.5;
            gardenArea = openArea * 0.4;
        }

        double builtUpArea = buildableArea * pd.getFloors();

        // 3. Room Dimension and Layout Generation (JSON representation)
        String floorDetailsJson = generateFloorDetailsJson(pd);
        String roomDimensionsJson = generateRoomDimensionsJson(pd, buildableArea);

        // Recommendations text
        String recommendations = generateRecommendationsText(pd, buildableArea, openArea);

        HousePlan hp = new HousePlan();
        hp.setPropertyId(propertyId);
        hp.setBuildableArea(buildableArea);
        hp.setOpenArea(openArea);
        hp.setParkingArea(parkingArea);
        hp.setGardenArea(gardenArea);
        hp.setFloorDetails(floorDetailsJson);
        hp.setRoomDimensions(roomDimensionsJson);
        hp.setRecommendations(recommendations);
        hp.setApproved(false);
        housePlanRepository.save(hp);

        // 4. Cost Estimation Calculation
        double baseRate = 1800.0; // Default base rate per sq ft in INR
        if (pd.getStyle().equalsIgnoreCase("Luxury")) {
            baseRate = 3500.0;
        } else if (pd.getStyle().equalsIgnoreCase("Modern")) {
            baseRate = 2200.0;
        } else if (pd.getStyle().equalsIgnoreCase("Minimalist")) {
            baseRate = 1600.0;
        } else if (pd.getStyle().equalsIgnoreCase("Contemporary")) {
            baseRate = 2400.0;
        }

        // Adjust based on budget selection
        if (pd.getBudgetRange().contains("Under 20 Lakhs")) {
            baseRate = Math.min(baseRate, 1600.0);
        } else if (pd.getBudgetRange().contains("20 to 50 Lakhs")) {
            baseRate = Math.min(baseRate, 2200.0);
        } else if (pd.getBudgetRange().contains("50 Lakhs to 1 Crore")) {
            baseRate = Math.min(baseRate, 3000.0);
        }

        double totalCost = builtUpArea * baseRate;

        CostEstimation ce = new CostEstimation();
        ce.setPropertyId(propertyId);
        ce.setFoundationCost(totalCost * 0.10);
        ce.setWallCost(totalCost * 0.25);
        ce.setRoofCost(totalCost * 0.12);
        ce.setElectricalCost(totalCost * 0.08);
        ce.setPlumbingCost(totalCost * 0.07);
        ce.setFlooringCost(totalCost * 0.08);
        ce.setPaintingCost(totalCost * 0.06);
        ce.setInteriorCost(totalCost * 0.12);
        ce.setLaborCost(totalCost * 0.12);
        ce.setTotalCost(totalCost);
        costEstimationRepository.save(ce);

        // 5. Material Quantities Estimation (per sq ft factors)
        MaterialEstimation me = new MaterialEstimation();
        me.setPropertyId(propertyId);
        me.setCementBags((int) (builtUpArea * 0.4));
        me.setSteelKg(builtUpArea * 4.0);
        me.setBricksPcs((int) (builtUpArea * 22));
        me.setSandCft(builtUpArea * 1.8);
        me.setAggregateCft(builtUpArea * 1.35);
        me.setPaintLiters(builtUpArea * 0.15);
        me.setTilesSqft(builtUpArea * 1.1);
        materialEstimationRepository.save(me);

        return propertyId;
    }

    private String generateFloorDetailsJson(PropertyDetail pd) {
        StringBuilder json = new StringBuilder("{");
        
        // Ground Floor
        json.append("\"Ground Floor\":[\"Living Room\",\"Kitchen\",\"Dining Area\",\"Staircase\"");
        if (pd.getParking().equalsIgnoreCase("Yes")) json.append(",\"Parking\"");
        if (pd.getGarden().equalsIgnoreCase("Yes")) json.append(",\"Garden\"");
        if (pd.getBathrooms() > 0) json.append(",\"Guest Bathroom\"");
        if (pd.getBedrooms() > 2) json.append(",\"Guest Bedroom\"");
        json.append("]");

        // First Floor (if more than 1 floor, or has master bedroom)
        if (pd.getFloors() >= 2) {
            json.append(",\"First Floor\":[\"Master Bedroom\"");
            if (pd.getBedrooms() > 1) json.append(",\"Children Bedroom\"");
            if (pd.getBathrooms() > 1) json.append(",\"Master Bathroom\"");
            if (pd.getOffice().equalsIgnoreCase("Yes")) json.append(",\"Office Room\"");
            json.append(",\"Balcony\",\"Family Lounge\"]");
        }

        // Second Floor
        if (pd.getFloors() >= 3) {
            json.append(",\"Second Floor\":[\"Terrace\",\"Utility Area\"");
            if (pd.getPool().equalsIgnoreCase("Yes")) json.append(",\"Rooftop Pool\"");
            json.append(",\"Store Room\"]");
        }
        
        json.append("}");
        return json.toString();
    }

    private String generateRoomDimensionsJson(PropertyDetail pd, double buildableArea) {
        // Base proportions depending on overall footprint width and length
        double length = pd.getLength() * 0.83; // Adjusted buildable width/length
        double width = pd.getWidth() * 0.83;

        Map<String, String> dims = new HashMap<>();
        
        // Define room dimensions based on proportions of total width and length, respecting requested minimum sizes
        double livW = Math.max(12.0, width * 0.45);
        double livL = Math.max(15.0, length * 0.40);
        dims.put("Living Room", String.format("%.0fx%.0f", livW, livL));

        double kitW = Math.max(12.0, width * 0.35);
        double kitL = Math.max(8.0, length * 0.30);
        dims.put("Kitchen", String.format("%.0fx%.0f", kitW, kitL));

        double dinW = Math.max(10.0, width * 0.35);
        double dinL = Math.max(8.0, length * 0.25);
        dims.put("Dining Area", String.format("%.0fx%.0f", dinW, dinL));

        dims.put("Staircase", "10x8");
        
        if (pd.getParking().equalsIgnoreCase("Yes")) {
            dims.put("Parking", "12x15");
        }
        if (pd.getGarden().equalsIgnoreCase("Yes")) {
            dims.put("Garden", "12x10");
        }
        
        double gBathW = Math.max(8.0, width * 0.25);
        double gBathL = Math.max(5.0, length * 0.15);
        dims.put("Guest Bathroom", String.format("%.0fx%.0f", gBathW, gBathL));

        double gBedW = Math.max(12.0, width * 0.40);
        double gBedL = Math.max(12.0, length * 0.35);
        dims.put("Guest Bedroom", String.format("%.0fx%.0f", gBedW, gBedL));

        // First Floor Rooms
        double mBedW = Math.max(12.0, width * 0.45);
        double mBedL = Math.max(12.0, length * 0.40);
        dims.put("Master Bedroom", String.format("%.0fx%.0f", mBedW, mBedL));

        double cBedW = Math.max(10.0, width * 0.40);
        double cBedL = Math.max(10.0, length * 0.35);
        dims.put("Children Bedroom", String.format("%.0fx%.0f", cBedW, cBedL));

        dims.put("Master Bathroom", "8x6");
        dims.put("Office Room", "10x10");
        dims.put("Balcony", String.format("%.0fx5", width * 0.8));
        dims.put("Family Lounge", String.format("%.0fx%.0f", width * 0.40, length * 0.30));

        // Second Floor Rooms
        dims.put("Terrace", String.format("%.0fx%.0f", width, length * 0.5));
        dims.put("Utility Area", "8x7");
        dims.put("Rooftop Pool", "12x18");
        dims.put("Store Room", "8x8");

        // Create JSON format manually to avoid adding Jackson dependency overhead
        StringBuilder sb = new StringBuilder("{");
        boolean first = true;
        for (Map.Entry<String, String> entry : dims.entrySet()) {
            if (!first) sb.append(",");
            sb.append("\"").append(entry.getKey()).append("\":\"").append(entry.getValue()).append("\"");
            first = false;
        }
        sb.append("}");
        
        return sb.toString();
    }

    private String generateRecommendationsText(PropertyDetail pd, double buildable, double open) {
        StringBuilder rec = new StringBuilder();
        rec.append("Based on your property dimensions of ").append((int)pd.getLength()).append(" ft × ").append((int)pd.getWidth()).append(" ft (Plot Area: ").append((int)pd.getPlotArea()).append(" sq ft), we recommend a buildable footprint of ").append((int)buildable).append(" sq ft per floor with ").append((int)open).append(" sq ft of open space.\n\n");
        
        if (pd.getVastu().equalsIgnoreCase("Yes")) {
            rec.append("Vastu Shastra Recommendations Applied:\n");
            rec.append("- **Main Entrance**: Recommended facing North or East for prosperity.\n");
            rec.append("- **Kitchen Placement**: Allocated in the South-East corner (Agni corner) to optimize health and wellness.\n");
            rec.append("- **Master Bedroom**: Positioned in the South-West corner to ensure stability and growth.\n");
            rec.append("- **Bathrooms**: Located in the North-West or West side.\n");
            rec.append("- **Water Tank & Underground storage**: Positioned in the North-East side.\n\n");
        } else {
            rec.append("Standard Architectural Recommendations:\n");
            rec.append("- **Ventilation**: Windows strategically placed on East and West walls to capture natural cross-breezes.\n");
            rec.append("- **Kitchen & Utility**: Situated adjacent to each other to simplify plumbing grids.\n");
            rec.append("- **Staircase**: Placed centrally or near the foyer to enable easy access across floors.\n\n");
        }

        rec.append("Floor-wise Structural Allocations:\n");
        rec.append("- **Ground Floor**: Dedicated to high-activity public spaces including a spacious Living Room, modular Kitchen, dining zone, Guest Bedroom, and parking.\n");
        if (pd.getFloors() >= 2) {
            rec.append("- **First Floor**: Dedicated private floor with a master suite (featuring an attached bath), kids' room, an open balcony, family lounge, and study/office.\n");
        }
        if (pd.getFloors() >= 3) {
            rec.append("- **Second Floor**: Open roof terrace, mechanical utility room, washing yard, and rooftop leisure amenities.\n");
        }
        return rec.toString();
    }
}
