<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Workers - A K Construction</title>
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
            <span class="badge bg-warning text-dark ms-2 fw-bold" style="font-size: 0.7rem;">CONTRACTOR</span>
        </div>

        <ul class="sidebar-nav">
            <li class="nav-header">CONTRACTOR PORTAL</li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/employee/contractor/dashboard" class="nav-link-custom">
                    <i class="fas fa-th-large"></i>
                    <span>Contractor Dashboard</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/employee/contractor/workers" class="nav-link-custom active">
                    <i class="fas fa-users"></i>
                    <span>Manage Workers</span>
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
                <h5 class="m-0 fw-bold text-white"><i class="fas fa-users text-warning me-2"></i>Site Worker Management</h5>
            </div>
            <div class="text-end">
                <div class="fw-bold text-white small"><c:out value="${contractor.name}"/></div>
                <div class="text-warning text-xs font-monospace"><c:out value="${contractor.employeeCode}" default="CON-201"/></div>
            </div>
        </header>

        <div class="p-3 p-md-4">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
                <div>
                    <h4 class="fw-extrabold text-white m-0">Assigned Site Workers</h4>
                    <p class="text-white-50 small m-0">Manage workers assigned under your site supervision</p>
                </div>

                <div class="d-flex gap-2">
                    <button type="button" class="btn btn-warning text-dark fw-bold btn-sm" data-bs-toggle="modal" data-bs-target="#assignWorkerModal">
                        <i class="fas fa-user-plus me-1"></i> Assign New Worker
                    </button>
                </div>
            </div>

            <!-- Workers Table Card -->
            <div class="glass-panel p-4 mb-4">
                <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom border-white border-opacity-10">
                    <h6 class="fw-bold text-white m-0"><i class="fas fa-list text-warning me-2"></i> Active Workers Roster (${assignedWorkers.size()})</h6>
                </div>

                <div class="table-responsive">
                    <table class="table table-dark table-hover align-middle mb-0" style="background: transparent;">
                        <thead>
                            <tr class="text-white-50 small text-uppercase">
                                <th>Worker Name</th>
                                <th>Worker Code</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Status</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="w" items="${assignedWorkers}">
                                <tr>
                                    <td class="fw-bold text-white">${w.workerName}</td>
                                    <td><span class="badge bg-dark border border-secondary text-warning font-monospace">${w.workerCode}</span></td>
                                    <td class="text-white-50 small">${w.workerEmail}</td>
                                    <td class="text-white-50 small">${w.workerPhone}</td>
                                    <td><span class="badge bg-success bg-opacity-20 text-success border border-success">ACTIVE</span></td>
                                    <td class="text-end">
                                        <a href="${pageContext.request.contextPath}/employee/contractor/assign-work?workerId=${w.workerId}" class="btn btn-xs btn-outline-warning">
                                            <i class="fas fa-tasks me-1"></i> Assign Task
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty assignedWorkers}">
                                <tr>
                                    <td colspan="6" class="text-center text-muted py-5">
                                        <i class="fas fa-user-slash fa-2x mb-2 d-block text-white-50"></i>
                                        No workers assigned to your contractor account yet.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>

    <!-- Assign Worker Modal -->
    <div class="modal fade" id="assignWorkerModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content glass-panel text-white" style="background: #0f172a; border: 1px solid rgba(255,255,255,0.15);">
                <div class="modal-header border-bottom border-white border-opacity-10">
                    <h5 class="modal-title fw-bold text-warning"><i class="fas fa-user-plus me-2"></i>Assign Registered Worker</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="${pageContext.request.contextPath}/employee/contractor/workers/assign" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label text-white-50 small">Select Registered Worker</label>
                            <select name="workerId" class="form-select bg-dark text-white border-secondary" required>
                                <c:forEach var="u" items="${allWorkerUsers}">
                                    <option value="${u.id}">${u.name} (${u.email}) - Code: ${u.employeeCode}</option>
                                </c:forEach>
                                <c:if test="${empty allWorkerUsers}">
                                    <option value="">No available unassigned workers registered</option>
                                </c:if>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer border-top border-white border-opacity-10">
                        <button type="button" class="btn btn-outline-glass btn-sm" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-warning text-dark fw-bold btn-sm">Assign to My Team</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('sidebarToggleBtn')?.addEventListener('click', function() {
            document.getElementById('appSidebar')?.classList.toggle('active');
        });
    </script>
</body>
</html>
