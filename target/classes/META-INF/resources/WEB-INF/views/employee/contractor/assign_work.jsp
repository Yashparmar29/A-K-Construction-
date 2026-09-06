<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assign Work - Contractor Portal</title>
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

        .btn-gold-action {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            color: #000;
            font-weight: 700;
            border: none;
            border-radius: 10px;
            padding: 0.65rem 1.5rem;
            box-shadow: 0 4px 15px rgba(245, 158, 11, 0.3);
            transition: all 0.25s ease;
        }

        .btn-gold-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(245, 158, 11, 0.4);
            color: #000;
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
                <a href="${pageContext.request.contextPath}/employee/contractor/workers" class="nav-link-custom">
                    <i class="fas fa-users"></i>
                    <span>Manage Workers</span>
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/employee/contractor/assign-work" class="nav-link-custom active">
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
                <h5 class="m-0 fw-bold text-white"><i class="fas fa-tasks text-warning me-2"></i>Assign Construction Task</h5>
            </div>
            <div class="text-end">
                <div class="fw-bold text-white small"><c:out value="${contractor.name}"/></div>
                <div class="text-warning text-xs font-monospace"><c:out value="${contractor.employeeCode}" default="CON-201"/></div>
            </div>
        </header>

        <div class="p-3 p-md-4">
            <div class="row justify-content-center">
                <div class="col-lg-9 col-xl-8">
                    <div class="glass-panel p-4 p-md-5">
                        <div class="d-flex align-items-center gap-3 mb-4 pb-3 border-bottom border-white border-opacity-10">
                            <div class="bg-warning text-dark rounded-3 d-flex align-items-center justify-content-center fw-bold fs-3" style="width: 54px; height: 54px;">
                                <i class="fas fa-clipboard-check"></i>
                            </div>
                            <div>
                                <h4 class="fw-extrabold text-white m-0">Task Assignment Form</h4>
                                <p class="text-white-50 small m-0">Issue task assignments, deadlines, and work specs to site workers</p>
                            </div>
                        </div>

                        <c:if test="${not empty error}">
                            <div class="alert alert-danger bg-danger bg-opacity-20 text-danger border-0 rounded-3 p-3 mb-4">
                                <i class="fas fa-exclamation-triangle me-2"></i> ${error}
                            </div>
                        </c:if>

                        <form action="${pageContext.request.contextPath}/employee/contractor/assign-work" method="post">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label text-white-50 small fw-bold text-uppercase"><i class="fas fa-building text-warning me-1"></i> Select Construction Project</label>
                                    <select name="projectId" class="form-select bg-dark text-white border-secondary rounded-3 py-2.5" required>
                                        <option value="">-- Choose Construction Project --</option>
                                        <c:forEach var="p" items="${projects}">
                                            <option value="${p.id}">${p.title} (${p.category})</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label text-white-50 small fw-bold text-uppercase"><i class="fas fa-user-ninja text-warning me-1"></i> Select Assigned Worker</label>
                                    <select name="workerId" class="form-select bg-dark text-white border-secondary rounded-3 py-2.5" required>
                                        <option value="">-- Choose Supervised Worker --</option>
                                        <c:forEach var="w" items="${workers}">
                                            <option value="${w.workerId}">${w.workerName} (${w.workerCode})</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label text-white-50 small fw-bold text-uppercase"><i class="fas fa-tools text-warning me-1"></i> Construction Work Type</label>
                                    <select name="workTypeId" class="form-select bg-dark text-white border-secondary rounded-3 py-2.5" required>
                                        <option value="">-- Choose Trade / Work Type --</option>
                                        <c:forEach var="wt" items="${workTypes}">
                                            <option value="${wt.id}">${wt.name} (${wt.category})</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label text-white-50 small fw-bold text-uppercase"><i class="fas fa-exclamation-circle text-warning me-1"></i> Task Priority</label>
                                    <select name="priority" class="form-select bg-dark text-white border-secondary rounded-3 py-2.5">
                                        <option value="NORMAL">Normal Priority</option>
                                        <option value="MEDIUM" selected>Medium Priority</option>
                                        <option value="HIGH">High Priority</option>
                                        <option value="CRITICAL">Critical Priority</option>
                                    </select>
                                </div>

                                <div class="col-12">
                                    <label class="form-label text-white-50 small fw-bold text-uppercase"><i class="fas fa-heading text-warning me-1"></i> Task Title</label>
                                    <input type="text" name="taskTitle" class="form-control bg-dark text-white border-secondary rounded-3 py-2.5" placeholder="e.g. Lay Brickwork Perimeter Wall on Ground Floor" required>
                                </div>

                                <div class="col-12">
                                    <label class="form-label text-white-50 small fw-bold text-uppercase"><i class="fas fa-align-left text-warning me-1"></i> Specifications & Instructions</label>
                                    <textarea name="taskDescription" rows="4" class="form-control bg-dark text-white border-secondary rounded-3" placeholder="Provide detailed instructions, required materials mix, safety precautions, and specs..."></textarea>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label text-white-50 small fw-bold text-uppercase"><i class="far fa-calendar-alt text-warning me-1"></i> Start Date</label>
                                    <input type="date" name="startDate" class="form-control bg-dark text-white border-secondary rounded-3 py-2.5" required>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label text-white-50 small fw-bold text-uppercase"><i class="far fa-calendar-check text-success me-1"></i> Expected Target Completion Date</label>
                                    <input type="date" name="expectedEndDate" class="form-control bg-dark text-white border-secondary rounded-3 py-2.5" required>
                                </div>

                                <div class="col-12 mt-4 pt-3 border-top border-white border-opacity-10 text-end">
                                    <a href="${pageContext.request.contextPath}/employee/contractor/dashboard" class="btn btn-outline-glass me-2">Cancel</a>
                                    <button type="submit" class="btn btn-gold-action">
                                        <i class="fas fa-paper-plane me-1"></i> Issue Work Assignment
                                    </button>
                                </div>
                            </div>
                        </form>
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
