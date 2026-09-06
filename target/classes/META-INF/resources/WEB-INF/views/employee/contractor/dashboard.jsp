<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contractor Dashboard - A K Construction</title>
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
            --accent-gold: #f59e0b;
            --accent-emerald: #10b981;
            --accent-blue: #3b82f6;
            --accent-purple: #8b5cf6;
            --accent-cyan: #06b6d4;
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
            <span class="badge bg-warning text-dark ms-2 fw-bold" style="font-size: 0.7rem;">CONTRACTOR</span>
        </div>

        <ul class="sidebar-nav">
            <li class="nav-header">CONTRACTOR PORTAL</li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/employee/contractor/dashboard" class="nav-link-custom active">
                    <i class="fas fa-th-large"></i>
                    <span>Contractor Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/employee/contractor/workers" class="nav-link-custom">
                    <i class="fas fa-users"></i>
                    <span>Manage Workers (${totalWorkers})</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/employee/contractor/assign-work" class="nav-link-custom">
                    <i class="fas fa-plus-circle"></i>
                    <span>Assign New Work</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/employee/contractor/work-types" class="nav-link-custom">
                    <i class="fas fa-tools"></i>
                    <span>Work Types</span>
                </a>
            </li>

            <li class="nav-header">SITE SUPERVISION & LOGS</li>
            <li class="nav-item">
                <a href="#" class="nav-link-custom" data-bs-toggle="modal" data-bs-target="#attendanceLogModal">
                    <i class="fas fa-user-check text-success"></i>
                    <span>Worker Attendance Log</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link-custom" data-bs-toggle="modal" data-bs-target="#siteReportModal">
                    <i class="fas fa-file-contract text-warning"></i>
                    <span>Daily Site Reports</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="#" class="nav-link-custom" data-bs-toggle="modal" data-bs-target="#materialRequestModal">
                    <i class="fas fa-truck-loading text-info"></i>
                    <span>Material Requests (${pendingMaterialRequests})</span>
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
                <h5 class="m-0 fw-bold text-white"><i class="fas fa-user-ninja text-warning me-2"></i>Contractor Supervision Dashboard</h5>
            </div>
            
            <div class="d-flex align-items-center gap-3">
                <!-- Live Digital Clock Widget -->
                <div class="d-none d-md-flex align-items-center gap-2 px-3 py-1.5 rounded-pill" style="background: rgba(255,255,255,0.06); border: 1px solid rgba(255,255,255,0.1);">
                    <i class="far fa-clock text-warning"></i>
                    <span id="liveClock" class="fw-bold text-white small" style="font-family: monospace;">--:--:-- --</span>
                </div>
                
                <div class="text-end border-start border-secondary border-opacity-25 ps-3">
                    <div class="fw-bold text-white small"><c:out value="${contractor.name}" default="Contractor"/></div>
                    <div class="text-warning text-xs font-monospace"><c:out value="${contractor.employeeCode}" default="CON-201"/></div>
                </div>
            </div>
        </header>

        <!-- Body Content -->
        <div class="p-3 p-md-4">

            <!-- Hero Welcome & Real-Time Punch Counter Split -->
            <div class="row g-4 mb-4">
                <!-- Hero Banner -->
                <div class="col-lg-7">
                    <div class="hero-banner-v2 h-100 d-flex flex-column justify-content-between">
                        <div>
                            <div class="d-flex align-items-center gap-2 mb-2">
                                <span id="contractorStatusBadge" class="badge status-pill-active rounded-pill">
                                    <span class="pulse-dot me-1.5"></span> ON SITE SUPERVISION
                                </span>
                            </div>
                            <h2 class="fw-extrabold text-white mb-2">
                                Welcome back, <c:out value="${contractor.name}" default="Contractor"/>! 👋
                            </h2>
                            <div class="text-white-50 small mb-3">
                                <span><i class="fas fa-users text-warning me-1"></i> Active Workers: <strong class="text-white">${totalWorkers} Assigned</strong></span> &nbsp;|&nbsp;
                                <span><i class="fas fa-building text-warning me-1"></i> Active Projects: <strong class="text-white">${assignedProjectsCount} Sites</strong></span>
                            </div>
                        </div>

                        <div class="d-flex flex-wrap gap-2 pt-2">
                            <a href="${pageContext.request.contextPath}/employee/contractor/assign-work" class="btn btn-gold-action btn-sm">
                                <i class="fas fa-plus-circle me-1"></i> Assign Work
                            </a>
                            <button type="button" class="btn btn-outline-glass btn-sm" data-bs-toggle="modal" data-bs-target="#attendanceLogModal">
                                <i class="fas fa-user-check text-success me-1"></i> Attendance Log (${todaysAttendance})
                            </button>
                            <button type="button" class="btn btn-outline-glass btn-sm" data-bs-toggle="modal" data-bs-target="#siteReportModal">
                                <i class="fas fa-file-contract text-warning me-1"></i> Site Report
                            </button>
                            <button type="button" class="btn btn-outline-glass btn-sm" data-bs-toggle="modal" data-bs-target="#materialRequestModal">
                                <i class="fas fa-truck-loading text-info me-1"></i> Material Request
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Real-Time Site Supervision Counter Widget -->
                <div class="col-lg-5">
                    <div class="punch-widget-card p-4 h-100 text-center d-flex flex-column justify-content-between">
                        <div>
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="text-white-50 text-xs text-uppercase fw-bold"><i class="fas fa-shield-alt text-warning me-1"></i> Site Supervision Counter</span>
                                <span class="badge bg-warning text-dark font-monospace fw-bold px-2.5 py-1">CONTRACTOR LOG</span>
                            </div>

                            <!-- Big Live Counter -->
                            <div class="my-3 py-2 rounded-3" style="background: rgba(0,0,0,0.4); border: 1px solid rgba(255,255,255,0.1);">
                                <div class="text-white-50 text-xs text-uppercase mb-1">Active Site Inspection Duration</div>
                                <h1 id="liveContractorTimer" class="fw-black text-warning m-0" style="font-family: monospace; font-size: 2.4rem; letter-spacing: 2px;">
                                    00h 00m 00s
                                </h1>
                                <small id="contractorPunchMsg" class="text-success text-xs fw-semibold mt-1 d-block">Supervision active on site</small>
                            </div>
                        </div>

                        <div>
                            <button id="contractorPunchBtn" type="button" class="btn btn-success btn-lg w-100 fw-bold rounded-3 shadow">
                                <i class="fas fa-fingerprint me-2"></i> PUNCH IN (Start Site Duty)
                            </button>
                            <div class="d-flex justify-content-between text-xs text-white-50 mt-2 px-1">
                                <span>Total Logged Today: <strong id="liveContractorTotalHours" class="text-white">7.0 hrs</strong></span>
                                <span>Attendance: <strong class="text-warning">${todaysAttendance}</strong></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Stats Metrics Grid -->
            <div class="row g-3 mb-4">
                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="metric-card-v2">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <span class="text-white-50 text-uppercase text-xs fw-bold tracking-wider">Total Managed Workers</span>
                                <h2 class="fw-black text-white mt-2 mb-0">${totalWorkers}</h2>
                                <div class="text-xs text-success mt-2"><i class="fas fa-check-circle me-1"></i> ${activeWorkers} Active On Site</div>
                            </div>
                            <div class="metric-icon-box metric-icon-gold">
                                <i class="fas fa-users"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="metric-card-v2">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <span class="text-white-50 text-uppercase text-xs fw-bold tracking-wider">Ongoing Tasks</span>
                                <h2 class="fw-black text-warning mt-2 mb-0">${ongoingTasks}</h2>
                                <div class="text-xs text-info mt-2"><i class="fas fa-spinner fa-spin me-1"></i> Tasks Under Execution</div>
                            </div>
                            <div class="metric-icon-box metric-icon-purple">
                                <i class="fas fa-tasks"></i>
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
                                <div class="text-xs text-success mt-2"><i class="fas fa-check-double me-1"></i> Verified & Delivered</div>
                            </div>
                            <div class="metric-icon-box metric-icon-emerald">
                                <i class="fas fa-award"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="metric-card-v2">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <span class="text-white-50 text-uppercase text-xs fw-bold tracking-wider">Active Projects</span>
                                <h2 class="fw-black text-blue mt-2 mb-0">${assignedProjectsCount}</h2>
                                <div class="text-xs text-blue mt-2"><i class="fas fa-building me-1"></i> Active Construction Sites</div>
                            </div>
                            <div class="metric-icon-box metric-icon-blue">
                                <i class="fas fa-city"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Charts Row -->
            <div class="row g-4 mb-4">
                <!-- Chart 1: Contractor Operations & Task Progress -->
                <div class="col-lg-8">
                    <div class="glass-panel p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div>
                                <h6 class="fw-bold text-white m-0"><i class="fas fa-chart-bar text-warning me-2"></i> Site Operations & Task Execution Rate</h6>
                                <small class="text-white-50">Weekly progress velocity across assigned construction projects</small>
                            </div>
                            <span class="badge bg-warning text-dark px-3 py-1.5 fw-bold">Live Overview</span>
                        </div>
                        <div style="height: 280px; position: relative;">
                            <canvas id="contractorOpsChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Chart 2: Worker Allocation Doughnut -->
                <div class="col-lg-4">
                    <div class="glass-panel p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h6 class="fw-bold text-white m-0"><i class="fas fa-chart-pie text-warning me-2"></i> Worker Deployment</h6>
                            <span class="badge bg-secondary bg-opacity-50 text-white-50">Active Ratio</span>
                        </div>
                        <div style="height: 220px; position: relative;" class="d-flex justify-content-center align-items-center">
                            <canvas id="workerDeploymentDonutChart"></canvas>
                        </div>
                        <div class="d-flex justify-content-around text-center mt-3 pt-2 border-top border-secondary border-opacity-25 text-xs">
                            <div>
                                <span class="d-inline-block rounded-circle bg-success me-1" style="width: 8px; height: 8px;"></span>
                                <span class="text-white-50">Deployed:</span> <strong class="text-white">${activeWorkers}</strong>
                            </div>
                            <div>
                                <span class="d-inline-block rounded-circle bg-warning me-1" style="width: 8px; height: 8px;"></span>
                                <span class="text-white-50">Unassigned:</span> <strong class="text-white">0</strong>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Content Split: Assigned Workers Table & Active Work Assignments -->
            <div class="row g-4 mb-4">
                <!-- Assigned Workers Table -->
                <div class="col-lg-6">
                    <div class="glass-panel p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom border-white border-opacity-10">
                            <h6 class="fw-bold text-white m-0"><i class="fas fa-users text-warning me-2"></i> Assigned Site Workers (${workers.size()})</h6>
                            <a href="${pageContext.request.contextPath}/employee/contractor/workers" class="btn btn-xs btn-outline-warning">Manage Workers</a>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-dark table-hover align-middle mb-0" style="background: transparent;">
                                <thead>
                                    <tr class="text-white-50 small text-uppercase">
                                        <th>Worker</th>
                                        <th>Code</th>
                                        <th>Phone</th>
                                        <th class="text-end">Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="w" items="${workers}">
                                        <tr>
                                            <td class="fw-bold text-white">${w.workerName}</td>
                                            <td><span class="badge bg-dark border border-secondary text-warning font-monospace">${w.workerCode}</span></td>
                                            <td class="text-white-50 small">${w.workerPhone}</td>
                                            <td class="text-end">
                                                <span class="badge bg-success bg-opacity-20 text-success border border-success">ACTIVE</span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty workers}">
                                        <tr>
                                            <td colspan="4" class="text-center text-muted py-4">
                                                No workers assigned yet. <a href="${pageContext.request.contextPath}/employee/contractor/workers" class="text-warning fw-bold">Assign Workers Now</a>
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Active Work Assignments -->
                <div class="col-lg-6">
                    <div class="glass-panel p-4 h-100">
                        <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom border-white border-opacity-10">
                            <h6 class="fw-bold text-white m-0"><i class="fas fa-tasks text-warning me-2"></i> Active Work Assignments (${assignments.size()})</h6>
                            <a href="${pageContext.request.contextPath}/employee/contractor/assign-work" class="btn btn-xs btn-warning text-dark">+ Assign Work</a>
                        </div>

                        <c:forEach var="a" items="${assignments}">
                            <div class="p-3 rounded-3 mb-3" style="background: rgba(255, 255, 255, 0.03); border: 1px solid rgba(255, 255, 255, 0.08);">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <div>
                                        <div class="fw-bold text-white small">${a.taskTitle}</div>
                                        <div class="text-xs text-warning">
                                            <i class="fas fa-user-ninja me-1"></i> Worker: ${a.workerName} &nbsp;|&nbsp; 
                                            <i class="fas fa-building me-1"></i> ${a.projectTitle}
                                        </div>
                                    </div>
                                    <span class="badge ${a.priority == 'HIGH' ? 'bg-danger text-white' : 'bg-warning text-dark'} text-xs">
                                        ${a.priority}
                                    </span>
                                </div>
                                <div class="d-flex align-items-center gap-3 mt-2">
                                    <div class="progress flex-fill progress-dark" style="height: 8px;">
                                        <div class="progress-bar progress-bar-gold" role="progressbar" style="width: ${a.completionPercentage}%;"></div>
                                    </div>
                                    <span class="text-xs fw-bold text-warning">${a.completionPercentage}%</span>
                                </div>
                            </div>
                        </c:forEach>

                        <c:if test="${empty assignments}">
                            <div class="text-center text-muted py-5">
                                <i class="fas fa-clipboard-list fa-3x mb-3 text-warning opacity-50"></i>
                                <h6 class="text-white fw-bold">No work assignments issued yet</h6>
                                <p class="text-white-50 small">Click Assign Work to delegate tasks to site workers.</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

        </div>
    </main>

    <!-- Modal 1: Worker Attendance Log -->
    <div class="modal fade" id="attendanceLogModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content glass-panel text-white" style="background: #0f172a; border: 1px solid rgba(255,255,255,0.15);">
                <div class="modal-header border-bottom border-white border-opacity-10">
                    <h5 class="modal-title fw-bold text-success"><i class="fas fa-user-check me-2"></i>Worker Attendance Log & Shift Roster</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="table-responsive">
                        <table class="table table-dark table-hover align-middle mb-0">
                            <thead>
                                <tr class="text-white-50 text-uppercase text-xs">
                                    <th>Worker Name</th>
                                    <th>Worker Code</th>
                                    <th>Shift Check-In</th>
                                    <th>Status</th>
                                    <th class="text-end">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="w" items="${workers}">
                                    <tr>
                                        <td class="fw-bold text-white">${w.workerName}</td>
                                        <td><span class="badge bg-dark border border-secondary text-warning font-monospace">${w.workerCode}</span></td>
                                        <td class="text-white-50 small">08:30 AM (Today)</td>
                                        <td><span class="badge status-pill-active rounded-pill">PRESENT</span></td>
                                        <td class="text-end">
                                            <button class="btn btn-xs btn-outline-success" onclick="alert('Attendance confirmed for ${w.workerName}')">Mark Present</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty workers}">
                                    <tr>
                                        <td colspan="5" class="text-center text-muted py-4">No workers assigned to your contractor account yet.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="modal-footer border-top border-white border-opacity-10">
                    <button type="button" class="btn btn-outline-glass btn-sm" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal 2: Daily Site Report -->
    <div class="modal fade" id="siteReportModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content glass-panel text-white" style="background: #0f172a; border: 1px solid rgba(255,255,255,0.15);">
                <div class="modal-header border-bottom border-white border-opacity-10">
                    <h5 class="modal-title fw-bold text-warning"><i class="fas fa-file-contract me-2"></i>Submit Daily Site Execution Report</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form onsubmit="event.preventDefault(); alert('Daily Site Report submitted successfully!'); $('#siteReportModal').modal('hide');">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label text-white-50 small">Construction Site / Project</label>
                            <select class="form-select bg-dark text-white border-secondary" required>
                                <c:forEach var="p" items="${projects}">
                                    <option value="${p.id}">${p.title} (${p.category})</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-white-50 small">Weather & Site Condition</label>
                            <input type="text" class="form-control bg-dark text-white border-secondary" value="Clear & Dry - Full Execution Speed" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-white-50 small">Total Active Crew Count On-Site</label>
                            <input type="number" class="form-control bg-dark text-white border-secondary" value="${totalWorkers > 0 ? totalWorkers : 5}" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-white-50 small">Site Execution Summary / Remarks</label>
                            <textarea class="form-control bg-dark text-white border-secondary" rows="3" placeholder="Detail concrete volume poured, brickwork height achieved, or structural steel progress..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer border-top border-white border-opacity-10">
                        <button type="button" class="btn btn-outline-glass btn-sm" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-gold-action btn-sm">Submit Site Report</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal 3: Material Request -->
    <div class="modal fade" id="materialRequestModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content glass-panel text-white" style="background: #0f172a; border: 1px solid rgba(255,255,255,0.15);">
                <div class="modal-header border-bottom border-white border-opacity-10">
                    <h5 class="modal-title fw-bold text-info"><i class="fas fa-truck-loading me-2"></i>Request Construction Materials</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form onsubmit="event.preventDefault(); alert('Material request dispatched to Store Inventory Office!'); $('#materialRequestModal').modal('hide');">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label text-white-50 small">Material Type</label>
                            <select class="form-select bg-dark text-white border-secondary" required>
                                <option>Grade 53 OPC Cement (Bags)</option>
                                <option>Fe-550 TMT Steel Rebar (Tons)</option>
                                <option>Coarse Aggregate Sand (Brass)</option>
                                <option>Red Clay Bricks (Units)</option>
                                <option>Structural Concrete Mix (Cu.m)</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-white-50 small">Quantity Required</label>
                            <input type="text" class="form-control bg-dark text-white border-secondary" placeholder="e.g. 150 Bags or 5 Tons" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-white-50 small">Target Delivery Date</label>
                            <input type="date" class="form-control bg-dark text-white border-secondary" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-white-50 small">Site Location / Notes</label>
                            <input type="text" class="form-control bg-dark text-white border-secondary" placeholder="e.g. GIFT City Tower A - Gate 3 Unloading Point">
                        </div>
                    </div>
                    <div class="modal-footer border-top border-white border-opacity-10">
                        <button type="button" class="btn btn-outline-glass btn-sm" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-info text-dark fw-bold btn-sm">Dispatch Request</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Contractor Shift Timer JS -->
    <script src="/js/contractor-shift.js"></script>

    <!-- Interactive Scripts & Chart Initialization -->
    <script>
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
            // Chart 1: Contractor Operations & Execution Speed
            const ctxOps = document.getElementById('contractorOpsChart');
            if (ctxOps) {
                new Chart(ctxOps, {
                    type: 'bar',
                    data: {
                        labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
                        datasets: [
                            {
                                label: 'Tasks Progressed',
                                data: [4, 6, 8, 5, 9, 7, 2],
                                backgroundColor: 'rgba(245, 158, 11, 0.7)',
                                borderColor: '#f59e0b',
                                borderWidth: 1,
                                borderRadius: 6
                            },
                            {
                                label: 'Supervision Hours',
                                data: [7.5, 8.0, 8.5, 7.0, 8.0, 7.5, 3.0],
                                type: 'line',
                                borderColor: '#3b82f6',
                                backgroundColor: 'rgba(59, 130, 246, 0.15)',
                                borderWidth: 3,
                                tension: 0.4,
                                fill: true
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
                            y: { ticks: { color: '#94a3b8' }, grid: { color: 'rgba(255, 255, 255, 0.05)' } }
                        }
                    }
                });
            }

            // Chart 2: Worker Deployment Donut
            const ctxDonut = document.getElementById('workerDeploymentDonutChart');
            if (ctxDonut) {
                const total = ${totalWorkers} || 1;
                const active = ${activeWorkers} || 1;

                new Chart(ctxDonut, {
                    type: 'doughnut',
                    data: {
                        labels: ['Active On Site', 'Available'],
                        datasets: [{
                            data: [active, 0],
                            backgroundColor: ['#10b981', '#f59e0b'],
                            borderColor: '#0b0f19',
                            borderWidth: 3
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
