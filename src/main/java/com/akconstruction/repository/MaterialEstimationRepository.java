package com.akconstruction.repository;

import com.akconstruction.model.MaterialEstimation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;

@Repository
public class MaterialEstimationRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<MaterialEstimation> rowMapper = new RowMapper<MaterialEstimation>() {
        @Override
        public MaterialEstimation mapRow(ResultSet rs, int rowNum) throws SQLException {
            MaterialEstimation me = new MaterialEstimation();
            me.setId(rs.getInt("id"));
            me.setPropertyId(rs.getInt("property_id"));
            me.setCementBags(rs.getInt("cement_bags"));
            me.setSteelKg(rs.getDouble("steel_kg"));
            me.setBricksPcs(rs.getInt("bricks_pcs"));
            me.setSandCft(rs.getDouble("sand_cft"));
            me.setAggregateCft(rs.getDouble("aggregate_cft"));
            me.setPaintLiters(rs.getDouble("paint_liters"));
            me.setTilesSqft(rs.getDouble("tiles_sqft"));
            me.setCreatedAt(rs.getTimestamp("created_at"));
            return me;
        }
    };

    public int save(MaterialEstimation me) {
        String sql = "INSERT INTO material_estimations (property_id, cement_bags, steel_kg, bricks_pcs, sand_cft, aggregate_cft, paint_liters, tiles_sqft) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        return jdbcTemplate.update(sql,
            me.getPropertyId(),
            me.getCementBags(),
            me.getSteelKg(),
            me.getBricksPcs(),
            me.getSandCft(),
            me.getAggregateCft(),
            me.getPaintLiters(),
            me.getTilesSqft()
        );
    }

    public MaterialEstimation findByPropertyId(int propertyId) {
        try {
            return jdbcTemplate.queryForObject(
                "SELECT * FROM material_estimations WHERE property_id = ?", rowMapper, propertyId);
        } catch (Exception e) {
            return null;
        }
    }
}
