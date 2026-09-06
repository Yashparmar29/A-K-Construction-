<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Dashboard - A K Construction</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    
    <!-- Custom Employee Dashboard CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/employee-dashboard.css">
</head>
<body>

<div class="app-wrapper">

    <!-- Sidebar Overlay for Mobile -->
    <div class="sidebar-overlay" id="sidebarOverlay"></div>

    <!-- AdminLTE Style Sidebar -->
    <aside class="app-sidebar" id="appSidebar">
        <!-- Sidebar Brand Header -->
        <div class="sidebar-brand">
            <div class="brand-logo"><i class="fas fa-hard-hat"></i></div>
            <div class="brand-text">A K <span>CONSTRUCTION</span></div>
        </div>

        <!-- User Profile Info -->
        <div class="sidebar-user">
            <div class="user-avatar">
                <i class="fas fa-user-tie"></i>
            </div>
            <div class="user-info">
                <div class="user-name"><c:out value="${employeeName}" default="Rajesh Kumar"/></div>
                <div class="user-role"><i class="fas fa-shield-alt me-1"></i><c:out value="${employeeRole}" default="Senior Site Engineer"/></div>
            </div>
        </div>

        <!-- Sidebar Navigation -->
        <ul class="sidebar-nav">
            <li class="nav-header">MAIN MENU</li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/employee/dashboard" class="nav-link-custom active">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="#projectsSection" class="nav-link-custom">
                    <i class="fas fa-building"></i>
                    <span>Assigned Projects</span>
                    <span class="nav-badge bg-primary ms-auto"><c:out value="${totalAssignedProjects}" default="4"/></span>
                </a>
            </li>
            <li class="nav-item">
                <a href="#tasksSection" class="nav-link-custom">
                    <i class="fas fa-tasks"></i>
                    <span>Today's Tasks</span>
                    <span class="nav-badge bg-warning text-dark ms-auto"><c:out value="${pendingTasksCount}" default="3"/> Pending</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="#siteVisitsSection" class="nav-link-custom">
                    <i class="fas fa-map-marked-alt"></i>
                    <span>Site Visits</span>
                </a>
            </li>

            <li class="nav-header">REPORTS & TIMELINES</li>
            <li class="nav-item">
                <a href="#attendanceSection" class="nav-link-custom">
                    <i class="fas fa-user-clock"></i>
                    <span>Attendance Log</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="#projectsSection" class="nav-link-custom">
                    <i class="fas fa-building"></i>
                    <span>Site Operations</span>
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

    <!-- Main Content Container -->
    <main class="app-main">
        <!-- Top Navbar -->
        <header class="app-header">
            <div class="d-flex align-items-center gap-3">
                <button class="toggle-sidebar-btn" id="sidebarToggleBtn">
                    <i class="fas fa-bars"></i>
                </button>
                <h5 class="m-0 fw-bold d-none d-md-block text-slate-800">
                    Employee Control Center
                </h5>
            </div>

            <div class="header-right">
                <!-- Live Clock Widget -->
                <div class="header-clock">
                    <i class="fas fa-clock"></i>
                    <span id="liveClock">--:--:-- PM</span>
                </div>

                <!-- Notifications Bell Dropdown -->
                <div class="dropdown">
                    <button class="btn btn-light position-relative rounded-circle p-2" type="button" data-bs-toggle="dropdown">
                        <i class="fas fa-bell text-secondary"></i>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                            2
                        </span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0 p-2" style="width: 320px;">
                        <li class="dropdown-header fw-bold text-dark border-bottom pb-2 mb-1">
                            Notifications (2 Unread)
                        </li>
                        <c:forEach var="notif" items="${notifications}">
                            <li>
                                <a class="dropdown-item p-2 rounded mb-1 border-bottom" href="#">
                                    <div class="d-flex align-items-start gap-2">
                                        <i class="fas ${notif.icon} text-${notif.type} mt-1"></i>
                                        <div>
                                            <div class="fw-semibold text-dark fs-7">${notif.title}</div>
                                            <div class="text-muted small text-truncate" style="max-width: 230px;">${notif.message}</div>
                                            <div class="text-xs text-muted mt-1">${notif.time}</div>
                                        </div>
                                    </div>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </header>

        <!-- Main Body Content -->
        <div class="p-3 p-md-4">
            
            <!-- Toast Notification Container -->
            <div id="toastContainer" class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 1080;"></div>

            <!-- Welcome Employee Card Banner -->
            <div class="welcome-banner">
                <div class="row align-items-center">
                    <div class="col-lg-8 mb-3 mb-lg-0">
                        <div class="greeting-title">
                            Welcome back, <c:out value="${employeeName}" default="Rajesh Kumar"/>!
                        </div>
                        <div class="greeting-subtitle">
                            <i class="far fa-calendar-alt me-1"></i> <c:out value="${currentDate}" default="Thursday, August 13, 2026"/> &nbsp;|&nbsp;
                            <i class="fas fa-briefcase me-1"></i> Shift: <c:out value="${shiftHours}" default="08:30 AM - 05:30 PM"/>
                        </div>
                        <div class="d-flex flex-wrap gap-2">
                            <button id="attendancePunchBtn" class="btn btn-outline-warning btn-sm quick-action-btn">
                                <i class="fas fa-sign-out-alt me-1"></i> Punch Out
                            </button>
                            <a href="#tasksSection" class="btn btn-warning text-dark btn-sm quick-action-btn">
                                <i class="fas fa-plus-circle me-1"></i> View Today's Tasks
                            </a>
                            <a href="#projectsSection" class="btn btn-outline-light btn-sm quick-action-btn">
                                <i class="fas fa-building me-1"></i> View Assigned Projects
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-4 text-lg-end">
                        <div class="bg-white bg-opacity-10 rounded-3 p-3 d-inline-block text-start border border-white border-opacity-10">
                            <div class="text-xs text-uppercase tracking-wider text-warning fw-bold mb-1">Emp ID: <c:out value="${employeeId}" default="EMP-2026-402"/></div>
                            <div class="fw-semibold text-white mb-1"><c:out value="${department}" default="Civil Construction & Supervision"/></div>
                            <span class="badge bg-success" id="attendanceStatusBadge">
                                <i class="fas fa-check-circle me-1"></i> On Duty
                            </span>
                            <span class="small text-white-50 ms-1" id="attendanceStatusText">
                                <c:out value="${attendanceStatus}" default="Checked In (08:30 AM)"/>
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- AdminLTE Small Box Metrics Row -->
            <div class="row">
                <!-- Total Assigned Projects -->
                <div class="col-lg-3 col-6">
                    <div class="small-box bg-gradient-primary-custom">
                        <div class="inner">
                            <h3><c:out value="${totalAssignedProjects}" default="4"/></h3>
                            <p>Assigned Projects</p>
                        </div>
                        <i class="fas fa-building icon-bg"></i>
                        <a href="#projectsSection" class="small-box-footer">
                            View Active Sites <i class="fas fa-arrow-circle-right ms-1"></i>
                        </a>
                    </div>
                </div>

                <!-- Today's Tasks -->
                <div class="col-lg-3 col-6">
                    <div class="small-box bg-gradient-warning-custom">
                        <div class="inner">
                            <h3><c:out value="${todaysTasksCount}" default="8"/></h3>
                            <p>Today's Total Tasks</p>
                        </div>
                        <i class="fas fa-clipboard-list icon-bg"></i>
                        <a href="#tasksSection" class="small-box-footer">
                            Check Daily Agenda <i class="fas fa-arrow-circle-right ms-1"></i>
                        </a>
                    </div>
                </div>

                <!-- Completed Tasks -->
                <div class="col-lg-3 col-6">
                    <div class="small-box bg-gradient-success-custom">
                        <div class="inner">
                            <h3 id="completedTasksCounter"><c:out value="${completedTasksCount}" default="5"/></h3>
                            <p>Completed Tasks</p>
                        </div>
                        <i class="fas fa-check-circle icon-bg"></i>
                        <a href="#tasksSection" class="small-box-footer">
                            View Finished Work <i class="fas fa-arrow-circle-right ms-1"></i>
                        </a>
                    </div>
                </div>

                <!-- Pending Tasks -->
                <div class="col-lg-3 col-6">
                    <div class="small-box bg-gradient-danger-custom">
                        <div class="inner">
                            <h3 id="pendingTasksCounter"><c:out value="${pendingTasksCount}" default="3"/></h3>
                            <p>Pending Tasks</p>
                        </div>
                        <i class="fas fa-hourglass-half icon-bg"></i>
                        <a href="#tasksSection" class="small-box-footer">
                            High Priority First <i class="fas fa-arrow-circle-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Charts Section (3 Chart.js Visualizations) -->
            <div class="row">
                <!-- Chart 1: Weekly Attendance -->
                <div class="col-lg-6 mb-4">
                    <div class="card-admin h-100">
                        <div class="card-header">
                            <h6 class="card-title">
                                <i class="fas fa-user-clock"></i> Weekly Attendance & Hours Logged
                            </h6>
                            <span class="badge bg-light text-dark border">Target: 40 hrs/wk</span>
                        </div>
                        <div class="card-body">
                            <div class="chart-container" style="height: 270px;">
                                <canvas id="weeklyAttendanceChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Chart 2: Task Completion Status -->
                <div class="col-lg-6 mb-4">
                    <div class="card-admin h-100">
                        <div class="card-header">
                            <h6 class="card-title">
                                <i class="fas fa-chart-pie"></i> Task Status Distribution
                            </h6>
                            <span class="badge bg-light text-dark border">Real-time Sync</span>
                        </div>
                        <div class="card-body">
                            <div class="chart-container" style="height: 270px;">
                                <canvas id="taskCompletionChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Chart 3: Project Progress Breakdown -->
                <div class="col-12 mb-4" id="projectsSection">
                    <div class="card-admin">
                        <div class="card-header">
                            <h6 class="card-title">
                                <i class="fas fa-tasks"></i> Assigned Projects Progress Overview
                            </h6>
                            <button class="btn btn-sm btn-outline-secondary rounded-pill">
                                <i class="fas fa-download me-1"></i> Export Status
                            </button>
                        </div>
                        <div class="card-body">
                            <div class="row align-items-center">
                                <div class="col-lg-7 mb-3 mb-lg-0">
                                    <div class="chart-container" style="height: 240px;">
                                        <canvas id="projectProgressChart"></canvas>
                                    </div>
                                </div>
                                <div class="col-lg-5">
                                    <div class="table-responsive">
                                        <table class="table table-custom border rounded">
                                            <thead>
                                                <tr>
                                                    <th>Project Name</th>
                                                    <th>Stage</th>
                                                    <th>Progress</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="proj" items="${projects}">
                                                    <tr>
                                                        <td class="fw-bold">${proj.name}</td>
                                                        <td><span class="badge bg-secondary">${proj.status}</span></td>
                                                        <td>
                                                            <div class="d-flex align-items-center gap-2">
                                                                <div class="progress flex-grow-1" style="height: 8px;">
                                                                    <div class="progress-bar bg-warning" role="progressbar" style="width: ${proj.progress}%;"></div>
                                                                </div>
                                                                <span class="small fw-semibold">${proj.progress}%</span>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Content Row 2: Today's Tasks Checklist & Site Visits -->
            <div class="row">
                <!-- Today's Tasks Interactive Checklist -->
                <div class="col-lg-7 mb-4" id="tasksSection">
                    <div class="card-admin h-100">
                        <div class="card-header">
                            <h6 class="card-title">
                                <i class="fas fa-tasks"></i> Today's Task Checklist & Inspections
                            </h6>
                            <div class="d-flex align-items-center gap-2">
                                <div class="progress" style="width: 100px; height: 10px;">
                                    <div class="progress-bar bg-success" id="taskProgressBarFill" role="progressbar" style="width: 62.5%;"></div>
                                </div>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="task-list-wrapper">
                                <c:forEach var="t" items="${todaysTasks}">
                                    <div class="task-item ${t.status == 'Completed' ? 'completed' : ''}">
                                        <input type="checkbox" class="task-checkbox" ${t.status == 'Completed' ? 'checked' : ''}>
                                        <div class="task-details">
                                            <div class="task-title"><c:out value="${t.title}"/></div>
                                            <div class="task-meta">
                                                <i class="fas fa-building me-1"></i><c:out value="${t.project}"/> &nbsp;|&nbsp; 
                                                <i class="far fa-clock me-1"></i><c:out value="${t.time}"/>
                                            </div>
                                        </div>
                                        <div>
                                            <span class="badge ${t.priority == 'Critical' ? 'bg-danger' : t.priority == 'High' ? 'bg-warning text-dark' : 'bg-info'} ms-2">
                                                <c:out value="${t.priority}"/>
                                            </span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Upcoming Site Visits Card -->
                <div class="col-lg-5 mb-4" id="siteVisitsSection">
                    <div class="card-admin h-100">
                        <div class="card-header">
                            <h6 class="card-title">
                                <i class="fas fa-map-marked-alt"></i> Upcoming Site Visits & Inspections
                            </h6>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-custom">
                                    <thead>
                                        <tr>
                                            <th>Site & Purpose</th>
                                            <th>Time</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="v" items="${siteVisits}">
                                            <tr>
                                                <td>
                                                    <div class="fw-bold text-dark"><c:out value="${v.site}"/></div>
                                                    <div class="small text-muted"><c:out value="${v.purpose}"/></div>
                                                    <div class="text-xs text-secondary mt-1"><i class="fas fa-user me-1"></i><c:out value="${v.supervisor}"/></div>
                                                </td>
                                                <td class="small fw-semibold"><c:out value="${v.time}"/></td>
                                                <td><span class="badge ${v.badgeClass}"><c:out value="${v.status}"/></span></td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Notifications Stream Section -->
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card-admin">
                        <div class="card-header">
                            <h6 class="card-title">
                                <i class="fas fa-bell"></i> Live Notifications & Site Alerts
                            </h6>
                            <div class="btn-group btn-group-sm" role="group">
                                <button type="button" class="btn btn-outline-secondary notification-filter-btn active" data-filter="all">All</button>
                                <button type="button" class="btn btn-outline-secondary notification-filter-btn" data-filter="danger">Safety</button>
                                <button type="button" class="btn btn-outline-secondary notification-filter-btn" data-filter="warning">Tasks</button>
                                <button type="button" class="btn btn-outline-secondary notification-filter-btn" data-filter="success">Material</button>
                            </div>
                        </div>
                        <div class="card-body p-0">
                            <div class="notifications-list">
                                <c:forEach var="n" items="${notifications}">
                                    <div class="notification-item ${n.unread ? 'unread' : ''}" data-category="${n.type}">
                                        <div class="notification-icon bg-${n.type} bg-opacity-10 text-${n.type}">
                                            <i class="fas ${n.icon}"></i>
                                        </div>
                                        <div class="notification-content">
                                            <div class="notification-title text-${n.type}">${n.title}</div>
                                            <div class="notification-desc">${n.message}</div>
                                            <div class="notification-time"><i class="far fa-clock me-1"></i>${n.time}</div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!-- Footer -->
        <footer class="bg-white border-top py-3 px-4 text-muted small d-flex justify-content-between align-items-center mt-auto">
            <div>
                <strong>A K Construction Management System</strong> &copy; 2026. All rights reserved.
            </div>
            <div>
                AdminLTE 3 Styled Employee Portal v1.0
            </div>
        </footer>
    </main>
</div>

<!-- Bootstrap 5 Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- Chart.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- Custom Employee Dashboard JS -->
<script src="${pageContext.request.contextPath}/js/employee-dashboard.js"></script>
</body>
</html>
