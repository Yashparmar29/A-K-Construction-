package com.akconstruction.controller;

import com.akconstruction.model.ContractorWorker;
import com.akconstruction.model.Project;
import com.akconstruction.model.User;
import com.akconstruction.model.WorkType;
import com.akconstruction.model.WorkerWorkAssignment;
import com.akconstruction.repository.ProjectRepository;
import com.akconstruction.repository.UserRepository;
import com.akconstruction.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.sql.Date;
import java.time.LocalDate;
import java.util.*;

@Controller
public class ContractorController {

    @Autowired
    private EmployeeService employeeService;

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private UserRepository userRepository;

    private User getContractorSessionUser(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return null;
        String role = user.getRole();
        if ("CONTRACTOR".equalsIgnoreCase(role) || "ADMIN".equalsIgnoreCase(role)) {
            return user;
        }
        return null;
    }

    @GetMapping("/employee/contractor/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User contractor = getContractorSessionUser(session);
        if (contractor == null) {
            return "redirect:/login";
        }

        int contractorId = contractor.getId();

        // 1. Worker List & Counts
        List<ContractorWorker> workers = employeeService.getWorkersForContractor(contractorId);
        int totalWorkers = workers.size();
        int activeWorkers = totalWorkers;

        // 2. Work Assignments
        List<WorkerWorkAssignment> assignments = employeeService.getAssignmentsByContractor(contractorId);
        int totalTasks = assignments.size();
        int completedTasks = employeeService.getCompletedAssignmentsCount(contractorId);
        int ongoingTasks = employeeService.getOngoingAssignmentsCount(contractorId);

        // 3. Database Projects
        List<Project> projects = projectRepository.findAll();
        int assignedProjects = projects.size();

        // 4. Work Types
        List<WorkType> workTypes = employeeService.getAllWorkTypes();
        int totalWorkTypes = workTypes.size();

        // Metrics & Stats for Dashboard
        model.addAttribute("contractor", contractor);
        model.addAttribute("totalWorkers", totalWorkers);
        model.addAttribute("activeWorkers", activeWorkers);
        model.addAttribute("todaysAttendance", activeWorkers > 0 ? (activeWorkers - 1) + " / " + activeWorkers : "0 / 0");
        model.addAttribute("assignedProjectsCount", assignedProjects);
        model.addAttribute("pendingMaterialRequests", 2);
        model.addAttribute("pendingWorkReports", 3);
        model.addAttribute("completedTasks", completedTasks);
        model.addAttribute("ongoingTasks", ongoingTasks);
        model.addAttribute("totalWorkTypes", totalWorkTypes);
        model.addAttribute("projects", projects);
        model.addAttribute("workers", workers);
        model.addAttribute("assignments", assignments);
        model.addAttribute("workTypes", workTypes);

        return "employee/contractor/dashboard";
    }

    @GetMapping("/employee/contractor/workers")
    public String workerManagement(HttpSession session, Model model) {
        User contractor = getContractorSessionUser(session);
        if (contractor == null) return "redirect:/login";

        List<ContractorWorker> assignedWorkers = employeeService.getWorkersForContractor(contractor.getId());
        List<User> allWorkerUsers = userRepository.findByRole("WORKER");

        model.addAttribute("contractor", contractor);
        model.addAttribute("assignedWorkers", assignedWorkers);
        model.addAttribute("allWorkerUsers", allWorkerUsers);

        return "employee/contractor/workers";
    }

    @PostMapping("/employee/contractor/workers/assign")
    public String assignWorkerToContractor(
            @RequestParam int workerId,
            HttpSession session) {
        User contractor = getContractorSessionUser(session);
        if (contractor == null) return "redirect:/login";

        employeeService.assignWorkerToContractor(contractor.getId(), workerId);
        return "redirect:/employee/contractor/workers";
    }

    @GetMapping("/employee/contractor/assign-work")
    public String assignWorkForm(HttpSession session, Model model) {
        User contractor = getContractorSessionUser(session);
        if (contractor == null) return "redirect:/login";

        List<ContractorWorker> workers = employeeService.getWorkersForContractor(contractor.getId());
        List<Project> projects = projectRepository.findAll();
        List<WorkType> workTypes = employeeService.getActiveWorkTypes();

        model.addAttribute("contractor", contractor);
        model.addAttribute("workers", workers);
        model.addAttribute("projects", projects);
        model.addAttribute("workTypes", workTypes);

        return "employee/contractor/assign_work";
    }

    @PostMapping("/employee/contractor/assign-work")
    public String submitWorkAssignment(
            @RequestParam int workerId,
            @RequestParam int projectId,
            @RequestParam int workTypeId,
            @RequestParam String taskTitle,
            @RequestParam String taskDescription,
            @RequestParam String startDate,
            @RequestParam String expectedEndDate,
            @RequestParam(defaultValue = "MEDIUM") String priority,
            HttpSession session,
            Model model) {

        User contractor = getContractorSessionUser(session);
        if (contractor == null) return "redirect:/login";

        try {
            WorkerWorkAssignment wwa = new WorkerWorkAssignment();
            wwa.setContractorId(contractor.getId());
            wwa.setWorkerId(workerId);
            wwa.setProjectId(projectId);
            wwa.setWorkTypeId(workTypeId);
            wwa.setTaskTitle(taskTitle);
            wwa.setTaskDescription(taskDescription);
            wwa.setStartDate(Date.valueOf(startDate));
            wwa.setExpectedEndDate(Date.valueOf(expectedEndDate));
            wwa.setPriority(priority);
            wwa.setStatus("ASSIGNED");
            wwa.setCompletionPercentage(0);

            employeeService.assignWork(wwa);
            return "redirect:/employee/contractor/dashboard";
        } catch (Exception e) {
            model.addAttribute("error", "Error creating work assignment: " + e.getMessage());
            return assignWorkForm(session, model);
        }
    }

    @GetMapping("/employee/contractor/work-types")
    public String workTypesManagement(HttpSession session, Model model) {
        User contractor = getContractorSessionUser(session);
        if (contractor == null) return "redirect:/login";

        List<WorkType> workTypes = employeeService.getAllWorkTypes();
        model.addAttribute("contractor", contractor);
        model.addAttribute("workTypes", workTypes);

        return "employee/contractor/work_types";
    }

    @PostMapping("/employee/contractor/work-types/add")
    public String addWorkType(
            @RequestParam String name,
            @RequestParam String description,
            @RequestParam String category,
            HttpSession session) {

        User contractor = getContractorSessionUser(session);
        if (contractor == null) return "redirect:/login";

        WorkType wt = new WorkType(name, description, category);
        employeeService.createWorkType(wt);
        return "redirect:/employee/contractor/work-types";
    }
}
