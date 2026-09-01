<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Worker Profile - A K Construction</title>
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

        .profile-avatar-circle {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            background: linear-gradient(135deg, #f59e0b, #d97706);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.2rem;
            color: #000;
            box-shadow: 0 0 25px rgba(245, 158, 11, 0.35);
            border: 3px solid rgba(255, 255, 255, 0.2);
        }
    </style>
</head>
<body class="app-wrapper">

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
                <a href="${pageContext.request.contextPath}/employee/worker/profile" class="nav-link-custom active">
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
                <h5 class="m-0 fw-bold text-white"><i class="fas fa-id-card text-warning me-2"></i>Worker Identity & Profile</h5>
            </div>
            <div class="text-end">
                <div class="fw-bold text-white small"><c:out value="${worker.name}" default="Worker"/></div>
                <div class="text-warning text-xs font-monospace"><c:out value="${worker.employeeCode}" default="WRK-301"/></div>
            </div>
        </header>

        <div class="p-3 p-md-4">
            <div class="row g-4 justify-content-center">
                <div class="col-lg-8">
                    <div class="glass-panel p-4">
                        <div class="d-flex align-items-center gap-4 mb-4 pb-4 border-bottom border-white border-opacity-10">
                            <div class="profile-avatar-circle">
                                <i class="fas fa-user-ninja"></i>
                            </div>
                            <div>
                                <h3 class="fw-extrabold text-white mb-1"><c:out value="${worker.name}"/></h3>
                                <div class="d-flex align-items-center gap-2">
                                    <span class="badge bg-warning text-dark fw-bold">SITE EXECUTION WORKER</span>
                                    <span class="badge bg-dark border border-secondary text-warning font-monospace">
                                        <c:out value="${worker.employeeCode}" default="WRK-301"/>
                                    </span>
                                    <span class="badge bg-success bg-opacity-20 text-success border border-success">
                                        <i class="fas fa-check-circle me-1"></i> ACTIVE
                                    </span>
                                </div>
                            </div>
                        </div>

                        <!-- Profile Info Grid -->
                        <div class="row g-3 text-white mb-3">
                            <div class="col-md-6">
                                <div class="p-3 rounded-3" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.08);">
                                    <label class="text-white-50 text-xs text-uppercase fw-bold d-block mb-1"><i class="fas fa-envelope text-warning me-1"></i> Email Address</label>
                                    <div class="fw-semibold fs-6"><c:out value="${worker.email}"/></div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="p-3 rounded-3" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.08);">
                                    <label class="text-white-50 text-xs text-uppercase fw-bold d-block mb-1"><i class="fas fa-phone text-warning me-1"></i> Phone Number</label>
                                    <div class="fw-semibold fs-6"><c:out value="${worker.phone}" default="+91 9797979797"/></div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="p-3 rounded-3" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.08);">
                                    <label class="text-white-50 text-xs text-uppercase fw-bold d-block mb-1"><i class="fas fa-user-shield text-warning me-1"></i> Assigned Contractor</label>
                                    <div class="fw-semibold fs-6 text-warning"><c:out value="${contractor.name}" default="Vikram Singh Contractor"/></div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="p-3 rounded-3" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.08);">
                                    <label class="text-white-50 text-xs text-uppercase fw-bold d-block mb-1"><i class="far fa-calendar-alt text-warning me-1"></i> Joining Date</label>
                                    <div class="fw-semibold fs-6"><c:out value="${worker.joiningDate}" default="2026-01-15"/></div>
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="p-3 rounded-3" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.08);">
                                    <label class="text-white-50 text-xs text-uppercase fw-bold d-block mb-1"><i class="fas fa-map-marker-alt text-warning me-1"></i> Residential Address</label>
                                    <div class="fw-semibold fs-6"><c:out value="${worker.address}" default="102 Construction Staff Quarters, Near SG Highway, Ahmedabad, Gujarat"/></div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="p-3 rounded-3" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.08);">
                                    <label class="text-white-50 text-xs text-uppercase fw-bold d-block mb-1"><i class="fas fa-tools text-warning me-1"></i> Specialization & Trades</label>
                                    <div class="d-flex flex-wrap gap-1 mt-1">
                                        <span class="badge bg-warning text-dark">Brick Masonry</span>
                                        <span class="badge bg-warning text-dark">Concrete Pouring</span>
                                        <span class="badge bg-warning text-dark">Structural Steel Binding</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="p-3 rounded-3" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.08);">
                                    <label class="text-white-50 text-xs text-uppercase fw-bold d-block mb-1"><i class="fas fa-medkit text-danger me-1"></i> Emergency Contact</label>
                                    <div class="fw-semibold fs-6 text-danger">+91 9876543210 (Kin / Family)</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('sidebarToggleBtn')?.addEventListener('click', function() {
            document.getElementById('appSidebar')?.classList.toggle('active');
        });
    </script>
</body>
</html>
