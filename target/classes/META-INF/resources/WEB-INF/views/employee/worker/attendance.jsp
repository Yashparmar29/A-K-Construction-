<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Monthly Attendance Logs - A K Construction</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
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

        .metric-card-v2 {
            padding: 1.5rem;
            border-radius: 16px;
            background: var(--card-glass-bg);
            border: 1px solid var(--card-glass-border);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
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

        .table-dark-custom {
            color: #f8fafc;
            border-color: rgba(255, 255, 255, 0.08);
        }
        .table-dark-custom th {
            background: rgba(15, 23, 42, 0.6);
            color: #94a3b8;
            font-weight: 600;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        .table-dark-custom td {
            background: transparent;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            vertical-align: middle;
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
                <a href="${pageContext.request.contextPath}/employee/worker/assignments" class="nav-link-custom">
                    <i class="fas fa-clipboard-list"></i>
                    <span>Work Assignments</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/employee/worker/attendance" class="nav-link-custom active">
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

    <!-- Main Content -->
    <main class="app-main">
        <header class="app-header-dark d-flex align-items-center justify-content-between">
            <div class="d-flex align-items-center gap-3">
                <button class="toggle-sidebar-btn text-white-50" id="sidebarToggleBtn"><i class="fas fa-bars fa-lg"></i></button>
                <h5 class="m-0 fw-bold text-white"><i class="fas fa-calendar-alt text-warning me-2"></i>Worker Attendance & Shift History</h5>
            </div>
            
            <div class="d-flex align-items-center gap-3">
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

        <div class="p-3 p-md-4">
            <!-- Filter Header & Title -->
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
                <div>
                    <h4 class="fw-extrabold text-white m-0">Monthly Attendance Logs</h4>
                    <p class="text-white-50 small m-0">Review total days attended, punch-in times, and working hours</p>
                </div>

                <!-- Month & Year Selector Form -->
                <form method="GET" action="${pageContext.request.contextPath}/employee/worker/attendance" class="d-flex gap-2">
                    <select name="month" class="form-select bg-dark text-white border-secondary form-select-sm" onchange="this.form.submit()">
                        <option value="1" ${selectedMonth == 1 ? 'selected' : ''}>January</option>
                        <option value="2" ${selectedMonth == 2 ? 'selected' : ''}>February</option>
                        <option value="3" ${selectedMonth == 3 ? 'selected' : ''}>March</option>
                        <option value="4" ${selectedMonth == 4 ? 'selected' : ''}>April</option>
                        <option value="5" ${selectedMonth == 5 ? 'selected' : ''}>May</option>
                        <option value="6" ${selectedMonth == 6 ? 'selected' : ''}>June</option>
                        <option value="7" ${selectedMonth == 7 ? 'selected' : ''}>July</option>
                        <option value="8" ${selectedMonth == 8 ? 'selected' : ''}>August</option>
                        <option value="9" ${selectedMonth == 9 ? 'selected' : ''}>September</option>
                        <option value="10" ${selectedMonth == 10 ? 'selected' : ''}>October</option>
                        <option value="11" ${selectedMonth == 11 ? 'selected' : ''}>November</option>
                        <option value="12" ${selectedMonth == 12 ? 'selected' : ''}>December</option>
                    </select>
                    <select name="year" class="form-select bg-dark text-white border-secondary form-select-sm" onchange="this.form.submit()">
                        <option value="2026" ${selectedYear == 2026 ? 'selected' : ''}>2026</option>
                        <option value="2025" ${selectedYear == 2025 ? 'selected' : ''}>2025</option>
                    </select>
                </form>
            </div>

            <!-- Stats Grid -->
            <div class="row g-3 mb-4">
                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="metric-card-v2">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <span class="text-white-50 text-uppercase text-xs fw-bold tracking-wider">Days Attended</span>
                                <h2 class="fw-black text-success mt-2 mb-0">${daysPresent} <span class="fs-6 font-normal text-white-50">/ ${totalDaysInLog} Days</span></h2>
                                <div class="text-xs text-success mt-2"><i class="fas fa-user-check me-1"></i> Attended This Month</div>
                            </div>
                            <div class="metric-icon-box metric-icon-emerald">
                                <i class="fas fa-calendar-check"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="metric-card-v2">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <span class="text-white-50 text-uppercase text-xs fw-bold tracking-wider">Attendance Rate</span>
                                <h2 class="fw-black text-warning mt-2 mb-0">${attendancePercentage}%</h2>
                                <div class="text-xs text-warning mt-2"><i class="fas fa-chart-line me-1"></i> Monthly Consistency</div>
                            </div>
                            <div class="metric-icon-box metric-icon-gold">
                                <i class="fas fa-percentage"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="metric-card-v2">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <span class="text-white-50 text-uppercase text-xs fw-bold tracking-wider">Total Monthly Hours</span>
                                <h2 class="fw-black text-blue mt-2 mb-0">${totalHours} <span class="fs-6 font-normal">hrs</span></h2>
                                <div class="text-xs text-blue mt-2"><i class="fas fa-clock me-1"></i> Hours On Site</div>
                            </div>
                            <div class="metric-icon-box metric-icon-blue">
                                <i class="fas fa-business-time"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-sm-6 col-xl-3">
                    <div class="metric-card-v2">
                        <div class="d-flex justify-content-between align-items-start">
                            <div>
                                <span class="text-white-50 text-uppercase text-xs fw-bold tracking-wider">Supervisor Contractor</span>
                                <h6 class="fw-bold text-white mt-2 mb-0 text-truncate" style="max-width: 140px;">
                                    <c:out value="${contractor.name}" default="Vikram Singh Contractor"/>
                                </h6>
                                <div class="text-xs text-purple mt-2"><i class="fas fa-hard-hat me-1"></i> Contractor Code: CON-201</div>
                            </div>
                            <div class="metric-icon-box metric-icon-purple">
                                <i class="fas fa-user-shield"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Attendance Sheet Glass Panel -->
            <div class="glass-panel p-4">
                <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom border-white border-opacity-10">
                    <h6 class="fw-bold text-white m-0">
                        <i class="fas fa-list-check text-warning me-2"></i> Daily Shift Attendance Records (${attendanceList.size()} Days Logged)
                    </h6>
                    <span class="badge bg-success text-white px-3 py-1.5 fw-bold"><i class="fas fa-shield-alt me-1"></i> Verified Site Logs</span>
                </div>

                <div class="table-responsive">
                    <table class="table table-dark-custom align-middle">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Check In</th>
                                <th>Check Out</th>
                                <th>Hours Worked</th>
                                <th>Shift Status</th>
                                <th>Site Location</th>
                                <th>Remarks</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="att" items="${attendanceList}">
                                <tr>
                                    <td class="fw-bold text-white">
                                        <i class="far fa-calendar-alt text-warning me-2"></i>${att.date}
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty att.checkIn}">
                                                <span class="text-success font-monospace fw-bold"><i class="fas fa-sign-in-alt me-1"></i>${att.checkIn}</span>
                                            </c:when>
                                            <c:otherwise><span class="text-white-50">--:--</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty att.checkOut}">
                                                <span class="text-warning font-monospace fw-bold"><i class="fas fa-sign-out-alt me-1"></i>${att.checkOut}</span>
                                            </c:when>
                                            <c:otherwise><span class="text-white-50">--:--</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="fw-bold text-white font-monospace">
                                        ${att.workingHours} hrs
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${att.status == 'PRESENT'}">
                                                <span class="badge bg-success text-white px-2.5 py-1 fw-bold"><i class="fas fa-check me-1"></i> PRESENT</span>
                                            </c:when>
                                            <c:when test="${att.status == 'HALF_DAY'}">
                                                <span class="badge bg-warning text-dark px-2.5 py-1 fw-bold"><i class="fas fa-hourglass-half me-1"></i> HALF DAY</span>
                                            </c:when>
                                            <c:when test="${att.status == 'OFF_DAY'}">
                                                <span class="badge bg-secondary bg-opacity-75 text-white-50 px-2.5 py-1 fw-bold"><i class="fas fa-bed me-1"></i> WEEKEND OFF</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger text-white px-2.5 py-1 fw-bold"><i class="fas fa-times me-1"></i> ABSENT</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-warning small fw-semibold">
                                        <i class="fas fa-map-marker-alt me-1"></i><c:out value="${att.siteName}" default="GIFT City Site A"/>
                                    </td>
                                    <td class="text-white-50 small">
                                        <c:out value="${att.remarks}" default="Regular Duty"/>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty attendanceList}">
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-5">
                                        <i class="fas fa-calendar-times fa-3x mb-3 text-warning opacity-50"></i>
                                        <h6 class="text-white fw-bold">No attendance records found for this month</h6>
                                        <p class="text-white-50 small">Punch in daily using the shift counter on your dashboard to log attendance.</p>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
    </script>
</body>
</html>
