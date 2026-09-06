<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Work Types - Contractor Portal</title>
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
                <a href="${pageContext.request.contextPath}/employee/contractor/workers" class="nav-link-custom">
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
                <a href="${pageContext.request.contextPath}/employee/contractor/work-types" class="nav-link-custom active">
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
                <h5 class="m-0 fw-bold text-white"><i class="fas fa-tools text-warning me-2"></i>Construction Work Types Catalog</h5>
            </div>
            <div class="text-end">
                <div class="fw-bold text-white small"><c:out value="${contractor.name}"/></div>
                <div class="text-warning text-xs font-monospace"><c:out value="${contractor.employeeCode}" default="CON-201"/></div>
            </div>
        </header>

        <div class="p-3 p-md-4">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
                <div>
                    <h4 class="fw-extrabold text-white m-0">Construction Trades & Work Types</h4>
                    <p class="text-white-50 small m-0">Catalog of specialized trade categories available for worker assignments</p>
                </div>
                <div>
                    <button class="btn btn-warning text-dark fw-bold btn-sm" data-bs-toggle="modal" data-bs-target="#addWorkTypeModal">
                        <i class="fas fa-plus me-1"></i> Add Custom Work Type
                    </button>
                </div>
            </div>

            <!-- Work Types Table -->
            <div class="glass-panel p-4 mb-4">
                <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom border-white border-opacity-10">
                    <h6 class="fw-bold text-white m-0"><i class="fas fa-list-alt text-warning me-2"></i> Available Trades Catalog (${workTypes.size()})</h6>
                </div>

                <div class="table-responsive">
                    <table class="table table-dark table-hover align-middle mb-0" style="background: transparent;">
                        <thead>
                            <tr class="text-white-50 small text-uppercase">
                                <th>ID</th>
                                <th>Work Type Name</th>
                                <th>Trade Category</th>
                                <th>Description / Scope</th>
                                <th class="text-end">Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="wt" items="${workTypes}">
                                <tr>
                                    <td><span class="badge bg-dark border border-secondary text-warning font-monospace">#${wt.id}</span></td>
                                    <td class="fw-bold text-white fs-6">${wt.name}</td>
                                    <td>
                                        <span class="badge bg-info bg-opacity-20 text-info border border-info px-2.5 py-1">
                                            ${wt.category}
                                        </span>
                                    </td>
                                    <td class="text-white-50 small">${wt.description}</td>
                                    <td class="text-end">
                                        <span class="badge bg-success bg-opacity-20 text-success border border-success">ACTIVE</span>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty workTypes}">
                                <tr>
                                    <td colspan="5" class="text-center text-muted py-5">
                                        No work types created yet. Click Add Custom Work Type to create one.
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>

    <!-- Add Work Type Modal -->
    <div class="modal fade" id="addWorkTypeModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content glass-panel text-white" style="background: #0f172a; border: 1px solid rgba(255,255,255,0.15);">
                <div class="modal-header border-bottom border-white border-opacity-10">
                    <h5 class="modal-title fw-bold text-warning"><i class="fas fa-hammer me-2"></i> Add Custom Work Type</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/employee/contractor/work-types/add" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label class="form-label text-white-50 small">Work Type Name</label>
                            <input type="text" name="name" class="form-control bg-dark text-white border-secondary" placeholder="e.g. Solar Panel Framing & Wiring" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-white-50 small">Trade Category</label>
                            <select name="category" class="form-select bg-dark text-white border-secondary" required>
                                <option value="Structural">Structural</option>
                                <option value="Masonry">Masonry</option>
                                <option value="Finishing">Finishing</option>
                                <option value="MEP">MEP (Mechanical, Electrical, Plumbing)</option>
                                <option value="Steel">Steel Work</option>
                                <option value="Chemical">Chemical / Waterproofing</option>
                                <option value="Interior">Interior / Woodwork</option>
                                <option value="General">General / Labour</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-white-50 small">Description</label>
                            <textarea name="description" rows="3" class="form-control bg-dark text-white border-secondary" placeholder="Brief scope of work description..."></textarea>
                        </div>
                    </div>
                    <div class="modal-footer border-top border-white border-opacity-10">
                        <button type="button" class="btn btn-outline-glass btn-sm" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-warning text-dark fw-bold btn-sm">Save Work Type</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('sidebarToggleBtn')?.addEventListener('click', function() {
            document.getElementById('appSidebar')?.classList.toggle('active');
        });
    </script>
</body>
</html>
