<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - AI Smart House Planner</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/planner.css">
</head>
<body class="planner-bg">

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark planner-nav sticky-top">
        <div class="container py-2">
            <a class="navbar-brand d-flex align-items-center" href="/" style="font-weight: 800; color: var(--yellow);">
                <i class="fas fa-hammer me-2"></i> A K Construction
            </a>
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <a class="nav-link active me-3" href="/planner/dashboard"><i class="fas fa-th-large me-1"></i> Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-gold rounded-pill px-4" href="/planner/new"><i class="fas fa-magic me-1"></i> Plan New House</a>
                    </li>
                    <li class="nav-item ms-lg-3 dropdown mt-3 mt-lg-0">
                        <a class="nav-link dropdown-toggle text-white d-flex align-items-center" href="#" id="userDrop" role="button" data-bs-toggle="dropdown">
                            <div class="bg-warning text-dark rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 32px; height: 32px; font-weight: 700;">
                                ${sessionScope.user.name.substring(0,1).toUpperCase()}
                            </div>
                            ${sessionScope.user.name}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-dark border-0 shadow mt-2 rounded-3">
                            <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                <li><a class="dropdown-item py-2" href="/admin/dashboard"><i class="fas fa-shield-halved me-2 text-warning"></i> Admin Panel</a></li>
                                <li><hr class="dropdown-divider bg-secondary"></li>
                            </c:if>
                            <li><a class="dropdown-item py-2" href="/logout"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Dashboard Container -->
    <div class="container py-5 fade-in">
        
        <!-- Welcome Block -->
        <div class="d-flex justify-content-between align-items-center mb-5 flex-wrap gap-3">
            <div>
                <h1 style="font-weight: 800; color: #fff;" class="mb-1">AI Smart House Planner</h1>
                <p class="text-white-50 mb-0">Generate, customize, and inspect your custom luxury layouts interactively.</p>
            </div>
            <a href="/planner/new" class="btn btn-gold py-3 px-4"><i class="fas fa-plus me-2"></i> Create New Layout Request</a>
        </div>

        <!-- Metric Cards -->
        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="glass-card p-4 d-flex align-items-center">
                    <div class="rounded-circle bg-warning bg-opacity-10 text-warning p-3 me-3" style="font-size: 1.5rem;">
                        <i class="fas fa-folder-open"></i>
                    </div>
                    <div>
                        <h6 class="text-white-50 mb-1" style="font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.5px;">Total Requests</h6>
                        <h3 class="mb-0 font-weight-bold" style="color: #fff;">${requests.size()}</h3>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="glass-card p-4 d-flex align-items-center">
                    <div class="rounded-circle bg-success bg-opacity-10 text-success p-3 me-3" style="font-size: 1.5rem;">
                        <i class="fas fa-circle-check"></i>
                    </div>
                    <div>
                        <h6 class="text-white-50 mb-1" style="font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.5px;">Architect Approved</h6>
                        <h3 class="mb-0 font-weight-bold" style="color: #fff;">
                            <c:set var="approved" value="0"/>
                            <c:forEach var="req" items="${requests}">
                                <c:if test="${req.style == 'Luxury' || req.style == 'Modern'}"><!-- Mock check for rendering, but actually we query from table --></c:if>
                            </c:forEach>
                            <!-- We can calculate approved count from SQL or model --><span id="approved-stat-count">Loading...</span>
                        </h3>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="glass-card p-4 d-flex align-items-center">
                    <div class="rounded-circle bg-info bg-opacity-10 text-info p-3 me-3" style="font-size: 1.5rem;">
                        <i class="fas fa-compass"></i>
                    </div>
                    <div>
                        <h6 class="text-white-50 mb-1" style="font-size: 0.85rem; text-transform: uppercase; letter-spacing: 0.5px;">Vastu Compliant</h6>
                        <h3 class="mb-0 font-weight-bold" style="color: #fff;">
                            <c:set var="vastu" value="0"/>
                            <c:forEach var="req" items="${requests}">
                                <c:if test="${req.vastu == 'Yes'}">
                                    <c:set var="vastu" value="${vastu + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${vastu}
                        </h3>
                    </div>
                </div>
            </div>
        </div>

        <!-- Requests Grid -->
        <h4 style="font-weight: 700; color: #fff;" class="mb-4"><i class="fas fa-list me-2 text-warning"></i> Previous Planning Requests</h4>

        <c:choose>
            <c:when test="${empty requests}">
                <!-- Empty State -->
                <div class="glass-card text-center p-5 rounded-4">
                    <div class="mb-4 text-warning" style="font-size: 4rem;">
                        <i class="fas fa-pencil-ruler"></i>
                    </div>
                    <h4 style="font-weight: 700; color: #fff;">No House Plans Generated Yet</h4>
                    <p class="text-white-50 mx-auto max-width-500 mb-4">Provide your plot dimensions, requested room numbers, building style preferences, and receive full 2D layout coordinates, interactive 3D visualizations, material estimations, and PDF specifications.</p>
                    <a href="/planner/new" class="btn btn-gold py-3 px-4"><i class="fas fa-magic me-2"></i> Launch Smart Planner</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row g-4">
                    <c:forEach var="req" items="${requests}">
                        <div class="col-lg-6">
                            <div class="glass-card p-4 h-100 d-flex flex-column justify-content-between">
                                <div>
                                    <div class="d-flex justify-content-between align-items-start mb-3">
                                        <div>
                                            <span class="badge bg-warning text-dark mb-2 px-3 py-1.5 rounded-pill font-weight-bold" style="font-size: 0.75rem;">${req.style}</span>
                                            <h5 style="color: #fff; font-weight: 700;" class="mb-1">${req.city}, ${req.state}</h5>
                                        </div>
                                        <div class="text-end">
                                            <span class="text-white-50 d-block" style="font-size: 0.8rem;">
                                                <i class="fas fa-calendar-alt me-1"></i> 
                                                <fmt:formatDate value="${req.createdAt}" pattern="dd MMM yyyy"/>
                                            </span>
                                        </div>
                                    </div>
                                    
                                    <div class="row g-3 py-3 my-2 border-top border-bottom border-secondary border-opacity-25">
                                        <div class="col-6">
                                            <span class="text-white-50 d-block" style="font-size: 0.8rem;">Plot Footprint:</span>
                                            <strong class="text-white">${req.length} ft × ${req.width} ft</strong>
                                        </div>
                                        <div class="col-6">
                                            <span class="text-white-50 d-block" style="font-size: 0.8rem;">Total Plot Area:</span>
                                            <strong class="text-white">${req.plotArea} sq ft</strong>
                                        </div>
                                        <div class="col-6">
                                            <span class="text-white-50 d-block" style="font-size: 0.8rem;">Floors / Rooms:</span>
                                            <strong class="text-white">${req.floors} Floors, ${req.bedrooms} BHK</strong>
                                        </div>
                                        <div class="col-6">
                                            <span class="text-white-50 d-block" style="font-size: 0.8rem;">Vastu Required:</span>
                                            <strong class="text-white">${req.vastu}</strong>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="d-flex justify-content-between align-items-center mt-3 pt-2">
                                    <div class="d-flex align-items-center">
                                        <div class="status-marker me-2"></div>
                                        <span class="text-white-50" style="font-size: 0.85rem;" data-property-id="${req.id}">
                                            Pending Review
                                        </span>
                                    </div>
                                    <a href="/planner/detail?id=${req.id}" class="btn btn-gold-outline rounded-pill px-4"><i class="fas fa-eye me-1"></i> View Plan Details</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // We can resolve approval states dynamically from a small fetch
            const statusSpans = document.querySelectorAll("[data-property-id]");
            let approvedCount = 0;
            
            // Loop through all items and fetch status, or since JSTL evaluates database model, we can parse page markup
            statusSpans.forEach(span => {
                const propId = span.getAttribute("data-property-id");
                // Fetch approval state via API
                fetch('/planner/detail?id=' + propId)
                    .then(response => response.text())
                    .then(html => {
                        const hasApprovalText = html.includes("APPROVED BY ARCHITECT") || html.includes("architect-approved-badge");
                        const marker = span.previousElementSibling;
                        if (hasApprovalText) {
                            span.innerHTML = "<span class='text-success font-weight-bold'><i class='fas fa-circle-check me-1'></i> Approved by Architect</span>";
                            if (marker) marker.style.background = "#2ecc71";
                            approvedCount++;
                        } else {
                            span.innerHTML = "<span class='text-warning'><i class='fas fa-clock me-1'></i> Pending Architect Review</span>";
                            if (marker) marker.style.background = "#F4C430";
                        }
                        document.getElementById("approved-stat-count").innerText = approvedCount;
                    });
            });
            
            setTimeout(() => {
                if (statusSpans.length === 0) {
                    document.getElementById("approved-stat-count").innerText = "0";
                }
            }, 800);
        });
    </script>
</body>
</html>
