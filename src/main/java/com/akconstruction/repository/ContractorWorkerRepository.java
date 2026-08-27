package com.akconstruction.repository;

import com.akconstruction.model.ContractorWorker;
import com.akconstruction.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ContractorWorkerRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<ContractorWorker> contractorWorkerRowMapper = new RowMapper<ContractorWorker>() {
        @Override
        public ContractorWorker mapRow(ResultSet rs, int rowNum) throws SQLException {
            ContractorWorker cw = new ContractorWorker();
            cw.setId(rs.getInt("id"));
            cw.setContractorId(rs.getInt("contractor_id"));
            cw.setWorkerId(rs.getInt("worker_id"));
            cw.setAssignedDate(rs.getTimestamp("assigned_date"));
            cw.setStatus(rs.getString("status"));
            
            try {
                cw.setWorkerName(rs.getString("worker_name"));
                cw.setWorkerEmail(rs.getString("worker_email"));
                cw.setWorkerPhone(rs.getString("worker_phone"));
                cw.setWorkerCode(rs.getString("worker_code"));
                cw.setContractorName(rs.getString("contractor_name"));
            } catch (Exception ignored) {}

            return cw;
        }
    };

    public List<ContractorWorker> findByContractorId(int contractorId) {
        String sql = "SELECT cw.*, w.name AS worker_name, w.email AS worker_email, w.phone AS worker_phone, w.employee_code AS worker_code, c.name AS contractor_name " +
                     "FROM contractor_worker cw " +
                     "JOIN users w ON cw.worker_id = w.id " +
                     "JOIN users c ON cw.contractor_id = c.id " +
                     "WHERE cw.contractor_id = ? AND cw.status = 'ACTIVE' ORDER BY w.name ASC";
        return jdbcTemplate.query(sql, contractorWorkerRowMapper, contractorId);
    }

    public User findContractorForWorker(int workerId) {
        String sql = "SELECT c.* FROM users c JOIN contractor_worker cw ON c.id = cw.contractor_id WHERE cw.worker_id = ? AND cw.status = 'ACTIVE' LIMIT 1";
        try {
            return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setEmployeeCode(rs.getString("employee_code"));
                u.setRole(rs.getString("role"));
                return u;
            }, workerId);
        } catch (Exception e) {
            return null;
        }
    }

    public boolean isWorkerAssignedToContractor(int workerId, int contractorId) {
        String sql = "SELECT COUNT(*) FROM contractor_worker WHERE worker_id = ? AND contractor_id = ? AND status = 'ACTIVE'";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, workerId, contractorId);
        return count != null && count > 0;
    }

    public int assignWorkerToContractor(int contractorId, int workerId) {
        if (isWorkerAssignedToContractor(workerId, contractorId)) {
            return 1;
        }
        String sql = "INSERT INTO contractor_worker (contractor_id, worker_id, status) VALUES (?, ?, 'ACTIVE')";
        return jdbcTemplate.update(sql, contractorId, workerId);
    }

    public int removeWorkerAssignment(int contractorId, int workerId) {
        String sql = "UPDATE contractor_worker SET status = 'INACTIVE' WHERE contractor_id = ? AND worker_id = ?";
        return jdbcTemplate.update(sql, contractorId, workerId);
    }

    public int countWorkersForContractor(int contractorId) {
        String sql = "SELECT COUNT(*) FROM contractor_worker WHERE contractor_id = ? AND status = 'ACTIVE'";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, contractorId);
        return count != null ? count : 0;
    }
}
