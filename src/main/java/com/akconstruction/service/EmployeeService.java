package com.akconstruction.service;

import com.akconstruction.model.ContractorWorker;
import com.akconstruction.model.User;
import com.akconstruction.model.WorkType;
import com.akconstruction.model.WorkerWorkAssignment;
import com.akconstruction.repository.ContractorWorkerRepository;
import com.akconstruction.repository.UserRepository;
import com.akconstruction.repository.WorkTypeRepository;
import com.akconstruction.repository.WorkerWorkAssignmentRepository;
import com.akconstruction.model.EmployeeAttendance;
import com.akconstruction.repository.EmployeeAttendanceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private WorkTypeRepository workTypeRepository;

    @Autowired
    private ContractorWorkerRepository contractorWorkerRepository;

    @Autowired
    private WorkerWorkAssignmentRepository workerWorkAssignmentRepository;

    @Autowired
    private EmployeeAttendanceRepository employeeAttendanceRepository;

    // Attendance
    public List<EmployeeAttendance> getWorkerMonthlyAttendance(int workerId, int year, int month) {
        return employeeAttendanceRepository.findByWorkerIdAndMonth(workerId, year, month);
    }

    public int getDaysPresentCount(List<EmployeeAttendance> list) {
        if (list == null) return 0;
        int count = 0;
        for (EmployeeAttendance a : list) {
            if ("PRESENT".equalsIgnoreCase(a.getStatus()) || "HALF_DAY".equalsIgnoreCase(a.getStatus())) {
                count++;
            }
        }
        return count;
    }

    public double getTotalMonthlyHours(List<EmployeeAttendance> list) {
        if (list == null) return 0.0;
        double total = 0.0;
        for (EmployeeAttendance a : list) {
            total += a.getWorkingHours();
        }
        return total;
    }

    // Work Types
    public List<WorkType> getAllWorkTypes() {
        return workTypeRepository.findAll();
    }

    public List<WorkType> getActiveWorkTypes() {
        return workTypeRepository.findActive();
    }

    public int createWorkType(WorkType wt) {
        return workTypeRepository.save(wt);
    }

    // Contractor Workers
    public List<ContractorWorker> getWorkersForContractor(int contractorId) {
        return contractorWorkerRepository.findByContractorId(contractorId);
    }

    public List<User> getContractorWorkerUsers(int contractorId) {
        return userRepository.findWorkersByContractorId(contractorId);
    }

    public User getAssignedContractor(int workerId) {
        return contractorWorkerRepository.findContractorForWorker(workerId);
    }

    public boolean assignWorkerToContractor(int contractorId, int workerId) {
        return contractorWorkerRepository.assignWorkerToContractor(contractorId, workerId) > 0;
    }

    // Work Assignments
    public List<WorkerWorkAssignment> getAssignmentsByContractor(int contractorId) {
        return workerWorkAssignmentRepository.findByContractorId(contractorId);
    }

    public List<WorkerWorkAssignment> getAssignmentsByWorker(int workerId) {
        return workerWorkAssignmentRepository.findByWorkerId(workerId);
    }

    public int assignWork(WorkerWorkAssignment wwa) {
        return workerWorkAssignmentRepository.save(wwa);
    }

    public int updateAssignmentStatus(int assignmentId, String status, int completionPercentage, String remarks) {
        return workerWorkAssignmentRepository.updateStatusAndProgress(assignmentId, status, completionPercentage, remarks);
    }

    // Counts & Stats
    public int getWorkerCountForContractor(int contractorId) {
        return contractorWorkerRepository.countWorkersForContractor(contractorId);
    }

    public int getTotalAssignmentsCount(int contractorId) {
        return workerWorkAssignmentRepository.countByContractorId(contractorId);
    }

    public int getCompletedAssignmentsCount(int contractorId) {
        return workerWorkAssignmentRepository.countCompletedByContractorId(contractorId);
    }

    public int getOngoingAssignmentsCount(int contractorId) {
        return workerWorkAssignmentRepository.countOngoingByContractorId(contractorId);
    }
}
