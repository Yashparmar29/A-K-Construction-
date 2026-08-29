package com.akconstruction.repository;

import com.akconstruction.model.WorkerWorkAssignment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class WorkerWorkAssignmentRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<WorkerWorkAssignment> assignmentRowMapper = new RowMapper<WorkerWorkAssignment>() {
        @Override
        public WorkerWorkAssignment mapRow(ResultSet rs, int rowNum) throws SQLException {
            WorkerWorkAssignment wwa = new WorkerWorkAssignment();
            wwa.setId(rs.getInt("id"));
            wwa.setWorkerId(rs.getInt("worker_id"));
            wwa.setContractorId(rs.getInt("contractor_id"));
            wwa.setProjectId(rs.getInt("project_id"));
            wwa.setWorkTypeId(rs.getInt("work_type_id"));
            wwa.setTaskTitle(rs.getString("task_title"));
            wwa.setTaskDescription(rs.getString("task_description"));
            wwa.setStartDate(rs.getDate("start_date"));
            wwa.setExpectedEndDate(rs.getDate("expected_end_date"));
            wwa.setActualEndDate(rs.getDate("actual_end_date"));
            wwa.setPriority(rs.getString("priority"));
            wwa.setStatus(rs.getString("status"));
            wwa.setCompletionPercentage(rs.getInt("completion_percentage"));
            wwa.setRemarks(rs.getString("remarks"));
            wwa.setCreatedAt(rs.getTimestamp("created_at"));
            wwa.setUpdatedAt(rs.getTimestamp("updated_at"));

            try {
                wwa.setWorkerName(rs.getString("worker_name"));
                wwa.setContractorName(rs.getString("contractor_name"));
                wwa.setProjectTitle(rs.getString("project_title"));
                wwa.setWorkTypeName(rs.getString("work_type_name"));
            } catch (Exception ignored) {}

            return wwa;
        }
    };

    private static final String BASE_SELECT_SQL = 
        "SELECT wwa.*, w.name AS worker_name, c.name AS contractor_name, p.title AS project_title, wt.name AS work_type_name " +
        "FROM worker_work_assignments wwa " +
        "JOIN users w ON wwa.worker_id = w.id " +
        "JOIN users c ON wwa.contractor_id = c.id " +
        "JOIN projects p ON wwa.project_id = p.id " +
        "JOIN work_types wt ON wwa.work_type_id = wt.id ";

    public List<WorkerWorkAssignment> findByContractorId(int contractorId) {
        String sql = BASE_SELECT_SQL + "WHERE wwa.contractor_id = ? ORDER BY wwa.created_at DESC";
        return jdbcTemplate.query(sql, assignmentRowMapper, contractorId);
    }

    public List<WorkerWorkAssignment> findByWorkerId(int workerId) {
        String sql = BASE_SELECT_SQL + "WHERE wwa.worker_id = ? ORDER BY wwa.created_at DESC";
        return jdbcTemplate.query(sql, assignmentRowMapper, workerId);
    }

    public WorkerWorkAssignment findById(int id) {
        try {
            String sql = BASE_SELECT_SQL + "WHERE wwa.id = ?";
            return jdbcTemplate.queryForObject(sql, assignmentRowMapper, id);
        } catch (Exception e) {
            return null;
        }
    }

    public int save(WorkerWorkAssignment wwa) {
        String sql = "INSERT INTO worker_work_assignments " +
            "(worker_id, contractor_id, project_id, work_type_id, task_title, task_description, start_date, expected_end_date, priority, status, completion_percentage, remarks) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        String priority = (wwa.getPriority() != null) ? wwa.getPriority() : "MEDIUM";
        String status = (wwa.getStatus() != null) ? wwa.getStatus() : "ASSIGNED";
        
        return jdbcTemplate.update(sql, 
            wwa.getWorkerId(), wwa.getContractorId(), wwa.getProjectId(), wwa.getWorkTypeId(),
            wwa.getTaskTitle(), wwa.getTaskDescription(), wwa.getStartDate(), wwa.getExpectedEndDate(),
            priority, status, wwa.getCompletionPercentage(), wwa.getRemarks());
    }

    public int updateStatusAndProgress(int id, String status, int completionPercentage, String remarks) {
        String finalStatus = status;
        if (completionPercentage >= 100 || "COMPLETED".equalsIgnoreCase(status)) {
            finalStatus = "COMPLETED";
            String sql = "UPDATE worker_work_assignments SET status = ?, completion_percentage = ?, remarks = ?, actual_end_date = CURRENT_DATE, updated_at = CURRENT_TIMESTAMP WHERE id = ?";
            return jdbcTemplate.update(sql, finalStatus, completionPercentage, remarks, id);
        } else {
            if (finalStatus == null || finalStatus.trim().isEmpty()) {
                finalStatus = "IN_PROGRESS";
            }
            String sql = "UPDATE worker_work_assignments SET status = ?, completion_percentage = ?, remarks = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?";
            return jdbcTemplate.update(sql, finalStatus, completionPercentage, remarks, id);
        }
    }

    public int countByContractorId(int contractorId) {
        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM worker_work_assignments WHERE contractor_id = ?", Integer.class, contractorId);
        return count != null ? count : 0;
    }

    public int countCompletedByContractorId(int contractorId) {
        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM worker_work_assignments WHERE contractor_id = ? AND (UPPER(status) IN ('COMPLETED', 'SUBMITTED') OR completion_percentage >= 100)", Integer.class, contractorId);
        return count != null ? count : 0;
    }

    public int countOngoingByContractorId(int contractorId) {
        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM worker_work_assignments WHERE contractor_id = ? AND UPPER(status) NOT IN ('COMPLETED', 'SUBMITTED') AND completion_percentage < 100", Integer.class, contractorId);
        return count != null ? count : 0;
    }
}
