package com.akconstruction.repository;

import com.akconstruction.model.CostEstimation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;

@Repository
public class CostEstimationRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<CostEstimation> rowMapper = new RowMapper<CostEstimation>() {
        @Override
        public CostEstimation mapRow(ResultSet rs, int rowNum) throws SQLException {
            CostEstimation ce = new CostEstimation();
            ce.setId(rs.getInt("id"));
            ce.setPropertyId(rs.getInt("property_id"));
            ce.setFoundationCost(rs.getDouble("foundation_cost"));
            ce.setWallCost(rs.getDouble("wall_cost"));
            ce.setRoofCost(rs.getDouble("roof_cost"));
            ce.setElectricalCost(rs.getDouble("electrical_cost"));
            ce.setPlumbingCost(rs.getDouble("plumbing_cost"));
            ce.setFlooringCost(rs.getDouble("flooring_cost"));
            ce.setPaintingCost(rs.getDouble("painting_cost"));
            ce.setInteriorCost(rs.getDouble("interior_cost"));
            ce.setLaborCost(rs.getDouble("labor_cost"));
            ce.setTotalCost(rs.getDouble("total_cost"));
            ce.setCreatedAt(rs.getTimestamp("created_at"));
            return ce;
        }
    };

    public int save(CostEstimation ce) {
        String sql = "INSERT INTO cost_estimations (property_id, foundation_cost, wall_cost, roof_cost, electrical_cost, plumbing_cost, flooring_cost, painting_cost, interior_cost, labor_cost, total_cost) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql,
            ce.getPropertyId(),
            ce.getFoundationCost(),
            ce.getWallCost(),
            ce.getRoofCost(),
            ce.getElectricalCost(),
            ce.getPlumbingCost(),
            ce.getFlooringCost(),
            ce.getPaintingCost(),
            ce.getInteriorCost(),
            ce.getLaborCost(),
            ce.getTotalCost()
        );
    }

    public CostEstimation findByPropertyId(int propertyId) {
        try {
            return jdbcTemplate.queryForObject(
                "SELECT * FROM cost_estimations WHERE property_id = ?", rowMapper, propertyId);
        } catch (Exception e) {
            return null;
        }
    }
}
