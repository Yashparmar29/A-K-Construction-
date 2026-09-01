<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Worker Dashboard - A K Construction</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <!-- Chart.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="stylesheet" href="/css/employee-dashboard.css">
    <style>
        :root {
            --bg-dark-app: #0b0f19;
            --card-glass-bg: rgba(21, 29, 46, 0.75);
            --card-glass-border: rgba(255, 255, 255, 0.08);
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --accent-gold: #f59e0b;
            --accent-emerald: #10b981;
            --accent-blue: #3b82f6;
            --accent-purple: #8b5cf6;
            --accent-rose: #f43f5e;
        }

        body.app-wrapper {
            background-color: var(--bg-dark-app) !important;
            color: var(--text-primary);
            font-family: 'Inter', sans-serif;
        }

        .app-main {
            background: radial-gradient(circle at 50% 0%, #151d30 0%, #0b0f19 70%) !important;
            min-height: 100vh;
        }

        .glass-panel {
            background: var(--card-glass-bg);
            backdrop-filter: blur(16px);
            -webkit-backdrop-filter: blur(16px);
            border: 1px solid var(--card-glass-border);
            border-radius: 16px;
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .glass-panel:hover {
            border-color: rgba(245, 158, 11, 0.3);
            box-shadow: 0 12px 40px 0 rgba(245, 158, 11, 0.15);
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

        .metric-card-v2 {
            padding: 1.5rem;
            border-radius: 16px;
            background: var(--card-glass-bg);
            border: 1px solid var(--card-glass-border);
            transition: transform 0.3s ease, box-shadow 0.3s ease, border-color 0.3s ease;
        }

        .metric-card-v2:hover {
            transform: translateY(-5px);
            border-color: var(--accent-gold);
            box-shadow: 0 10px 25px -5px rgba(245, 158, 11, 0.2);
        }

        .metric-icon-box {
            width: 52px;
            height: 52px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .metric-icon-gold { background: rgba(245, 158, 11, 0.15); color: #f59e0b; border: 1px solid rgba(245, 158, 11, 0.4); }
        .metric-icon-emerald { background: rgba(16, 185, 129, 0.15); color: #10b981; border: 1px solid rgba(16, 185, 129, 0.4); }
        .metric-icon-blue { background: rgba(59, 130, 246, 0.15); color: #3b82f6; border: 1px solid rgba(59, 130, 246, 0.4); }
        .metric-icon-purple { background: rgba(139, 92, 246, 0.15); color: #8b5cf6; border: 1px solid rgba(139, 92, 246, 0.4); }

        .hero-banner-v2 {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 60%, #1e1b4b 100%);
            border-radius: 20px;
            padding: 2rem;
            border: 1px solid rgba(245, 158, 11, 0.2);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
        }

        .pulse-dot {
            width: 10px;
            height: 10px;
            background-color: #10b981;
            border-radius: 50%;
            display: inline-block;
            box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.7);
            animation: pulse-green 2s infinite;
        }

        @keyframes pulse-green {
            0% { transform: scale(0.95); box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.7); }
            70% { transform: scale(1); box-shadow: 0 0 0 8px rgba(16, 185, 129, 0); }
            100% { transform: scale(0.95); box-shadow: 0 0 0 0 rgba(16, 185, 129, 0); }
        }

        .btn-gold-action {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            color: #000;
            font-weight: 700;
            border: none;
            border-radius: 10px;
            padding: 0.6rem 1.25rem;
            transition: all 0.25s ease;
        }

        .btn-gold-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(245, 158, 11, 0.4);
            color: #000;
        }

        .btn-outline-glass {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #fff;
            border-radius: 10px;
            padding: 0.6rem 1.25rem;
            font-weight: 600;
        }

        .btn-outline-glass:hover {
            background: rgba(255, 255, 255, 0.15);
            color: #fff;
            transform: translateY(-2px);
        }

        .progress-dark { background-color: rgba(255, 255, 255, 0.1); border-radius: 10px; }
        .progress-bar-gold { background: linear-gradient(90deg, #f59e0b, #fbbf24); border-radius: 10px; }

        .punch-widget-card {
            background: linear-gradient(135deg, rgba(30, 41, 59, 0.9), rgba(15, 23, 42, 0.95));
            border: 2px solid rgba(245, 158, 11, 0.3);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
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
                <a href="${pageContext.request.contextPath}/employee/worker/dashboard" class="nav-link-custom active">
                    <i class="fas fa-th-large"></i>
                    <span>Worker Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/employee/worker/assignments" class="nav-link-custom">
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

            <li class="nav-header">DAILY LOGS & REQUESTS</li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/employee/worker/attendance" class="nav-link-custom">
                    <i class="fas fa-fingerprint"></i>
                    <span>Shift Punch In/Out</span>
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
        <!-- Top App Navbar -->
        <header class="app-header-dark d-flex align-items-center justify-content-between">
            <div class="d-flex align-items-center gap-3">
                <button class="toggle-sidebar-btn text-white-50" id="sidebarToggleBtn"><i class="fas fa-bars fa-lg"></i></button>
                <h5 class="m-0 fw-bold text-white"><i class="fas fa-tachometer-alt text-warning me-2"></i>Site Worker Dashboard</h5>
            </div>
            
            <div class="d-flex align-items-center gap-3">
                <!-- Live Digital Clock Widget -->
                <div class="d-none d-md-flex align-items-center gap-2 px-3 py-1.5 rounded-pill" style="background: rgba(255,255,255,0.06); border: 1px solid rgba(255,255,255,0.1);">
                    <i class="far fa-clock text-warning"></i>
                    <span id="liveClock" class="fw-bold text-white small" style="font-family: monospace;">--:--:-- --</span>
                </div>
                
                <div class="text-end border-start border-secondary border-opacity-25 ps-3">
                    <div class="fw-bold text-white small"><c:out value="${worker.name}" default="Worker"/></div>
                    <div class="text-warning text-xs font-monospace"><c:out value="${worker.employeeCode}" default="WRK-301"/></div>
                </div>
            </div>
        </header>

        <!-- Body Content -->
        <div class="p-3 p-md-4">

            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show mb-4 shadow" role="alert" style="background: rgba(16, 185, 129, 0.2); border: 1px solid #10b981; color: #10b981; border-radius: 12px;">
                    <i class="fas fa-check-circle me-2"></i> <c:out value="${successMessage}"/>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- Real-time Punch In / Punch Out Card & Hero Split -->
            <div class="row g-4 mb-4">
                <!-- Hero Banner -->
                <div class="col-lg-7">
                    <div class="hero-banner-v2 h-100 d-flex flex-column justify-content-between">
                        <div>
                            <div class="d-flex align-items-center gap-2 mb-2">
                                <span id="shiftStatusBadge" class="badge status-pill-active rounded-pill">
                                    <span class="pulse-dot me-1.5"></span> ON DUTY - Active Shift
                                </span>
                            </div>
                            <h2 class="fw-extrabold text-white mb-2">
                                Welcome back, <c:out value="${worker.name}" default="Worker"/>! 👋
                            </h2>
                            <div class="text-white-50 small mb-3">
                                <span><i class="fas fa-user-ninja text-warning me-1"></i> Contractor: <strong class="text-white"><c:out value="${contractor.name}" default="Vikram Singh Contractor"/></strong></span> &nbsp;|&nbsp;
                                <span><i class="fas fa-phone text-warning me-1"></i> <c:out value="${contractor.phone}" default="+91 9898989898"/></span>
                            </div>
                        </div>

                        <div class="d-flex flex-wrap gap-2 pt-2">
                            <a href="${pageContext.request.contextPath}/employee/worker/assignments" class="btn btn-gold-action btn-sm">
                                <i class="fas fa-clipboard-list me-1"></i> View My Tasks (${totalTasks})
                            </a>
                            <button type="button" class="btn btn-outline-glass btn-sm" data-bs-toggle="modal" data-bs-target="#quickReportModal">
                                <i class="fas fa-pen-nib me-1"></i> Submit Work Log
                            </button>
                            <a href="${pageContext.request.contextPath}/employee/worker/profile" class="btn btn-outline-glass btn-sm">
                                <i class="fas fa-user-circle me-1"></i> My Profile
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Real-Time Punch In / Out Widget -->
                <div class="col-lg-5">
                    <div class="punch-widget-card p-4 h-100 text-center d-flex flex-column justify-content-between">
                        <div>
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="text-white-50 text-xs text-uppercase fw-bold"><i class="fas fa-stopwatch text-warning me-1"></i> Real-Time Shift Counter</span>
                                <span class="badge bg-warning text-dark font-monospace fw-bold px-2.5 py-1">LIVE TIMER</span>
                            </div>

                            <!-- Big Live Work Timer Display -->
                            <div class="my-3 py-2 rounded-3" style="background: rgba(0,0,0,0.4); border: 1px solid rgba(255,255,255,0.1);">
                                <div class="text-white-50 text-xs text-uppercase mb-1">Current Active Shift Elapsed</div>
                                <h1 id="liveShiftTimer" class="fw-black text-warning m-0" style="font-family: monospace; font-size: 2.4rem; letter-spacing: 2px;">
                                    00h 00m 00s
                                </h1>
                                <small id="punchTimeMessage" class="text-success text-xs fw-semibold mt-1 d-block">Click Punch In to start tracking</small>
                            </div>
                        </div>

                        <div>
                            <!-- Action Punch Button -->
                            <button id="punchToggleBtn" type="button" class="btn btn-success btn-lg w-100 fw-bold rounded-3 shadow">
                                <i class="fas fa-fingerprint me-2"></i> PUNCH IN (Start Shift)
                            </button>
                            <div class="d-flex justify-content-between text-xs text-white-50 mt-2 px-1">
                                <span>Total Today: <strong id="liveTotalHoursWorked" class="text-white">8.0 hrs</strong></span>
                                <span>Site: <strong class="text-warning">GIFT City Site A</strong></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stats Grid -->
            <div class="row g-3 mb-4">
                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="metric-card-v2">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <span class="text-white-50 text-uppercase text-xs fw-bold tracking-wider">Total Tasks</span>
                                <h2 class="fw-black text-white mt-2 mb-0">${totalTasks}</h2>
                                <div class="text-xs text-warning mt-2"><i class="fas fa-layer-group me-1"></i> Construction Backlog</div>
                            </div>
                            <div class="metric-icon-box metric-icon-gold">
                                <i class="fas fa-tasks"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="metric-card-v2">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <span class="text-white-50 text-uppercase text-xs fw-bold tracking-wider">Pending / In-Progress</span>
                                <h2 class="fw-black text-warning mt-2 mb-0">${pendingTasks}</h2>
                                <div class="text-xs text-info mt-2"><i class="fas fa-spinner fa-spin me-1"></i> Active Assignments</div>
                            </div>
                            <div class="metric-icon-box metric-icon-purple">
                                <i class="fas fa-tools"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="metric-card-v2">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <span class="text-white-50 text-uppercase text-xs fw-bold tracking-wider">Completed Tasks</span>
                                <h2 class="fw-black text-success mt-2 mb-0">${completedTasks}</h2>
                                <div class="text-xs text-success mt-2"><i class="fas fa-check-circle me-1"></i> Verified Finished</div>
                            </div>
                            <div class="metric-icon-box metric-icon-emerald">
                                <i class="fas fa-check-double"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="metric-card-v2">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <span class="text-white-50 text-uppercase text-xs fw-bold tracking-wider">Weekly Hours</span>
                                <h2 class="fw-black text-blue mt-2 mb-0">${weeklyHours} <span class="fs-6 font-normal">hrs</span></h2>
                                <div class="text-xs text-blue mt-2"><i class="fas fa-stopwatch me-1"></i> Logged This Week</div>
                            </div>
                            <div class="metric-icon-box metric-icon-blue">
                                <i class="fas fa-history"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Charts Row -->
            <div class="row g-4 mb-4">
                <!-- Chart 1: Weekly Work Performance -->
                <div class="col-lg-8">
                    <div class="glass-panel p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div>
                                <h6 class="fw-bold text-white m-0"><i class="fas fa-chart-line text-warning me-2"></i> Weekly Work Performance & Hours Logged</h6>
                                <small class="text-white-50">Daily hours worked vs completed tasks across the current week</small>
                            </div>
                            <span class="badge bg-warning text-dark px-3 py-1.5 fw-bold">Live Data</span>
                        </div>
                        <div style="height: 280px; position: relative;">
                            <canvas id="weeklyWorkChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Chart 2: Task Breakdown Donut -->
                <div class="col-lg-4">
                    <div class="glass-panel p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h6 class="fw-bold text-white m-0"><i class="fas fa-chart-pie text-warning me-2"></i> Task Status Ratio</h6>
                            <span class="badge bg-secondary bg-opacity-50 text-white-50">Summary</span>
                        </div>
                        <div style="height: 220px; position: relative;" class="d-flex justify-content-center align-items-center">
                            <canvas id="taskStatusDonutChart"></canvas>
                        </div>
                        <div class="d-flex justify-content-around text-center mt-3 pt-2 border-top border-secondary border-opacity-25 text-xs">
                            <div>
                                <span class="d-inline-block rounded-circle bg-warning me-1" style="width: 8px; height: 8px;"></span>
                                <span class="text-white-50">Pending:</span> <strong class="text-white">${pendingTasks}</strong>
                            </div>
                            <div>
                                <span class="d-inline-block rounded-circle bg-success me-1" style="width: 8px; height: 8px;"></span>
                                <span class="text-white-50">Completed:</span> <strong class="text-white">${completedTasks}</strong>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Current Tasks & Activity Stream Split -->
            <div class="row g-4 mb-4">
                <!-- My Current Construction Tasks -->
                <div class="col-lg-8">
                    <div class="glass-panel p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom border-white border-opacity-10">
                            <h6 class="fw-bold text-white m-0"><i class="fas fa-hammer text-warning me-2"></i> Assigned Construction Tasks (${totalTasks})</h6>
                            <a href="${pageContext.request.contextPath}/employee/worker/assignments" class="btn btn-xs btn-outline-warning">View All Tasks</a>
                        </div>

                        <c:forEach var="a" items="${assignments}">
                            <div class="p-3.5 rounded-3 mb-3" style="background: rgba(255, 255, 255, 0.03); border: 1px solid rgba(255, 255, 255, 0.08);">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <div>
                                        <div class="fw-bold text-white fs-6 mb-1">${a.taskTitle}</div>
                                        <div class="text-xs text-warning d-flex align-items-center gap-2">
                                            <span><i class="fas fa-building me-1"></i> ${a.projectTitle}</span>
                                            <span>•</span>
                                            <span><i class="fas fa-tools me-1"></i> ${a.workTypeName}</span>
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
                                        <span class="badge ${a.priority == 'HIGH' ? 'bg-danger text-white' : 'bg-warning text-dark'} px-2.5 py-1 fw-bold">
                                            <i class="fas fa-exclamation-triangle me-1"></i> ${a.priority}
                                        </span>
                                    </div>
                                </div>

                                <p class="text-white-50 small mb-3">${a.taskDescription}</p>

                                <div class="d-flex justify-content-between align-items-center text-xs text-white-50 mb-2">
                                    <span><i class="far fa-calendar-alt text-warning me-1"></i> Start: <strong class="text-white">${a.startDate}</strong></span>
                                    <span><i class="far fa-calendar-check text-success me-1"></i> Expected: <strong class="text-white">${a.expectedEndDate}</strong></span>
                                </div>

                                <div class="d-flex align-items-center gap-3 mb-2">
                                    <div class="progress flex-fill progress-dark" style="height: 10px;">
                                        <div class="progress-bar ${a.status == 'COMPLETED' || a.completionPercentage >= 100 ? 'bg-success' : 'progress-bar-gold'}" role="progressbar" style="width: ${a.completionPercentage}%;"></div>
                                    </div>
                                    <span class="text-xs fw-extrabold ${a.status == 'COMPLETED' || a.completionPercentage >= 100 ? 'text-success' : 'text-warning'} min-w-50 text-end">${a.completionPercentage}% Done</span>
                                </div>

                                <div class="text-end pt-1">
                                    <button type="button" class="btn btn-xs btn-outline-warning" onclick="openTaskReportModal('${a.id}', '${a.completionPercentage}', '${a.status}')" data-bs-toggle="modal" data-bs-target="#quickReportModal">
                                        <i class="fas fa-edit me-1"></i> Submit Log / Update Status
                                    </button>
                                </div>
                            </div>
                        </c:forEach>

                        <c:if test="${empty assignments}">
                            <div class="text-center text-muted py-5">
                                <i class="fas fa-hard-hat fa-3x mb-3 text-warning opacity-50"></i>
                                <h6 class="text-white fw-bold">No active tasks assigned yet</h6>
                                <p class="text-white-50 small">Your assigned contractor will update your task sheet shortly.</p>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Recent Activity Timeline & Safety Tip -->
                <div class="col-lg-4">
                    <div class="glass-panel p-4 h-100">
                        <h6 class="fw-bold text-white mb-3 pb-2 border-bottom border-white border-opacity-10">
                            <i class="fas fa-stream text-warning me-2"></i> Recent Activity & Shift Logs
                        </h6>

                        <div class="activity-timeline mt-3">
                            <div class="activity-item">
                                <div class="activity-icon-badge bg-success text-dark"><i class="fas fa-fingerprint"></i></div>
                                <div class="fw-bold text-white small">Shift Punch Recorded</div>
                                <div class="text-xs text-white-50">Logged via Site Counter</div>
                                <div class="text-xs text-warning mt-1">Today</div>
                            </div>

                            <div class="activity-item">
                                <div class="activity-icon-badge bg-warning text-dark"><i class="fas fa-tools"></i></div>
                                <div class="fw-bold text-white small">Task Progress Updated</div>
                                <div class="text-xs text-white-50">Masonry & Concrete Pouring progress updated</div>
                                <div class="text-xs text-white-50 mt-1">Yesterday, 04:45 PM</div>
                            </div>
                        </div>

                        <!-- Safety Tip Card -->
                        <div class="p-3 rounded-3 mt-4" style="background: rgba(245, 158, 11, 0.1); border: 1px solid rgba(245, 158, 11, 0.25);">
                            <div class="d-flex align-items-center gap-2 text-warning fw-bold small mb-1">
                                <i class="fas fa-shield-alt"></i> Daily Site Safety Tip
                            </div>
                            <p class="text-white-50 text-xs mb-0">
                                Always wear your hard hat, safety boots, and protective gloves while on the active construction site.
                            </p>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </main>

    <!-- Quick Report Modal -->
    <div class="modal fade" id="quickReportModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content glass-panel text-white" style="background: #0f172a; border: 1px solid rgba(255,255,255,0.15);">
                <div class="modal-header border-bottom border-white border-opacity-10">
                    <h5 class="modal-title fw-bold text-warning"><i class="fas fa-edit me-2"></i>Submit Daily Work Log & Report</h5>
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
                                <c:if test="${empty assignments}">
                                    <option value="0">No Active Tasks</option>
                                </c:if>
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
                            <label class="form-label text-white-50 small">Work Remarks / Daily Progress Report</label>
                            <textarea name="remarks" class="form-control bg-dark text-white border-secondary" rows="3" placeholder="Describe work completed today, materials consumed, site notes..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer border-top border-white border-opacity-10">
                        <button type="button" class="btn btn-outline-glass btn-sm" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-gold-action btn-sm"><i class="fas fa-paper-plane me-1"></i> Submit Report & Mark Status</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Shift Timer JS -->
    <script src="/js/worker-shift.js"></script>

    <!-- Interactive Scripts & Chart Initialization -->
    <script>
        function openTaskReportModal(id, completion, status) {
            const selectEl = document.getElementById('modalTaskSelect');
            if (selectEl) selectEl.value = id;
            const compEl = document.getElementById('modalCompletionInput');
            if (compEl) compEl.value = completion || 100;
            const statusEl = document.getElementById('modalStatusSelect');
            if (statusEl && status) statusEl.value = status;
        }

        function updateClock() {
            const now = new Date();
            const timeString = now.toLocaleTimeString('en-US', { hour12: true, hour: '2-digit', minute: '2-digit', second: '2-digit' });
            const clockEl = document.getElementById('liveClock');
            if (clockEl) clockEl.textContent = timeString;
        }
        setInterval(updateClock, 1000);
        updateClock();

        document.getElementById('sidebarToggleBtn')?.addEventListener('click', function() {
            document.getElementById('appSidebar')?.classList.toggle('active');
        });

        document.addEventListener('DOMContentLoaded', function() {
            const ctxWeekly = document.getElementById('weeklyWorkChart');
            if (ctxWeekly) {
                new Chart(ctxWeekly, {
                    type: 'bar',
                    data: {
                        labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                        datasets: [
                            {
                                label: 'Hours Worked',
                                data: [8.0, 8.5, 7.5, 8.0, 6.5, 8.0, 0.0],
                                backgroundColor: 'rgba(245, 158, 11, 0.65)',
                                borderColor: '#f59e0b',
                                borderWidth: 1,
                                borderRadius: 6,
                                yAxisID: 'y'
                            },
                            {
                                label: 'Progress (%)',
                                data: [20, 40, 55, 75, 85, 94, 94],
                                type: 'line',
                                borderColor: '#10b981',
                                backgroundColor: 'rgba(16, 185, 129, 0.15)',
                                borderWidth: 3,
                                pointBackgroundColor: '#10b981',
                                pointRadius: 4,
                                tension: 0.4,
                                fill: true,
                                yAxisID: 'y1'
                            }
                        ]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: { labels: { color: '#94a3b8', font: { family: 'Inter', size: 12 } } }
                        },
                        scales: {
                            x: { ticks: { color: '#94a3b8' }, grid: { color: 'rgba(255, 255, 255, 0.05)' } },
                            y: { type: 'linear', display: true, position: 'left', title: { display: true, text: 'Hours', color: '#f59e0b' }, ticks: { color: '#94a3b8' }, grid: { color: 'rgba(255, 255, 255, 0.05)' } },
                            y1: { type: 'linear', display: true, position: 'right', title: { display: true, text: 'Progress %', color: '#10b981' }, ticks: { color: '#94a3b8' }, grid: { drawOnChartArea: false } }
                        }
                    }
                });
            }

            const ctxDonut = document.getElementById('taskStatusDonutChart');
            if (ctxDonut) {
                const total = ${totalTasks} || 1;
                const completed = ${completedTasks} || 0;
                const pending = ${pendingTasks} || 1;

                new Chart(ctxDonut, {
                    type: 'doughnut',
                    data: {
                        labels: ['Pending / In Progress', 'Completed'],
                        datasets: [{
                            data: [pending, completed],
                            backgroundColor: ['#f59e0b', '#10b981'],
                            borderColor: '#0b0f19',
                            borderWidth: 3,
                            hoverOffset: 6
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: { legend: { display: false } },
                        cutout: '72%'
                    }
                });
            }
        });
    </script>
</body>
</html>
