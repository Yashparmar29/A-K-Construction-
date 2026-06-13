package com.akconstruction.repository;

import com.akconstruction.model.HousePlan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;

@Repository
public class HousePlanRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<HousePlan> rowMapper = new RowMapper<HousePlan>() {
        @Override
        public HousePlan mapRow(ResultSet rs, int rowNum) throws SQLException {
            HousePlan hp = new HousePlan();
            hp.setId(rs.getInt("id"));
            hp.setPropertyId(rs.getInt("property_id"));
            hp.setBuildableArea(rs.getDouble("buildable_area"));
            hp.setOpenArea(rs.getDouble("open_area"));
            hp.setParkingArea(rs.getDouble("parking_area"));
            hp.setGardenArea(rs.getDouble("garden_area"));
            hp.setFloorDetails(rs.getString("floor_details"));
            hp.setRoomDimensions(rs.getString("room_dimensions"));
            hp.setRecommendations(rs.getString("recommendations"));
            hp.setApproved(rs.getBoolean("is_approved"));
            hp.setArchitectDrawingUrl(rs.getString("architect_drawing_url"));
            hp.setCreatedAt(rs.getTimestamp("created_at"));
            return hp;
        }
    };

    public int save(HousePlan hp) {
        String sql = "INSERT INTO house_plans (property_id, buildable_area, open_area, parking_area, garden_area, floor_details, room_dimensions, recommendations, is_approved, architect_drawing_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql,
            hp.getPropertyId(),
            hp.getBuildableArea(),
            hp.getOpenArea(),
            hp.getParkingArea(),
            hp.getGardenArea(),
            hp.getFloorDetails(),
            hp.getRoomDimensions(),
            hp.getRecommendations(),
            hp.isApproved(),
            hp.getArchitectDrawingUrl()
        );
    }

    public HousePlan findByPropertyId(int propertyId) {
        try {
            return jdbcTemplate.queryForObject(
                "SELECT * FROM house_plans WHERE property_id = ?", rowMapper, propertyId);
        } catch (Exception e) {
            return null;
        }
    }

    public int update(HousePlan hp) {
        String sql = "UPDATE house_plans SET buildable_area = ?, open_area = ?, parking_area = ?, garden_area = ?, floor_details = ?, room_dimensions = ?, recommendations = ?, is_approved = ?, architect_drawing_url = ? WHERE property_id = ?";
        return jdbcTemplate.update(sql,
            hp.getBuildableArea(),
            hp.getOpenArea(),
            hp.getParkingArea(),
            hp.getGardenArea(),
            hp.getFloorDetails(),
            hp.getRoomDimensions(),
            hp.getRecommendations(),
            hp.isApproved(),
            hp.getArchitectDrawingUrl(),
            hp.getPropertyId()
        );
    }
}
