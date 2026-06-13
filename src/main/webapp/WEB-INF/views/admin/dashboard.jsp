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
        .admin-table th {
            color: #fff !important;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .admin-table td {
            font-size: 0.9rem;
            color: rgba(255,255,255,0.85);
        }
    </style>
</head>
<body class="planner-bg">

    <!-- Navigation -->
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

    <!-- Main Content Container -->
    <div class="container py-5 fade-in">
        
        <!-- Dashboard title -->
        <div class="mb-5">
            <h1 style="font-weight: 800; color: #fff;" class="mb-1">Admin Panel</h1>
            <p class="text-white-50 mb-0">Manage customer submissions, review recommendations, upload professional plans, and track planning requests.</p>
        </div>

        <!-- Metric Analytics Cards -->
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

        <!-- Requests Management List -->
        <h4 style="font-weight: 700; color: #fff;" class="mb-4"><i class="fas fa-list-check me-2 text-warning"></i> Customer Planner Requests</h4>

        <div class="glass-card p-4 rounded-4">
            <div class="table-responsive">
                <table class="table admin-table align-middle">
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
                                        <!-- Date -->
                                        <td>
                                            <fmt:formatDate value="${item.propertyDetail.createdAt}" pattern="dd MMM yyyy"/><br>
                                            <small class="text-white-50"><fmt:formatDate value="${item.propertyDetail.createdAt}" pattern="HH:mm"/></small>
                                        </td>
                                        <!-- Customer -->
                                        <td>
                                            <strong class="text-white">${item.propertyDetail.ownerName}</strong><br>
                                            <small class="text-white-50">${item.propertyDetail.email}</small><br>
                                            <small class="text-white-50">${item.propertyDetail.phone}</small>
                                        </td>
                                        <!-- Specs -->
                                        <td>
                                            <strong class="text-white">${item.propertyDetail.length} × ${item.propertyDetail.width} ft</strong><br>
                                            <span class="text-white-50">${item.propertyDetail.floors} Floors, ${item.propertyDetail.bedrooms} BHK</span><br>
                                            <small class="text-warning">Vastu: ${item.propertyDetail.vastu}</small>
                                        </td>
                                        <!-- Style & Budget -->
                                        <td>
                                            <span class="badge bg-secondary mb-1">${item.propertyDetail.style}</span><br>
                                            <small class="text-white-50">${item.propertyDetail.budgetRange}</small>
                                        </td>
                                        <!-- Blueprint / Drawing -->
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
                                        <!-- Approval -->
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
                                        <!-- Actions -->
                                        <td class="text-end">
                                            <div class="d-flex justify-content-end gap-2">
                                                <a href="/planner/detail?id=${item.propertyDetail.id}" class="btn btn-gold-outline btn-sm rounded-pill px-3" target="_blank">View 3D</a>
                                                
                                                <!-- Action Modals Triggers -->
                                                <button class="btn btn-gold btn-sm rounded-pill px-3" data-bs-toggle="modal" data-bs-target="#editModal-${item.propertyDetail.id}">Manage</button>
                                            </div>

                                            <!-- Modal block for actions -->
                                            <div class="modal fade" id="editModal-${item.propertyDetail.id}" tabindex="-1" aria-hidden="true" style="text-align: left;">
                                                <div class="modal-dialog modal-dialog-centered modal-lg">
                                                    <div class="modal-content bg-dark text-white border border-secondary border-opacity-50 rounded-4">
                                                        <div class="modal-header border-secondary border-opacity-25">
                                                            <h5 class="modal-title" style="font-weight: 700; color: var(--yellow);">Manage Plan #${item.propertyDetail.id}</h5>
                                                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body p-4">
                                                            
                                                            <!-- Toggle Approval Form -->
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

                                                            <!-- Edit Recommendations Form -->
                                                            <form action="/admin/plan/edit" method="post" class="mb-4 pb-4 border-bottom border-secondary border-opacity-25">
                                                                <input type="hidden" name="propertyId" value="${item.propertyDetail.id}">
                                                                <div class="mb-3">
                                                                    <label for="recs-${item.propertyDetail.id}" class="form-label text-white-50">Edit Plan Recommendations</label>
                                                                    <textarea class="form-control glass-input" id="recs-${item.propertyDetail.id}" name="recommendations" rows="5" required>${item.housePlan.recommendations}</textarea>
                                                                </div>
                                                                <button type="submit" class="btn btn-gold rounded-pill px-4">Save Recommendations</button>
                                                            </form>

                                                            <!-- Upload Drawing Form -->
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

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
