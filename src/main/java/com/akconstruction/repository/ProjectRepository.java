package com.akconstruction.repository;

import com.akconstruction.model.Project;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ProjectRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<Project> projectRowMapper = new RowMapper<Project>() {
        @Override
        public Project mapRow(ResultSet rs, int rowNum) throws SQLException {
            Project project = new Project();
            project.setId(rs.getInt("id"));
            project.setTitle(rs.getString("title"));
            project.setCategory(rs.getString("category"));
            project.setImage(rs.getString("image"));
            project.setDescription(rs.getString("description"));
            return project;
        }
    };

    public List<Project> findAll() {
        return jdbcTemplate.query("SELECT * FROM projects ORDER BY created_date DESC", projectRowMapper);
    }

    public List<Project> findByCategory(String category) {
        return jdbcTemplate.query(
            "SELECT * FROM projects WHERE category = ? ORDER BY created_date DESC",
            projectRowMapper, category
        );
    }

    public int save(Project project) {
        return jdbcTemplate.update(
            "INSERT INTO projects (title, category, image, description) VALUES (?, ?, ?, ?)",
            project.getTitle(), project.getCategory(), project.getImage(), project.getDescription()
        );
    }
}
