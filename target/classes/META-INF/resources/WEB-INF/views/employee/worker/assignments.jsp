<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Work Assignments - A K Construction</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/employee-dashboard.css">
    <style>
        :root {
            --bg-dark-app: #0b0f19;
            --card-glass-bg: rgba(21, 29, 46, 0.75);
            --card-glass-border: rgba(255, 255, 255, 0.08);
            --accent-gold: #f59e0b;
        }

        body.app-wrapper {
            background-color: var(--bg-dark-app) !important;
            color: #f8fafc;
            font-family: 'Inter', sans-serif;
        }

        .app-main {
            background: radial-gradient(circle at 50% 0%, #151d30 0%, #0b0f19 70%) !important;
            min-height: 100vh;
        }

        .glass-panel {
            background: var(--card-glass-bg);
            backdrop-filter: blur(16px);
            border: 1px solid var(--card-glass-border);
            border-radius: 16px;
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
        }

        .app-header-dark {
            background: rgba(15, 23, 42, 0.85);
            backdrop-filter: blur(12px);
            border-bottom: 1px solid var(--card-glass-border);
            height: 64px;
            padding: 0 1.5rem;
            position: sticky;
            top: 0;
            z-index: 1030;
        }

        .task-card-v2 {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 14px;
            padding: 1.25rem;
            transition: all 0.3s ease;
        }

        .task-card-v2:hover {
            background: rgba(255, 255, 255, 0.06);
            border-color: rgba(245, 158, 11, 0.3);
            transform: translateY(-3px);
        }
    </style>
</head>
<body class="app-wrapper">

    <c:if test="${not empty sessionScope.adminOriginalUser}">
        <div class="alert alert-warning m-0 text-center py-2 fw-bold d-flex justify-content-between align-items-center px-4" style="background: linear-gradient(90deg, #f59e0b, #d97706); color: #000; border-radius: 0; border: none; font-size: 0.9rem; z-index: 1060; position: relative;">
            <div>
                <i class="fas fa-user-shield me-2"></i> <strong>ADMIN MASTER ACCESS ACTIVE:</strong> Currently logged in as <u class="fw-black">${sessionScope.user.name}</u> (${sessionScope.user.role})
            </div>
            <a href="${pageContext.request.contextPath}/admin/switch-back" class="btn btn-sm btn-dark font-monospace fw-bold text-warning rounded-pill px-3 shadow">
                <i class="fas fa-sign-out-alt me-1"></i> Return to Admin Dashboard
            </a>
        </div>
    </c:if>

    <!-- Sidebar Navigation -->
    <aside class="app-sidebar" id="appSidebar">
        <div class="sidebar-brand">
            <a href="/" class="brand-logo">
                <i class="fas fa-hammer"></i>
                <span class="brand-name">A K Construction</span>
            </a>
            <span class="badge bg-warning text-dark ms-2 fw-bold" style="font-size: 0.7rem;">WORKER</span>
        </div>

        <ul class="sidebar-nav">
            <li class="nav-header">WORKER PORTAL</li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/employee/worker/dashboard" class="nav-link-custom">
                    <i class="fas fa-th-large"></i>
                    <span>Worker Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/employee/worker/assignments" class="nav-link-custom active">
                    <i class="fas fa-clipboard-list"></i>
                    <span>Work Assignments</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/employee/worker/attendance" class="nav-link-custom">
                    <i class="fas fa-calendar-check"></i>
                    <span>Attendance Logs</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/employee/worker/profile" class="nav-link-custom">
                    <i class="fas fa-id-card"></i>
                    <span>My Profile</span>
                </a>
            </li>
            <li class="nav-header">ACCOUNT</li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/logout" class="nav-link-custom text-danger">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Sign Out</span>
                </a>
            </li>
        </ul>
    </aside>

    <main class="app-main">
        <header class="app-header-dark d-flex align-items-center justify-content-between">
            <div class="d-flex align-items-center gap-3">
                <button class="toggle-sidebar-btn text-white-50" id="sidebarToggleBtn"><i class="fas fa-bars fa-lg"></i></button>
                <h5 class="m-0 fw-bold text-white"><i class="fas fa-clipboard-list text-warning me-2"></i>My Construction Tasks & Assignments</h5>
            </div>
            <div class="text-end">
                <div class="fw-bold text-white small"><c:out value="${worker.name}" default="Worker"/></div>
                <div class="text-warning text-xs font-monospace"><c:out value="${worker.employeeCode}" default="WRK-301"/></div>
            </div>
        </header>

        <div class="p-3 p-md-4">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
                <div>
                    <h4 class="fw-extrabold text-white m-0">Construction Work Assignments</h4>
                    <p class="text-white-50 small m-0">Tasks assigned directly by your site contractor</p>
                </div>

                <!-- Search & Priority Filter -->
                <div class="d-flex gap-2">
                    <div class="input-group">
                        <span class="input-group-text bg-dark border-secondary text-white-50"><i class="fas fa-search"></i></span>
                        <input type="text" id="taskSearchInput" class="form-control bg-dark text-white border-secondary" placeholder="Search tasks..." onkeyup="filterTasks()">
                    </div>
                </div>
            </div>

            <!-- Task List Glass Card -->
            <div class="glass-panel p-4">
                <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom border-white border-opacity-10">
                    <h6 class="fw-bold text-white m-0"><i class="fas fa-tasks text-warning me-2"></i> Active Site Tasks Sheet</h6>
                    <span class="badge bg-warning text-dark fw-bold px-3 py-1.5">${assignments.size()} Total Assigned</span>
                </div>

                <div class="row g-3" id="tasksContainer">
                    <c:forEach var="a" items="${assignments}">
                        <div class="col-12 col-lg-6 task-card-item">
                            <div class="task-card-v2 h-100 d-flex flex-column justify-content-between">
                                <div>
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <div>
                                            <h6 class="fw-bold text-white m-0 task-title">${a.taskTitle}</h6>
                                            <div class="text-xs text-warning mt-1">
                                                <i class="fas fa-building me-1"></i> ${a.projectTitle} &nbsp;|&nbsp; 
                                                <i class="fas fa-tools me-1"></i> ${a.workTypeName}
                                            </div>
                                        </div>
                                        <div class="d-flex gap-1.5 align-items-center">
                                            <c:choose>
                                                <c:when test="${a.status == 'COMPLETED' || a.completionPercentage >= 100}">
                                                    <span class="badge bg-success text-white px-2.5 py-1 fw-bold">
                                                        <i class="fas fa-check-circle me-1"></i> COMPLETED
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-info text-dark px-2.5 py-1 fw-bold">
                                                        <i class="fas fa-spinner fa-spin me-1"></i> ${empty a.status ? 'IN_PROGRESS' : a.status}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                            <span class="badge ${a.priority == 'HIGH' ? 'bg-danger text-white' : 'bg-warning text-dark'} fw-bold px-2.5 py-1">
                                                ${a.priority}
                                            </span>
                                        </div>
                                    </div>

                                    <p class="text-white-50 small mb-3">${a.taskDescription}</p>
                                </div>

                                <div>
                                    <div class="d-flex justify-content-between align-items-center text-xs text-white-50 mb-2">
                                        <span><i class="far fa-calendar-alt text-warning me-1"></i> ${a.startDate}</span>
                                        <span><i class="far fa-calendar-check text-success me-1"></i> Target: ${a.expectedEndDate}</span>
                                    </div>

                                    <div class="d-flex align-items-center gap-3 mb-2">
                                        <div class="progress flex-fill bg-dark" style="height: 10px;">
                                            <div class="progress-bar ${a.status == 'COMPLETED' || a.completionPercentage >= 100 ? 'bg-success' : 'bg-warning'}" role="progressbar" style="width: ${a.completionPercentage}%;"></div>
                                        </div>
                                        <span class="text-xs fw-extrabold ${a.status == 'COMPLETED' || a.completionPercentage >= 100 ? 'text-success' : 'text-warning'} min-w-50 text-end">${a.completionPercentage}% Done</span>
                                    </div>

                                    <div class="text-end pt-1">
                                        <button type="button" class="btn btn-xs btn-outline-warning" onclick="openTaskReportModal('${a.id}', '${a.completionPercentage}', '${a.status}')" data-bs-toggle="modal" data-bs-target="#quickReportModal">
                                            <i class="fas fa-edit me-1"></i> Submit Log / Update Status
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <c:if test="${empty assignments}">
                        <div class="col-12 text-center text-muted py-5">
                            <i class="fas fa-tools fa-3x mb-3 text-warning opacity-50"></i>
                            <h6 class="text-white fw-bold">No active work assignments found</h6>
                            <p class="text-white-50 small">Check back later or consult your supervisor contractor for task updates.</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </main>

    <!-- Quick Report Modal -->
    <div class="modal fade" id="quickReportModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content glass-panel text-white" style="background: #0f172a; border: 1px solid rgba(255,255,255,0.15);">
                <div class="modal-header border-bottom border-white border-opacity-10">
                    <h5 class="modal-title fw-bold text-warning"><i class="fas fa-edit me-2"></i>Submit Work Log & Report</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form method="POST" action="${pageContext.request.contextPath}/employee/worker/submit-report">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label text-white-50 small">Select Assigned Task</label>
                            <select id="modalTaskSelect" name="assignmentId" class="form-select bg-dark text-white border-secondary" required>
                                <c:forEach var="a" items="${assignments}">
                                    <option value="${a.id}">${a.taskTitle} (${a.workTypeName})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="row">
                            <div class="col-6 mb-3">
                                <label class="form-label text-white-50 small">Completion (%)</label>
                                <input type="number" id="modalCompletionInput" name="completionPercentage" min="0" max="100" class="form-control bg-dark text-white border-secondary" placeholder="100" value="100" required>
                            </div>
                            <div class="col-6 mb-3">
                                <label class="form-label text-white-50 small">Task Status</label>
                                <select id="modalStatusSelect" name="status" class="form-select bg-dark text-white border-secondary">
                                    <option value="COMPLETED" selected>COMPLETED</option>
                                    <option value="IN_PROGRESS">IN_PROGRESS</option>
                                    <option value="SUBMITTED">SUBMITTED</option>
                                </select>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-white-50 small">Hours Logged Today</label>
                            <input type="number" step="0.5" name="hoursWorked" class="form-control bg-dark text-white border-secondary" placeholder="e.g. 8.0" value="8.0">
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-white-50 small">Work Remarks / Progress Report</label>
                            <textarea name="remarks" class="form-control bg-dark text-white border-secondary" rows="3" placeholder="Describe work completed today..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer border-top border-white border-opacity-10">
                        <button type="button" class="btn btn-outline-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-warning btn-sm fw-bold"><i class="fas fa-paper-plane me-1"></i> Submit Report</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function openTaskReportModal(id, completion, status) {
            const selectEl = document.getElementById('modalTaskSelect');
            if (selectEl) selectEl.value = id;
            const compEl = document.getElementById('modalCompletionInput');
            if (compEl) compEl.value = completion || 100;
            const statusEl = document.getElementById('modalStatusSelect');
            if (statusEl && status) statusEl.value = status;
        }

        document.getElementById('sidebarToggleBtn')?.addEventListener('click', function() {
            document.getElementById('appSidebar')?.classList.toggle('active');
        });

        function filterTasks() {
            const query = document.getElementById('taskSearchInput').value.toLowerCase();
            const cards = document.querySelectorAll('.task-card-item');
            cards.forEach(card => {
                const text = card.textContent.toLowerCase();
                card.style.display = text.includes(query) ? '' : 'none';
            });
        }
    </script>
</body>
</html>
