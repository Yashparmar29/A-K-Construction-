package com.akconstruction.repository;

import com.akconstruction.model.PdfReport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;

@Repository
public class PdfReportRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<PdfReport> rowMapper = new RowMapper<PdfReport>() {
        @Override
        public PdfReport mapRow(ResultSet rs, int rowNum) throws SQLException {
            PdfReport pr = new PdfReport();
            pr.setId(rs.getInt("id"));
            pr.setPropertyId(rs.getInt("property_id"));
            pr.setFilePath(rs.getString("file_path"));
            pr.setGeneratedAt(rs.getTimestamp("generated_at"));
            return pr;
        }
    };

    public int save(PdfReport pr) {
        String sql = "INSERT INTO pdf_reports (property_id, file_path) VALUES (?, ?)";
        return jdbcTemplate.update(sql, pr.getPropertyId(), pr.getFilePath());
    }

    public PdfReport findByPropertyId(int propertyId) {
        try {
            return jdbcTemplate.queryForObject(
                "SELECT * FROM pdf_reports WHERE property_id = ?", rowMapper, propertyId);
        } catch (Exception e) {
            return null;
        }
    }
}
