package com.akconstruction.repository;

import com.akconstruction.model.WorkType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class WorkTypeRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<WorkType> workTypeRowMapper = new RowMapper<WorkType>() {
        @Override
        public WorkType mapRow(ResultSet rs, int rowNum) throws SQLException {
            WorkType wt = new WorkType();
            wt.setId(rs.getInt("id"));
            wt.setName(rs.getString("name"));
            wt.setDescription(rs.getString("description"));
            wt.setCategory(rs.getString("category"));
            wt.setStatus(rs.getString("status"));
            wt.setCreatedAt(rs.getTimestamp("created_at"));
            return wt;
        }
    };

    public List<WorkType> findAll() {
        return jdbcTemplate.query("SELECT * FROM work_types ORDER BY name ASC", workTypeRowMapper);
    }

    public List<WorkType> findActive() {
        return jdbcTemplate.query("SELECT * FROM work_types WHERE status = 'ACTIVE' ORDER BY name ASC", workTypeRowMapper);
    }

    public WorkType findById(int id) {
        try {
            return jdbcTemplate.queryForObject("SELECT * FROM work_types WHERE id = ?", workTypeRowMapper, id);
        } catch (Exception e) {
            return null;
        }
    }

    public int save(WorkType wt) {
        String sql = "INSERT INTO work_types (name, description, category, status) VALUES (?, ?, ?, ?)";
        String status = (wt.getStatus() != null) ? wt.getStatus() : "ACTIVE";
        return jdbcTemplate.update(sql, wt.getName(), wt.getDescription(), wt.getCategory(), status);
    }

    public int update(WorkType wt) {
        String sql = "UPDATE work_types SET name = ?, description = ?, category = ?, status = ? WHERE id = ?";
        return jdbcTemplate.update(sql, wt.getName(), wt.getDescription(), wt.getCategory(), wt.getStatus(), wt.getId());
    }

    public int delete(int id) {
        return jdbcTemplate.update("DELETE FROM work_types WHERE id = ?", id);
    }

    public int count() {
        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM work_types", Integer.class);
        return count != null ? count : 0;
    }
}
