<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - A K Construction</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/planner.css">
    <style>
        .admin-table {
            --bs-table-bg: transparent;
            --bs-table-striped-bg: transparent;
            background: transparent !important;
            color: #fff !important;
        }
        .admin-table th {
            color: var(--yellow) !important;
            background: rgba(255, 255, 255, 0.04) !important;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid rgba(255,255,255,0.1) !important;
        }
        .admin-table td {
            font-size: 0.9rem;
            color: rgba(255,255,255,0.85) !important;
            background: transparent !important;
            border-bottom: 1px solid rgba(255,255,255,0.05) !important;
        }
        .admin-table tr:hover td {
            background: rgba(255,255,255,0.02) !important;
        }
        .nav-tabs {
            border-bottom: 2px solid rgba(255,255,255,0.1);
            margin-bottom: 2rem;
        }
        .nav-tabs .nav-link {
            color: rgba(255,255,255,0.6);
            border: none;
            padding: 1rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s;
        }
        .nav-tabs .nav-link:hover {
            color: #fff;
            border: none;
        }
        .nav-tabs .nav-link.active {
            color: var(--yellow);
            background: transparent;
            border: none;
            border-bottom: 2px solid var(--yellow);
        }
        .modal {
            z-index: 1055 !important;
        }
        .modal-backdrop {
            z-index: 1040 !important;
        }
        .modal-content {
            background-color: #1e1e30 !important;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.7);
        }
    </style>
</head>
<body class="planner-bg">

    <nav class="navbar navbar-expand-lg navbar-dark planner-nav sticky-top">
        <div class="container py-2">
            <a class="navbar-brand d-flex align-items-center" href="/" style="font-weight: 800; color: var(--yellow);">
                <i class="fas fa-hammer me-2"></i> A K Construction Admin
            </a>
            <div class="ms-auto d-flex align-items-center gap-3">
                <a href="/planner/dashboard" class="btn btn-gold-outline rounded-pill px-4 btn-sm"><i class="fas fa-user me-1"></i> Customer View</a>
                <a href="/logout" class="btn btn-gold rounded-pill px-4 btn-sm"><i class="fas fa-sign-out-alt me-1"></i> Logout</a>
            </div>
        </div>
    </nav>

    <div class="container py-5 fade-in">
        
        <!-- Dashboard title -->
        <div class="mb-5">
            <h1 style="font-weight: 800; color: #fff;" class="mb-1">Admin Panel</h1>
            <p class="text-white-50 mb-0">Manage customer submissions, projects, user accounts, and professional plans.</p>
        </div>

        <!-- Navigation Tabs -->
        <ul class="nav nav-tabs" id="adminTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="planner-tab" data-bs-toggle="tab" data-bs-target="#planner" type="button" role="tab" aria-controls="planner" aria-selected="true"><i class="fas fa-list-check me-2"></i> Planner Requests</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="projects-tab" data-bs-toggle="tab" data-bs-target="#projects" type="button" role="tab" aria-controls="projects" aria-selected="false"><i class="fas fa-building me-2"></i> Projects Gallery</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="contacts-tab" data-bs-toggle="tab" data-bs-target="#contacts" type="button" role="tab" aria-controls="contacts" aria-selected="false"><i class="fas fa-envelope me-2"></i> Messages</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="users-tab" data-bs-toggle="tab" data-bs-target="#users" type="button" role="tab" aria-controls="users" aria-selected="false"><i class="fas fa-users me-2"></i> Users</button>
            </li>
        </ul>

        <div class="tab-content" id="adminTabsContent">
            
            <!-- TAB 1: PLANNER REQUESTS -->
            <div class="tab-pane fade show active" id="planner" role="tabpanel" aria-labelledby="planner-tab">
                <div class="row g-4 mb-5">
                    <div class="col-md-3">
                        <div class="glass-card p-4">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="text-white-50" style="font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.5px;">Registered Users</span>
                                <span class="text-warning"><i class="fas fa-users"></i></span>
                            </div>
                            <h3 class="mb-0 text-white" style="font-weight: 800;">${usersCount}</h3>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="glass-card p-4">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="text-white-50" style="font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.5px;">Total Requests</span>
                                <span class="text-warning"><i class="fas fa-file-invoice"></i></span>
                            </div>
                            <h3 class="mb-0 text-white" style="font-weight: 800;">${totalRequests}</h3>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="glass-card p-4">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="text-white-50" style="font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.5px;">Approved Plans</span>
                                <span class="text-success"><i class="fas fa-circle-check"></i></span>
                            </div>
                            <h3 class="mb-0 text-white" style="font-weight: 800;">${approvedRequests}</h3>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="glass-card p-4">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="text-white-50" style="font-size: 0.8rem; text-transform: uppercase; letter-spacing: 0.5px;">Vastu Requests</span>
                                <span class="text-info"><i class="fas fa-compass"></i></span>
                            </div>
                            <h3 class="mb-0 text-white" style="font-weight: 800;">${vastuRequests}</h3>
                        </div>
                    </div>
                </div>

                <div class="glass-card p-4 rounded-4">
                    <div class="table-responsive">
                        <table class="table table-dark table-hover admin-table premium-table align-middle">
                            <thead>
                                <tr>
                                    <th>Submitted Date</th>
                                    <th>Customer & Contact</th>
                                    <th>Property Specifications</th>
                                    <th>Style & Budget</th>
                                    <th>Drawing Uploads</th>
                                    <th>Status Approval</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty requests}">
                                        <tr>
                                            <td colspan="7" class="text-center py-5 text-white-50">
                                                <i class="fas fa-inbox mb-3 d-block" style="font-size: 3rem;"></i>
                                                No customer planning requests found.
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="item" items="${requests}">
                                            <tr>
                                                <td>
                                                    <fmt:formatDate value="${item.propertyDetail.createdAt}" pattern="dd MMM yyyy"/><br>
                                                    <small class="text-white-50"><fmt:formatDate value="${item.propertyDetail.createdAt}" pattern="HH:mm"/></small>
                                                </td>
                                                <td>
                                                    <strong class="text-white">${item.propertyDetail.ownerName}</strong><br>
                                                    <small class="text-white-50">${item.propertyDetail.email}</small><br>
                                                    <small class="text-white-50">${item.propertyDetail.phone}</small>
                                                </td>
                                                <td>
                                                    <strong class="text-white">${item.propertyDetail.length} × ${item.propertyDetail.width} ft</strong><br>
                                                    <span class="text-white-50">${item.propertyDetail.floors} Floors, ${item.propertyDetail.bedrooms} BHK</span><br>
                                                    <small class="text-warning">Vastu: ${item.propertyDetail.vastu}</small>
                                                </td>
                                                <td>
                                                    <span class="badge bg-secondary mb-1">${item.propertyDetail.style}</span><br>
                                                    <small class="text-white-50">${item.propertyDetail.budgetRange}</small>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty item.housePlan.architectDrawingUrl}">
                                                            <span class="text-success"><i class="fas fa-check-circle me-1"></i> Uploaded</span><br>
                                                            <a href="${item.housePlan.architectDrawingUrl}" class="text-warning" style="font-size:0.8rem;" download>Download</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-white-50"><i class="fas fa-times-circle me-1"></i> None</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${item.housePlan.approved}">
                                                            <span class="badge bg-success"><i class="fas fa-check me-1"></i> Approved</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-warning text-dark"><i class="fas fa-clock me-1"></i> Pending</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-end">
                                                    <div class="d-flex justify-content-end gap-2">
                                                        <a href="/planner/detail?id=${item.propertyDetail.id}" class="btn btn-gold-outline btn-sm rounded-pill px-3" target="_blank">View</a>
                                                        <button type="button" class="btn btn-gold btn-sm rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#editModal-${item.propertyDetail.id}">Manage</button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- TAB 2: PROJECTS GALLERY -->
            <div class="tab-pane fade" id="projects" role="tabpanel" aria-labelledby="projects-tab">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 style="font-weight: 700; color: #fff;" class="mb-0">Gallery Projects</h4>
                    <button class="btn btn-gold rounded-pill px-4" data-bs-toggle="modal" data-bs-target="#addProjectModal"><i class="fas fa-plus me-2"></i> Add New Project</button>
                </div>
                
                <div class="glass-card p-4 rounded-4">
                    <div class="table-responsive">
                        <table class="table table-dark table-hover admin-table premium-table align-middle">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Image</th>
                                    <th>Title</th>
                                    <th>Category</th>
                                    <th>Description</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty allProjects}">
                                        <tr><td colspan="6" class="text-center py-4 text-white-50">No projects found.</td></tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="proj" items="${allProjects}">
                                            <tr>
                                                <td>#${proj.id}</td>
                                                <td><img src="/${proj.image}" alt="Project" style="width:60px; height:60px; object-fit:cover; border-radius:8px;"></td>
                                                <td><strong class="text-white">${proj.title}</strong></td>
                                                <td><span class="badge bg-secondary">${proj.category}</span></td>
                                                <td>
                                                    <span class="text-white-50 d-inline-block text-truncate" style="max-width: 250px;">
                                                        ${proj.description}
                                                    </span>
                                                </td>
                                                <td class="text-end">
                                                    <form action="/admin/project/delete" method="post" onsubmit="return confirm('Delete this project?');">
                                                        <input type="hidden" name="id" value="${proj.id}">
                                                        <button type="submit" class="btn btn-outline-danger btn-sm rounded-pill"><i class="fas fa-trash"></i></button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- TAB 3: CONTACT MESSAGES -->
            <div class="tab-pane fade" id="contacts" role="tabpanel" aria-labelledby="contacts-tab">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 style="font-weight: 700; color: #fff;" class="mb-0">Customer Inquiries</h4>
                </div>
                <div class="glass-card p-4 rounded-4">
                    <div class="table-responsive">
                        <table class="table table-dark table-hover admin-table premium-table align-middle">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Name</th>
                                    <th>Email / Phone</th>
                                    <th>Message</th>
                                    <th class="text-end">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty allContacts}">
                                        <tr><td colspan="5" class="text-center py-4 text-white-50">No messages found.</td></tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="contact" items="${allContacts}">
                                            <tr>
                                                <td class="text-white-50">
                                                    <fmt:formatDate value="${contact.submittedDate}" pattern="dd MMM yyyy, HH:mm"/>
                                                </td>
                                                <td><strong class="text-white">${contact.name}</strong></td>
                                                <td>
                                                    <a href="mailto:${contact.email}" class="text-warning">${contact.email}</a><br>
                                                    <small class="text-white-50">${contact.phone}</small>
                                                </td>
                                                <td>
                                                    <span class="text-white-50 d-inline-block text-truncate" style="max-width: 300px;" title="${contact.message}">
                                                        ${contact.message}
                                                    </span>
                                                </td>
                                                <td class="text-end">
                                                    <form action="/admin/contact/delete" method="post" onsubmit="return confirm('Delete this message?');">
                                                        <input type="hidden" name="id" value="${contact.id}">
                                                        <button type="submit" class="btn btn-outline-danger btn-sm rounded-pill"><i class="fas fa-trash"></i></button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- TAB 4: USERS -->
            <div class="tab-pane fade" id="users" role="tabpanel" aria-labelledby="users-tab">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h4 style="font-weight: 700; color: #fff;" class="mb-0">All System Accounts & Master Access</h4>
                        <p class="text-white-50 small mb-0">Admin master access panel - enter any account or edit profile details at any time.</p>
                    </div>
                </div>
                <div class="glass-card p-4 rounded-4">
                    <div class="table-responsive">
                        <table class="table table-dark table-hover admin-table premium-table align-middle">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Account Name</th>
                                    <th>Email / Phone</th>
                                    <th>Access Role</th>
                                    <th>Status</th>
                                    <th class="text-end">Master Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty allUsers}">
                                        <tr><td colspan="6" class="text-center py-4 text-white-50">No users found.</td></tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="usr" items="${allUsers}">
                                            <tr>
                                                <td>#${usr.id}</td>
                                                <td>
                                                    <strong class="text-white">${usr.name}</strong><br>
                                                    <small class="text-warning font-monospace">${usr.employeeCode}</small>
                                                </td>
                                                <td>
                                                    <span class="text-white">${usr.email}</span><br>
                                                    <small class="text-white-50">${empty usr.phone ? '+91 N/A' : usr.phone}</small>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${usr.role == 'ADMIN'}">
                                                            <span class="badge bg-warning text-dark fw-bold"><i class="fas fa-shield-alt me-1"></i> ADMIN</span>
                                                        </c:when>
                                                        <c:when test="${usr.role == 'CONTRACTOR'}">
                                                            <span class="badge bg-primary text-white fw-bold"><i class="fas fa-user-ninja me-1"></i> CONTRACTOR</span>
                                                        </c:when>
                                                        <c:when test="${usr.role == 'WORKER'}">
                                                            <span class="badge bg-success text-white fw-bold"><i class="fas fa-hammer me-1"></i> WORKER</span>
                                                        </c:when>
                                                        <c:when test="${usr.role == 'EMPLOYEE'}">
                                                            <span class="badge bg-info text-dark fw-bold"><i class="fas fa-hard-hat me-1"></i> EMPLOYEE</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary"><i class="fas fa-user me-1"></i> CLIENT</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${usr.status == 'ACTIVE'}">
                                                            <span class="badge bg-success bg-opacity-25 text-success border border-success px-2 py-1">ACTIVE</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-danger bg-opacity-25 text-danger border border-danger px-2 py-1">INACTIVE</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-end">
                                                    <div class="d-flex justify-content-end align-items-center gap-2">
                                                        <!-- Enter Account 1-Click Master Access -->
                                                        <a href="/admin/switch-account?userId=${usr.id}" class="btn btn-warning btn-sm rounded-pill font-monospace fw-bold px-3 shadow" title="Enter Account as ${usr.name}">
                                                            <i class="fas fa-sign-in-alt me-1"></i> Enter Account
                                                        </a>

                                                        <!-- Edit Info Modal Button -->
                                                        <button type="button" class="btn btn-outline-light btn-sm rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#editUserModal-${usr.id}">
                                                            <i class="fas fa-edit me-1"></i> Edit Info
                                                        </button>

                                                        <c:choose>
                                                            <c:when test="${usr.role == 'ADMIN'}">
                                                                <button class="btn btn-outline-secondary btn-sm rounded-pill" disabled title="Cannot delete active admin"><i class="fas fa-lock"></i></button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <form action="/admin/user/delete" method="post" onsubmit="return confirm('Delete this user account?');" class="d-inline-block mb-0">
                                                                    <input type="hidden" name="id" value="${usr.id}">
                                                                    <button type="submit" class="btn btn-outline-danger btn-sm rounded-pill"><i class="fas fa-trash"></i></button>
                                                                </form>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div> <!-- End Tab Content -->
    </div> <!-- End Container -->

    <!-- ALL MODALS AT BODY ROOT LEVEL FOR PROPER Z-INDEX & BACKDROP STACKING -->
    <c:if test="${not empty requests}">
        <c:forEach var="item" items="${requests}">
            <div class="modal fade" id="editModal-${item.propertyDetail.id}" tabindex="-1" aria-hidden="true" style="text-align: left;">
                <div class="modal-dialog modal-dialog-centered modal-lg">
                    <div class="modal-content text-white border border-secondary border-opacity-50 rounded-4">
                        <div class="modal-header border-secondary border-opacity-25">
                            <h5 class="modal-title" style="font-weight: 700; color: var(--yellow);">Manage Plan #${item.propertyDetail.id}</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body p-4">
                            <form action="/admin/plan/approve" method="post" class="mb-4 pb-4 border-bottom border-secondary border-opacity-25">
                                <input type="hidden" name="propertyId" value="${item.propertyDetail.id}">
                                <label class="form-label text-white-50">Approve Conceptual Plan</label>
                                <div class="d-flex align-items-center justify-content-between">
                                    <span class="text-white-50" style="font-size: 0.85rem;">Approving this layout marks it as architect-reviewed on the customer's dashboard.</span>
                                    <c:choose>
                                        <c:when test="${item.housePlan.approved}">
                                            <input type="hidden" name="approve" value="false">
                                            <button type="submit" class="btn btn-warning rounded-pill px-4">Revoke Approval</button>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="hidden" name="approve" value="true">
                                            <button type="submit" class="btn btn-success rounded-pill px-4">Approve Plan</button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </form>
                            <form action="/admin/plan/edit" method="post" class="mb-4 pb-4 border-bottom border-secondary border-opacity-25">
                                <input type="hidden" name="propertyId" value="${item.propertyDetail.id}">
                                <div class="mb-3">
                                    <label for="recs-${item.propertyDetail.id}" class="form-label text-white-50">Edit Plan Recommendations</label>
                                    <textarea class="form-control glass-input" id="recs-${item.propertyDetail.id}" name="recommendations" rows="5" required>${item.housePlan.recommendations}</textarea>
                                </div>
                                <button type="submit" class="btn btn-gold rounded-pill px-4">Save Recommendations</button>
                            </form>
                            <form action="/admin/plan/upload-drawing" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="propertyId" value="${item.propertyDetail.id}">
                                <div class="mb-3">
                                    <label for="drawingFile-${item.propertyDetail.id}" class="form-label text-white-50">Upload Professional Blueprint / 2D Cad Drawing</label>
                                    <input type="file" class="form-control glass-input" id="drawingFile-${item.propertyDetail.id}" name="drawingFile" accept="image/*,application/pdf" required>
                                    <div class="form-text text-white-50" style="font-size: 0.75rem;">Select an official drawing to upload. Allowed formats: PNG, JPG, PDF.</div>
                                </div>
                                <button type="submit" class="btn btn-gold rounded-pill px-4">Upload Drawing</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </c:if>

    <!-- Edit User Information Modals -->
    <c:if test="${not empty allUsers}">
        <c:forEach var="usr" items="${allUsers}">
            <div class="modal fade" id="editUserModal-${usr.id}" tabindex="-1" aria-hidden="true" style="text-align: left;">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content text-white border border-secondary border-opacity-50 rounded-4">
                        <div class="modal-header border-secondary border-opacity-25">
                            <h5 class="modal-title fw-bold" style="color: var(--yellow);"><i class="fas fa-user-edit me-2"></i>Edit Account #${usr.id} - ${usr.name}</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form action="/admin/user/edit" method="post">
                            <input type="hidden" name="id" value="${usr.id}">
                            <div class="modal-body p-4">
                                <div class="mb-3">
                                    <label class="form-label text-white-50 small">Full Name</label>
                                    <input type="text" name="name" class="form-control glass-input" value="${usr.name}" required>
                                </div>
                                <div class="row">
                                    <div class="col-6 mb-3">
                                        <label class="form-label text-white-50 small">Email Address</label>
                                        <input type="email" name="email" class="form-control glass-input" value="${usr.email}" required>
                                    </div>
                                    <div class="col-6 mb-3">
                                        <label class="form-label text-white-50 small">Phone Number</label>
                                        <input type="text" name="phone" class="form-control glass-input" value="${usr.phone}">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-6 mb-3">
                                        <label class="form-label text-white-50 small">Role / Access Level</label>
                                        <select name="role" class="form-select glass-input text-dark">
                                            <option value="WORKER" ${usr.role == 'WORKER' ? 'selected' : ''}>WORKER</option>
                                            <option value="CONTRACTOR" ${usr.role == 'CONTRACTOR' ? 'selected' : ''}>CONTRACTOR</option>
                                            <option value="EMPLOYEE" ${usr.role == 'EMPLOYEE' ? 'selected' : ''}>EMPLOYEE</option>
                                            <option value="USER" ${usr.role == 'USER' ? 'selected' : ''}>CLIENT (USER)</option>
                                            <option value="ADMIN" ${usr.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
                                        </select>
                                    </div>
                                    <div class="col-6 mb-3">
                                        <label class="form-label text-white-50 small">Account Status</label>
                                        <select name="status" class="form-select glass-input text-dark">
                                            <option value="ACTIVE" ${usr.status == 'ACTIVE' ? 'selected' : ''}>ACTIVE</option>
                                            <option value="INACTIVE" ${usr.status == 'INACTIVE' ? 'selected' : ''}>INACTIVE</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label text-white-50 small">Reset Password <small class="text-white-50">(Leave blank to keep unchanged)</small></label>
                                    <input type="password" name="password" class="form-control glass-input" placeholder="New Password...">
                                </div>
                            </div>
                            <div class="modal-footer border-secondary border-opacity-25">
                                <button type="button" class="btn btn-outline-secondary rounded-pill px-4" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-gold rounded-pill px-4"><i class="fas fa-save me-1"></i> Save Changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:forEach>
    </c:if>

    <!-- Add Project Modal -->
    <div class="modal fade" id="addProjectModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content text-white border border-secondary border-opacity-50 rounded-4">
                <div class="modal-header border-secondary border-opacity-25">
                    <h5 class="modal-title" style="font-weight: 700; color: var(--yellow);">Add New Project</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <form action="/admin/project/add" method="post" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label class="form-label text-white-50">Project Title</label>
                            <input type="text" name="title" class="form-control glass-input" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-white-50">Category</label>
                            <select name="category" class="form-control glass-input text-dark" required>
                                <option value="Residential">Residential</option>
                                <option value="Commercial">Commercial</option>
                                <option value="Renovation">Renovation</option>
                                <option value="Civil Engineering">Civil Engineering</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label text-white-50">Description</label>
                            <textarea name="description" class="form-control glass-input" rows="3" required></textarea>
                        </div>
                        <div class="mb-4">
                            <label class="form-label text-white-50">Project Image</label>
                            <input type="file" name="imageFile" class="form-control glass-input" accept="image/*" required>
                        </div>
                        <button type="submit" class="btn btn-gold rounded-pill w-100 py-2">Add Project</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
