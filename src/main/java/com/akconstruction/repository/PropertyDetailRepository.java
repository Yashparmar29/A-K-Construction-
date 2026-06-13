package com.akconstruction.repository;

import com.akconstruction.model.PropertyDetail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.*;
import java.util.List;

@Repository
public class PropertyDetailRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<PropertyDetail> rowMapper = new RowMapper<PropertyDetail>() {
        @Override
        public PropertyDetail mapRow(ResultSet rs, int rowNum) throws SQLException {
            PropertyDetail pd = new PropertyDetail();
            pd.setId(rs.getInt("id"));
            pd.setUserId(rs.getInt("user_id"));
            pd.setOwnerName(rs.getString("owner_name"));
            pd.setEmail(rs.getString("email"));
            pd.setPhone(rs.getString("phone"));
            pd.setLength(rs.getDouble("length"));
            pd.setWidth(rs.getDouble("width"));
            pd.setPlotArea(rs.getDouble("plot_area"));
            pd.setFloors(rs.getInt("floors"));
            pd.setBedrooms(rs.getInt("bedrooms"));
            pd.setBathrooms(rs.getInt("bathrooms"));
            pd.setKitchenType(rs.getString("kitchen_type"));
            pd.setParking(rs.getString("parking"));
            pd.setGarden(rs.getString("garden"));
            pd.setPool(rs.getString("pool"));
            pd.setOffice(rs.getString("office"));
            pd.setBudgetRange(rs.getString("budget_range"));
            pd.setStyle(rs.getString("style"));
            pd.setVastu(rs.getString("vastu"));
            pd.setCity(rs.getString("city"));
            pd.setState(rs.getString("state"));
            pd.setCountry(rs.getString("country"));
            pd.setNotes(rs.getString("notes"));
            pd.setCreatedAt(rs.getTimestamp("created_at"));
            return pd;
        }
    };

    public int save(final PropertyDetail pd) {
        final String sql = "INSERT INTO property_details (user_id, owner_name, email, phone, length, width, plot_area, floors, bedrooms, bathrooms, kitchen_type, parking, garden, pool, office, budget_range, style, vastu, city, state, country, notes) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        GeneratedKeyHolder keyHolder = new GeneratedKeyHolder();
        jdbcTemplate.update(new PreparedStatementCreator() {
            @Override
            public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setInt(1, pd.getUserId());
                ps.setString(2, pd.getOwnerName());
                ps.setString(3, pd.getEmail());
                ps.setString(4, pd.getPhone());
                ps.setDouble(5, pd.getLength());
                ps.setDouble(6, pd.getWidth());
                ps.setDouble(7, pd.getPlotArea());
                ps.setInt(8, pd.getFloors());
                ps.setInt(9, pd.getBedrooms());
                ps.setInt(10, pd.getBathrooms());
                ps.setString(11, pd.getKitchenType());
                ps.setString(12, pd.getParking());
                ps.setString(13, pd.getGarden());
                ps.setString(14, pd.getPool());
                ps.setString(15, pd.getOffice());
                ps.setString(16, pd.getBudgetRange());
                ps.setString(17, pd.getStyle());
                ps.setString(18, pd.getVastu());
                ps.setString(19, pd.getCity());
                ps.setString(20, pd.getState());
                ps.setString(21, pd.getCountry());
                ps.setString(22, pd.getNotes());
                return ps;
            }
        }, keyHolder);
        Number key = keyHolder.getKey();
        return key != null ? key.intValue() : 0;
    }

    public PropertyDetail findById(int id) {
        try {
            return jdbcTemplate.queryForObject(
                "SELECT * FROM property_details WHERE id = ?", rowMapper, id);
        } catch (Exception e) {
            return null;
        }
    }

    public List<PropertyDetail> findByUserId(int userId) {
        return jdbcTemplate.query(
            "SELECT * FROM property_details WHERE user_id = ? ORDER BY created_at DESC",
            rowMapper, userId);
    }

    public List<PropertyDetail> findAll() {
        return jdbcTemplate.query(
            "SELECT * FROM property_details ORDER BY created_at DESC", rowMapper);
    }
    
    public int delete(int id) {
        return jdbcTemplate.update("DELETE FROM property_details WHERE id = ?", id);
    }
}
