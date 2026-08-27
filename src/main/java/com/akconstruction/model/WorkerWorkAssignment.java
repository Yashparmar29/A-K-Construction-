package com.akconstruction.model;

import java.sql.Date;
import java.sql.Timestamp;

public class WorkerWorkAssignment {
    private int id;
    private int workerId;
    private int contractorId;
    private int projectId;
    private int workTypeId;
    private String taskTitle;
    private String taskDescription;
    private Date startDate;
    private Date expectedEndDate;
    private Date actualEndDate;
    private String priority;
    private String status;
    private int completionPercentage;
    private String remarks;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Joined Display Fields
    private String workerName;
    private String contractorName;
    private String projectTitle;
    private String workTypeName;

    public WorkerWorkAssignment() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getWorkerId() { return workerId; }
    public void setWorkerId(int workerId) { this.workerId = workerId; }

    public int getContractorId() { return contractorId; }
    public void setContractorId(int contractorId) { this.contractorId = contractorId; }

    public int getProjectId() { return projectId; }
    public void setProjectId(int projectId) { this.projectId = projectId; }

    public int getWorkTypeId() { return workTypeId; }
    public void setWorkTypeId(int workTypeId) { this.workTypeId = workTypeId; }

    public String getTaskTitle() { return taskTitle; }
    public void setTaskTitle(String taskTitle) { this.taskTitle = taskTitle; }

    public String getTaskDescription() { return taskDescription; }
    public void setTaskDescription(String taskDescription) { this.taskDescription = taskDescription; }

    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }

    public Date getExpectedEndDate() { return expectedEndDate; }
    public void setExpectedEndDate(Date expectedEndDate) { this.expectedEndDate = expectedEndDate; }

    public Date getActualEndDate() { return actualEndDate; }
    public void setActualEndDate(Date actualEndDate) { this.actualEndDate = actualEndDate; }

    public String getPriority() { return priority; }
    public void setPriority(String priority) { this.priority = priority; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getCompletionPercentage() { return completionPercentage; }
    public void setCompletionPercentage(int completionPercentage) { this.completionPercentage = completionPercentage; }

    public String getRemarks() { return remarks; }
    public void setRemarks(String remarks) { this.remarks = remarks; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }

    public String getWorkerName() { return workerName; }
    public void setWorkerName(String workerName) { this.workerName = workerName; }

    public String getContractorName() { return contractorName; }
    public void setContractorName(String contractorName) { this.contractorName = contractorName; }

    public String getProjectTitle() { return projectTitle; }
    public void setProjectTitle(String projectTitle) { this.projectTitle = projectTitle; }

    public String getWorkTypeName() { return workTypeName; }
    public void setWorkTypeName(String workTypeName) { this.workTypeName = workTypeName; }
}
