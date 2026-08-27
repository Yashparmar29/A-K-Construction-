package com.akconstruction.model;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class EmployeeAttendance {
    private int id;
    private int employeeId;
    private Integer contractorId;
    private Date date;
    private Time checkIn;
    private Time checkOut;
    private double workingHours;
    private String status;
    private String remarks;
    private Double latitude;
    private Double longitude;
    private Timestamp createdAt;
    private String siteName;

    public EmployeeAttendance() {}

    public EmployeeAttendance(int employeeId, Date date, Time checkIn, Time checkOut, double workingHours, String status, String remarks, String siteName) {
        this.employeeId = employeeId;
        this.date = date;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.workingHours = workingHours;
        this.status = status;
        this.remarks = remarks;
        this.siteName = siteName;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getEmployeeId() { return employeeId; }
    public void setEmployeeId(int employeeId) { this.employeeId = employeeId; }

    public Integer getContractorId() { return contractorId; }
    public void setContractorId(Integer contractorId) { this.contractorId = contractorId; }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }

    public Time getCheckIn() { return checkIn; }
    public void setCheckIn(Time checkIn) { this.checkIn = checkIn; }

    public Time getCheckOut() { return checkOut; }
    public void setCheckOut(Time checkOut) { this.checkOut = checkOut; }

    public double getWorkingHours() { return workingHours; }
    public void setWorkingHours(double workingHours) { this.workingHours = workingHours; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getRemarks() { return remarks; }
    public void setRemarks(String remarks) { this.remarks = remarks; }

    public Double getLatitude() { return latitude; }
    public void setLatitude(Double latitude) { this.latitude = latitude; }

    public Double getLongitude() { return longitude; }
    public void setLongitude(Double longitude) { this.longitude = longitude; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getSiteName() { return siteName; }
    public void setSiteName(String siteName) { this.siteName = siteName; }
}
