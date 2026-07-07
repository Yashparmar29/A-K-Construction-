hu<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Plan Details - A K Construction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
   
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
  
    <script src="https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/controls/OrbitControls.js"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <link rel="stylesheet" href="/css/planner.css">
</head>
<body class="planner-bg">

    <nav class="navbar navbar-expand-lg navbar-dark planner-nav sticky-top">
        <div class="container py-2">
            <a class="navbar-brand d-flex align-items-center" href="/" style="font-weight: 800; color: var(--yellow);">
                <i class="fas fa-hammer me-2"></i> A K Construction
            </a>
            <div class="ms-auto d-flex align-items-center gap-3">
                <a href="/planner/dashboard" class="btn btn-gold-outline rounded-pill px-4 btn-sm"><i class="fas fa-th-large me-1"></i> Dashboard</a>
                
               
                <form id="pdfForm" action="/planner/pdf" method="post" target="_blank" class="m-0">
                    <input type="hidden" name="id" value="${property.id}">
                    <input type="hidden" name="base64Image" id="base64Image">
                    <button type="button" class="btn btn-gold rounded-pill px-4 btn-sm" onclick="submitPdfForm()">
                        <i class="fas fa-download me-1"></i> Download PDF
                    </button>
                </form>
            </div>
        </div>
    </nav>


    <div class="container py-5 fade-in">
      
        <div class="d-flex justify-content-between align-items-start mb-5 flex-wrap gap-3">
            <div>
                <span class="badge bg-warning text-dark px-3 py-1.5 rounded-pill mb-2 font-weight-bold" style="font-size: 0.75rem;">${property.style} Plan</span>
                <h1 style="font-weight: 800; color: #fff;" class="mb-1">${property.ownerName}'s Smart House Plan</h1>
                <p class="text-white-50 mb-0"><i class="fas fa-map-marker-alt me-1 text-warning"></i> Located in ${property.city}, ${property.state}, ${property.country}</p>
            </div>
            <div id="architect-approval-container" class="text-end">
                
                <span class="text-white-50 d-block mb-1" style="font-size: 0.8rem;">Submitted: <fmt:formatDate value="${property.createdAt}" pattern="dd MMM yyyy"/></span>
            </div>
        </div>

        <c:if test="${not empty plan.architectDrawingUrl}">
            
            <div class="glass-card p-4 mb-5 border-success border-opacity-50">
                <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                    <div class="d-flex align-items-center">
                        <div class="text-success me-3" style="font-size: 2.2rem;"><i class="fas fa-file-signature"></i></div>
                        <div>
                            <h5 class="text-white mb-1" style="font-weight: 700;">Official Architect Blueprint Available</h5>
                            <p class="text-white-50 mb-0" style="font-size: 0.9rem;">A licensed architect has verified this plan and uploaded structural engineering drafts.</p>
                        </div>
                    </div>
                    <a href="${plan.architectDrawingUrl}" class="btn btn-success rounded-pill px-4" download><i class="fas fa-download me-2"></i> Download Blueprints</a>
                </div>
            </div>
        </c:if>

        <div class="row g-4">
            
            
            <div class="col-xl-8">
<<<<<<< HEAD
                <!-- Interactive House Planner Card -->
=======
            
>>>>>>> b27deffaf14836ddd4fcbd065f8479ee93ebea1e
                <div class="glass-card p-4 mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                        <h5 style="color: #fff; font-weight: 700;" class="m-0">
                            <i class="fas fa-drafting-compass text-warning me-2"></i> Interactive House Planner
                        </h5>
                        <div class="btn-group btn-group-sm" role="group">
                            <button type="button" class="btn btn-gold btn-tab" id="btn-2d" onclick="switchView('2d')">
                                <i class="fas fa-map me-1"></i> 2D Layout
                            </button>
                            <button type="button" class="btn btn-gold-outline btn-tab" id="btn-3d" onclick="switchView('3d')">
                                <i class="fas fa-cube me-1"></i> 3D Model
                            </button>
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2 bg-white bg-opacity-5 p-2 rounded-3">
                        <div class="d-flex align-items-center gap-2">
                            <span class="text-white-50" style="font-size: 0.85rem;"><i class="fas fa-layer-group text-warning me-1"></i> Floor Level:</span>
                            <select class="form-select form-select-sm bg-dark text-white border-secondary rounded-pill px-3 py-1" id="floorSelect" onchange="changeFloorLevel()" style="width: 150px; font-size: 0.85rem;">
                                <option value="all">All Floors</option>
                                <option value="Ground Floor">Ground Floor</option>
                                <c:if test="${property.floors >= 2}">
                                    <option value="First Floor">First Floor</option>
                                </c:if>
                                <c:if test="${property.floors >= 3}">
                                    <option value="Second Floor">Second Floor</option>
                                </c:if>
                            </select>
                        </div>
                        <div class="d-flex align-items-center gap-2" id="dayNightModeContainer" style="display: none;">
                            <span class="text-white-50" style="font-size: 0.85rem;"><i class="fas fa-circle-half-stroke text-warning me-1"></i> Lighting:</span>
                            <button type="button" class="btn btn-sm btn-dark rounded-pill border-secondary text-white px-3" id="dayNightBtn" onclick="toggleDayNight()" style="font-size: 0.85rem;">
                                <i class="fas fa-sun text-warning me-1"></i> Day
                            </button>
                        </div>
                    </div>
                    
                    <div id="canvas-container" style="position: relative; height: 500px;">
                        <!-- 2D Canvas View -->
                        <div id="view-2d" style="width: 100%; height: 100%; position: absolute; top:0; left:0; z-index: 10; display: block;">
                            <div class="canvas-badge"><i class="fas fa-map me-1"></i> Interactive 2D Blueprint</div>
                            <canvas id="canvas-2d" style="width: 100%; height: 100%; background: #12121e; border-radius: 16px; cursor: grab; display: block;"></canvas>
                            <div class="canvas-controls">
                                <button type="button" class="control-btn" onclick="zoom2D(1.2)" title="Zoom In"><i class="fas fa-plus"></i></button>
                                <button type="button" class="control-btn" onclick="zoom2D(0.8)" title="Zoom Out"><i class="fas fa-minus"></i></button>
                                <button type="button" class="control-btn" onclick="reset2DView()" title="Reset View"><i class="fas fa-arrows-to-eye"></i></button>
                            </div>
                            <div id="hover-card" style="display: none; position: absolute; background: rgba(18, 18, 18, 0.95); color: #fff; padding: 12px; border-radius: 10px; border: 1.5px solid var(--yellow); pointer-events: none; z-index: 100; max-width: 260px; font-size: 0.8rem; box-shadow: var(--shadow);">
                                <h6 id="hover-room-name" style="color: var(--yellow); font-weight: 700; margin-bottom: 4px; font-size: 0.85rem;">Room</h6>
                                <div id="hover-room-desc" class="text-white-50" style="line-height: 1.4;">Dimensions and spatial description.</div>
                            </div>
                        </div>
                        
                        <!-- 3D WebGL View -->
                        <div id="view-3d" style="width: 100%; height: 100%; position: absolute; top:0; left:0; z-index: 5; visibility: hidden;">
                            <div class="canvas-badge"><i class="fas fa-cube me-1"></i> Interactive 3D WebGL</div>
                            <div class="canvas-controls">
                                <button type="button" class="control-btn" onclick="animateCamera('front')" title="Front View">F</button>
                                <button type="button" class="control-btn" onclick="animateCamera('side')" title="Side View">S</button>
                                <button type="button" class="control-btn" onclick="animateCamera('top')" title="Top View">T</button>
                                <button type="button" class="control-btn" onclick="animateCamera('iso')" title="Isometric View">ISO</button>
                                <button type="button" class="control-btn" id="roofToggleBtn" onclick="toggleRoof()" title="Toggle Roof"><i class="fas fa-home"></i></button>
                                <button type="button" class="control-btn" id="walkthroughBtn" onclick="toggleWalkthrough()" title="Walkthrough Mode"><i class="fas fa-shoe-prints"></i></button>
                            </div>
                            <div class="walkthrough-overlay" id="walkthroughControls">
                                <strong>Walkthrough Enabled</strong><br>
                                Move: W, A, S, D / Arrow Keys<br>
                                Look: Drag with Left Mouse Button<br>
                                Exit: Press Walkthrough button again
                            </div>
                        </div>
                    </div>
                </div>

            
                <div class="glass-card p-4">
                    <h5 style="color: #fff; font-weight: 700;" class="mb-3"><i class="fas fa-compass text-warning me-2"></i> Spatial & Structural Recommendations</h5>
                    
                    <div class="p-3 bg-white bg-opacity-5 rounded-3 mb-4" style="line-height: 1.8;">
                        <p class="text-white-50 mb-0" style="white-space: pre-line;">${plan.recommendations}</p>
                    </div>
                    <div class="row g-3">
                        <div class="col-sm-6 col-md-3">
                            <div class="p-3 bg-dark rounded-3 text-center border border-secondary border-opacity-10">
                                <span class="text-white-50 d-block mb-1" style="font-size: 0.8rem;">Plot Area</span>
                                <strong class="text-white h5"><fmt:formatNumber value="${property.plotArea}" maxFractionDigits="0"/> sqft</strong>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-3">
                            <div class="p-3 bg-dark rounded-3 text-center border border-secondary border-opacity-10">
                                <span class="text-white-50 d-block mb-1" style="font-size: 0.8rem;">Buildable</span>
                                <strong class="text-white h5"><fmt:formatNumber value="${plan.buildableArea}" maxFractionDigits="0"/> sqft</strong>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-3">
                            <div class="p-3 bg-dark rounded-3 text-center border border-secondary border-opacity-10">
                                <span class="text-white-50 d-block mb-1" style="font-size: 0.8rem;">Open Space</span>
                                <strong class="text-white h5"><fmt:formatNumber value="${plan.openArea}" maxFractionDigits="0"/> sqft</strong>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-3">
                            <div class="p-3 bg-dark rounded-3 text-center border border-secondary border-opacity-10">
                                <span class="text-white-50 d-block mb-1" style="font-size: 0.8rem;">Garden/Park</span>
                                <strong class="text-white h5"><fmt:formatNumber value="${plan.gardenArea + plan.parkingArea}" maxFractionDigits="0"/> sqft</strong>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        
            <div class="col-xl-4">
                
                
                <div class="glass-card p-4 mb-4">
                    <h5 style="color: #fff; font-weight: 700;" class="mb-3"><i class="fas fa-table-cells text-warning me-2"></i> Room Layout Breakdown</h5>
                    <div class="table-responsive">
                        <table class="table premium-table mb-0 align-middle">
                            <thead>
                                <tr>
                                    <th>Floor</th>
                                    <th>Room Name</th>
                                    <th class="text-end">Dimensions</th>
                                </tr>
                            </thead>
                            <tbody id="roomsTableBody">
                                <!-- Loaded dynamically via JS parsing -->
                            </tbody>
                        </table>
                    </div>
                </div>

            
                <div class="glass-card p-4 mb-4">
                    <h5 style="color: #fff; font-weight: 700;" class="mb-3"><i class="fas fa-indian-rupee-sign text-warning me-2"></i> Estimated Cost Breakdown</h5>
                    
                    <div class="mb-4 d-flex justify-content-center">
                        <div style="width: 200px; height: 200px;">
                            <canvas id="costChart"></canvas>
                        </div>
                    </div>

                    <div class="mb-3">
                        <div class="breakdown-list-item">
                            <span class="breakdown-label"><i class="fas fa-layer-group text-warning" style="width: 14px;"></i> Foundation:</span>
                            <strong class="text-white">Rs. <fmt:formatNumber value="${cost.foundationCost}" type="number" maxFractionDigits="0"/></strong>
                        </div>
                        <div class="breakdown-list-item">
                            <span class="breakdown-label"><i class="fas fa-trowel-bricks text-warning" style="width: 14px;"></i> Structure (Walls):</span>
                            <strong class="text-white">Rs. <fmt:formatNumber value="${cost.wallCost}" type="number" maxFractionDigits="0"/></strong>
                        </div>
                        <div class="breakdown-list-item">
                            <span class="breakdown-label"><i class="fas fa-cubes text-warning" style="width: 14px;"></i> Slab (Roofing):</span>
                            <strong class="text-white">Rs. <fmt:formatNumber value="${cost.roofCost}" type="number" maxFractionDigits="0"/></strong>
                        </div>
                        <div class="breakdown-list-item">
                            <span class="breakdown-label"><i class="fas fa-bolt text-warning" style="width: 14px;"></i> Electrical:</span>
                            <strong class="text-white">Rs. <fmt:formatNumber value="${cost.electricalCost}" type="number" maxFractionDigits="0"/></strong>
                        </div>
                        <div class="breakdown-list-item">
                            <span class="breakdown-label"><i class="fas fa-faucet text-warning" style="width: 14px;"></i> Plumbing:</span>
                            <strong class="text-white">Rs. <fmt:formatNumber value="${cost.plumbingCost}" type="number" maxFractionDigits="0"/></strong>
                        </div>
                        <div class="breakdown-list-item">
                            <span class="breakdown-label"><i class="fas fa-border-all text-warning" style="width: 14px;"></i> Flooring:</span>
                            <strong class="text-white">Rs. <fmt:formatNumber value="${cost.flooringCost}" type="number" maxFractionDigits="0"/></strong>
                        </div>
                        <div class="breakdown-list-item">
                            <span class="breakdown-label"><i class="fas fa-brush text-warning" style="width: 14px;"></i> Painting:</span>
                            <strong class="text-white">Rs. <fmt:formatNumber value="${cost.paintingCost}" type="number" maxFractionDigits="0"/></strong>
                        </div>
                        <div class="breakdown-list-item">
                            <span class="breakdown-label"><i class="fas fa-chair text-warning" style="width: 14px;"></i> Interiors:</span>
                            <strong class="text-white">Rs. <fmt:formatNumber value="${cost.interiorCost}" type="number" maxFractionDigits="0"/></strong>
                        </div>
                        <div class="breakdown-list-item">
                            <span class="breakdown-label"><i class="fas fa-users text-warning" style="width: 14px;"></i> Labor & wages:</span>
                            <strong class="text-white">Rs. <fmt:formatNumber value="${cost.laborCost}" type="number" maxFractionDigits="0"/></strong>
                        </div>
                    </div>

                    <div class="p-3 bg-warning bg-opacity-10 text-warning rounded-3 d-flex justify-content-between align-items-center">
                        <strong style="font-size: 0.9rem;">TOTAL ESTIMATED COST:</strong>
                        <strong class="h5 mb-0">Rs. <fmt:formatNumber value="${cost.totalCost}" type="number" maxFractionDigits="0"/></strong>
                    </div>
                </div>

               
                <div class="glass-card p-4">
                    <h5 style="color: #fff; font-weight: 700;" class="mb-3"><i class="fas fa-helmet-safety text-warning me-2"></i> Materials Quantity Suggestions</h5>
                    
                    <div class="mb-3">
                        <div class="breakdown-list-item">
                            <span class="breakdown-label"><i class="fas fa-sack-concrete text-warning-emphasis"></i> Cement Bags:</span>
                            <strong class="text-white">${material.cementBags} bags</strong>
                        </div>
                        <div class="breakdown-list-item">
                            <span class="breakdown-label"><i class="fas fa-bars-staggered text-warning-emphasis"></i> Steel Reinforcement:</span>
                            <strong class="text-white"><fmt:formatNumber value="${material.steelKg}" maxFractionDigits="0"/> kg</strong>
                        </div>
                        <div class="breakdown-list-item">
                            <span class="breakdown-label"><i class="fas fa-cubes-stacked text-warning-emphasis"></i> Bricks/Blocks:</span>
                            <strong class="text-white">${material.bricksPcs} pcs</strong>
                        </div>
                        <div class="breakdown-list-item">
                            <span class="breakdown-label"><i class="fas fa-mountain text-warning-emphasis"></i> Fine Sand:</span>
                            <strong class="text-white"><fmt:formatNumber value="${material.sandCft}" maxFractionDigits="0"/> cft</strong>
                        </div>
                        <div class="breakdown-list-item">
                            <span class="breakdown-label"><i class="fas fa-circle-nodes text-warning-emphasis"></i> Aggregate:</span>
                            <strong class="text-white"><fmt:formatNumber value="${material.aggregateCft}" maxFractionDigits="0"/> cft</strong>
                        </div>
                        <div class="breakdown-list-item">
                            <span class="breakdown-label"><i class="fas fa-fill-drip text-warning-emphasis"></i> Paint:</span>
                            <strong class="text-white"><fmt:formatNumber value="${material.paintLiters}" maxFractionDigits="0"/> Liters</strong>
                        </div>
                        <div class="breakdown-list-item">
                            <span class="breakdown-label"><i class="fas fa-grip text-warning-emphasis"></i> Floor Tiles:</span>
                            <strong class="text-white"><fmt:formatNumber value="${material.tilesSqft}" maxFractionDigits="0"/> sq ft</strong>
                        </div>
                    </div>
                </div>

            </div>

        </div>

        <!-- Professional Engineering Disclaimer -->
        <div class="disclaimer-box mt-5">
            <h6 style="font-weight: 700; color: #fff;" class="mb-2"><i class="fas fa-circle-exclamation text-danger me-2"></i> PROFESSIONAL ARCHITECTURAL DISCLAIMER</h6>
            <p class="mb-0">
                The floor designs, room coordinates, architectural estimations, material lists, and structural budgets generated by this AI Smart House Planner are conceptual calculations only. They are intended for initial references and plan visualizations. This analysis is not a structural blueprint and does not replace site assessments by licensed engineers. Before initiating construction, structural columns, foundation loads, soil compaction, and site limits must be verified, signed, and stamped by a licensed architect and structural engineer in your region. A K Construction holds no liabilities for construction built on these conceptual models.
            </p>
        </div>

    </div>

    <!-- Script Block for Three.js 3D Rendering & Chart.js -->
    <script>
        // Data passed from controller to JS
        const floorsObj = JSON.parse('${plan.floorDetails}');
        const dimensionsObj = JSON.parse('${plan.roomDimensions}');
        const isApproved = ${plan.approved};
        const plotWidth = parseFloat("${property.width}");
        const plotLength = parseFloat("${property.length}");
        const numFloors = parseInt("${property.floors}");

        // Unified architectural layout calculation engine (contiguous grids, no overlaps)
        function calculateLayout(W_plot, L_plot, floorsObj, dimensionsObj) {
            const W_house = W_plot * 0.83;  // 83% buildable width
            const L_house = L_plot * 0.83;  // 83% buildable length
            
            const W_left = W_house * 0.45;
            const W_right = W_house * 0.55;
            
            const L_front = L_house * 0.35;
            const L_middle = L_house * 0.30;
            const L_back = L_house * 0.35;
            
            const roomsList = [];
            
            const cx_left = -W_house/2 + W_left/2;
            const cx_right = -W_house/2 + W_left + W_right/2;
            
            const cz_front = -L_house/2 + L_front/2;
            const cz_middle = -L_house/2 + L_front + L_middle/2;
            const cz_back = -L_house/2 + L_front + L_middle + L_back/2;
            
            const groundRooms = floorsObj["Ground Floor"] || [];
            const firstRooms = floorsObj["First Floor"] || [];
            const secondRooms = floorsObj["Second Floor"] || [];
            
            const hasGuestBath = groundRooms.includes("Guest Bathroom");
            const hasGuestBed = groundRooms.includes("Guest Bedroom");
            const hasOffice = firstRooms.includes("Office Room");
            const hasChildrenBed = firstRooms.includes("Children Bedroom");
            const hasMasterBath = firstRooms.includes("Master Bathroom");
            const hasRooftopPool = secondRooms.includes("Rooftop Pool");
            const hasStore = secondRooms.includes("Store Room");
            
            // GROUND FLOOR
            groundRooms.forEach(room => {
                if (room === "Kitchen") {
                    roomsList.push({ name: room, floor: "Ground Floor", x: cx_left, z: cz_front, w: W_left, l: L_front });
                } else if (room === "Dining Area") {
                    roomsList.push({ name: room, floor: "Ground Floor", x: cx_left, z: cz_middle, w: W_left, l: L_middle });
                } else if (room === "Staircase") {
                    if (hasGuestBath) {
                        roomsList.push({ name: room, floor: "Ground Floor", x: cx_left - W_left * 0.2, z: cz_back, w: W_left * 0.6, l: L_back });
                    } else {
                        roomsList.push({ name: room, floor: "Ground Floor", x: cx_left, z: cz_back, w: W_left, l: L_back });
                    }
                } else if (room === "Guest Bathroom") {
                    roomsList.push({ name: room, floor: "Ground Floor", x: cx_left + W_left * 0.3, z: cz_back, w: W_left * 0.4, l: L_back });
                } else if (room === "Living Room") {
                    if (hasGuestBed) {
                        roomsList.push({ name: room, floor: "Ground Floor", x: cx_right, z: -L_house/2 + (L_front + L_middle)/2, w: W_right, l: L_front + L_middle });
                    } else {
                        roomsList.push({ name: room, floor: "Ground Floor", x: cx_right, z: 0, w: W_right, l: L_house });
                    }
                } else if (room === "Guest Bedroom") {
                    roomsList.push({ name: room, floor: "Ground Floor", x: cx_right, z: cz_back, w: W_right, l: L_back });
                } else if (room === "Parking") {
                    roomsList.push({ name: room, floor: "Ground Floor", x: -W_house/2 - 7, z: -L_house/2 + 9, w: 12, l: 18, isOutdoor: true });
                } else if (room === "Garden") {
                    roomsList.push({ name: room, floor: "Ground Floor", x: W_house/2 + 7, z: -L_house/2 + 7.5, w: 12, l: 15, isOutdoor: true });
                }
            });
            
            // FIRST FLOOR
            if (firstRooms.length > 0) {
                firstRooms.forEach(room => {
                    if (room === "Office Room") {
                        roomsList.push({ name: room, floor: "First Floor", x: cx_left, z: cz_front, w: W_left, l: L_front });
                    } else if (room === "Children Bedroom") {
                        if (hasOffice) {
                            roomsList.push({ name: room, floor: "First Floor", x: cx_left, z: cz_middle, w: W_left, l: L_middle });
                        } else {
                            roomsList.push({ name: room, floor: "First Floor", x: cx_left, z: -L_house/2 + (L_front + L_middle)/2, w: W_left, l: L_front + L_middle });
                        }
                    } else if (room === "Master Bathroom") {
                        roomsList.push({ name: room, floor: "First Floor", x: cx_left, z: cz_back, w: W_left, l: L_back });
                    } else if (room === "Family Lounge") {
                        roomsList.push({ name: room, floor: "First Floor", x: cx_right, z: cz_front, w: W_right, l: L_front });
                    } else if (room === "Master Bedroom") {
                        roomsList.push({ name: room, floor: "First Floor", x: cx_right, z: -L_house/2 + L_front + (L_middle + L_back)/2, w: W_right, l: L_middle + L_back });
                    } else if (room === "Balcony") {
                        roomsList.push({ name: room, floor: "First Floor", x: 0, z: -L_house/2 - 1.25, w: W_house * 0.8, l: 2.5, isOutdoor: true });
                    }
                });
            }
            
            // SECOND FLOOR
            if (secondRooms.length > 0) {
                secondRooms.forEach(room => {
                    if (room === "Rooftop Pool") {
                        roomsList.push({ name: room, floor: "Second Floor", x: cx_left, z: -L_house/2 + (L_front + L_middle)/2, w: W_left, l: L_front + L_middle });
                    } else if (room === "Utility Area") {
                        if (hasStore) {
                            roomsList.push({ name: room, floor: "Second Floor", x: cx_left - W_left * 0.25, z: cz_back, w: W_left * 0.5, l: L_back });
                        } else {
                            roomsList.push({ name: room, floor: "Second Floor", x: cx_left, z: cz_back, w: W_left, l: L_back });
                        }
                    } else if (room === "Store Room") {
                        roomsList.push({ name: room, floor: "Second Floor", x: cx_left + W_left * 0.25, z: cz_back, w: W_left * 0.5, l: L_back });
                    } else if (room === "Terrace") {
                        if (hasRooftopPool) {
                            roomsList.push({ name: room, floor: "Second Floor", x: cx_right, z: 0, w: W_right, l: L_house, isOutdoor: true });
                        } else {
                            roomsList.push({ name: room, floor: "Second Floor", x: cx_right, z: 0, w: W_right, l: L_house, isOutdoor: true });
                            roomsList.push({ name: room + " (Left Side)", floor: "Second Floor", x: cx_left, z: -L_house/2 + (L_front + L_middle)/2, w: W_left, l: L_front + L_middle, isOutdoor: true });
                        }
                    }
                });
            }
            
            return { W_house, L_house, W_left, W_right, L_front, L_middle, L_back, roomsList };
        }

        const layout = calculateLayout(plotWidth, plotLength, floorsObj, dimensionsObj);
        const W_house = layout.W_house;
        const L_house = layout.L_house;
        const W_left = layout.W_left;
        const W_right = layout.W_right;
        const L_front = layout.L_front;
        const L_middle = layout.L_middle;
        const L_back = layout.L_back;
        const roomsList = layout.roomsList;

        const hasGuestBath = (floorsObj["Ground Floor"] || []).includes("Guest Bathroom");
        const hasGuestBed = (floorsObj["Ground Floor"] || []).includes("Guest Bedroom");
        const hasOffice = (floorsObj["First Floor"] || []).includes("Office Room");
        const hasStore = (floorsObj["Second Floor"] || []).includes("Store Room");

        // Render approved/pending badge on header
        const headerBadgeContainer = document.getElementById("architect-approval-container");
        if (isApproved) {
            headerBadgeContainer.innerHTML += `
                <span id="architect-approved-badge" class="badge bg-success text-white px-3 py-2 rounded-pill font-weight-bold" style="font-size: 0.85rem;">
                    <i class="fas fa-circle-check me-1"></i> APPROVED BY ARCHITECT
                </span>`;
        } else {
            headerBadgeContainer.innerHTML += `
                <span class="badge bg-warning text-dark px-3 py-2 rounded-pill font-weight-bold" style="font-size: 0.85rem;">
                    <i class="fas fa-clock me-1"></i> PENDING ARCHITECT APPROVAL
                </span>`;
        }

        
        const tableBody = document.getElementById("roomsTableBody");
        for (const [floor, rooms] of Object.entries(floorsObj)) {
            rooms.forEach(room => {
                let dim = dimensionsObj[room] || "As required";
                tableBody.innerHTML += `
                    <tr>
                        <td class="text-white-50" style="font-size:0.85rem;">${floor}</td>
                        <td style="font-weight: 600;">${room}</td>
                        <td class="text-end text-warning" style="font-weight: 700;">${dim} ft</td>
                    </tr>`;
            });
        }

        // Render Cost Breakdown Chart (Doughnut)
        const costCtx = document.getElementById('costChart').getContext('2d');
        new Chart(costCtx, {
            type: 'doughnut',
            data: {
                labels: ['Foundation', 'Structure', 'Slab', 'Electrical', 'Plumbing', 'Flooring', 'Painting', 'Interiors', 'Labor'],
                datasets: [{
                    data: [
                        ${cost.foundationCost},
                        ${cost.wallCost},
                        ${cost.roofCost},
                        ${cost.electricalCost},
                        ${cost.plumbingCost},
                        ${cost.flooringCost},
                        ${cost.paintingCost},
                        ${cost.interiorCost},
                        ${cost.laborCost}
                    ],
                    backgroundColor: [
                        '#e67e22', '#3498db', '#9b59b6', '#f1c40f',
                        '#1abc9c', '#2ecc71', '#95a5a6', '#e74c3c', '#34495e'
                    ],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                cutout: '70%'
            }
        });

        // ==========================================
        // 2D Canvas Blueprint Rendering System
        // ==========================================
        let canvas2D, ctx;
        let zoom = 1.0;
        let panX = 0;
        let panY = 0;
        let isDragging = false;
        let startDragX = 0;
        let startDragY = 0;

        function init2D() {
            canvas2D = document.getElementById("canvas-2d");
            ctx = canvas2D.getContext("2d");
            
            const container = document.getElementById("canvas-container");
            canvas2D.width = container.clientWidth;
            canvas2D.height = container.clientHeight;
            
            canvas2D.addEventListener('mousedown', startDrag);
            canvas2D.addEventListener('mousemove', drag);
            window.addEventListener('mouseup', endDrag);
            canvas2D.addEventListener('wheel', mouseWheelZoom);
            
            reset2DView();
        }

        function reset2DView() {
            zoom = Math.min(canvas2D.width / (W_house * 1.5), canvas2D.height / (L_house * 1.5));
            if (isNaN(zoom) || zoom <= 0) zoom = 8;
            panX = canvas2D.width / 2;
            panY = canvas2D.height / 2;
            draw2D();
        }

        function zoom2D(factor) {
            zoom *= factor;
            zoom = Math.max(1, Math.min(100, zoom));
            draw2D();
        }

        function startDrag(e) {
            isDragging = true;
            startDragX = e.clientX - panX;
            startDragY = e.clientY - panY;
            canvas2D.style.cursor = "grabbing";
        }

        function endDrag() {
            isDragging = false;
            if (canvas2D) canvas2D.style.cursor = "grab";
        }

        function drag(e) {
            const rect = canvas2D.getBoundingClientRect();
            const mouseX = e.clientX - rect.left;
            const mouseY = e.clientY - rect.top;
            
            const xFeet = (mouseX - panX) / zoom;
            const zFeet = (mouseY - panY) / zoom;
            
            const selectedFloor = document.getElementById("floorSelect").value;
            let hoveredRoom = null;
            
            const activeRooms = roomsList.filter(r => r.floor === selectedFloor);
            for (const r of activeRooms) {
                if (xFeet >= r.x - r.w/2 && xFeet <= r.x + r.w/2 &&
                    zFeet >= r.z - r.l/2 && zFeet <= r.z + r.l/2) {
                    hoveredRoom = r;
                    break;
                }
            }
            
            const hoverCard = document.getElementById("hover-card");
            if (hoveredRoom) {
                document.getElementById("hover-room-name").innerText = hoveredRoom.name;
                let desc = `<strong>Dimensions:</strong> ${Math.round(hoveredRoom.w)}' × ${Math.round(hoveredRoom.l)}' (${Math.round(hoveredRoom.w * hoveredRoom.l)} sq ft)<br>`;
                
                if (hoveredRoom.name.includes("Kitchen")) {
                    desc += "Agni corner (South-East). Ideal placement for safety, natural light, and clean utility pipelines.";
                } else if (hoveredRoom.name.includes("Living")) {
                    desc += "Grand central hallway layout with large double windows for maximum daylighting and aesthetic warmth.";
                } else if (hoveredRoom.name.includes("Bedroom")) {
                    desc += "Spacious suite containing integrated slots for heavy beds and wardrobes.";
                } else if (hoveredRoom.name.includes("Staircase")) {
                    desc += "Reinforced concrete steps leading upward. Space-saving configuration.";
                } else if (hoveredRoom.name.includes("Bathroom")) {
                    desc += "Ensuite bathroom featuring fully lined moisture barriers and standard plumbing fixtures.";
                } else if (hoveredRoom.name.includes("Pool")) {
                    desc += "Rooftop infinity pool with reinforced safety concrete framing.";
                } else if (hoveredRoom.name.includes("Terrace")) {
                    desc += "Expansive open sky deck. Ideal for landscaping, utility, or recreation.";
                } else {
                    desc += "Conceptual architectural allocation.";
                }
                
                document.getElementById("hover-room-desc").innerHTML = desc;
                hoverCard.style.left = (mouseX + 15) + "px";
                hoverCard.style.top = (mouseY + 15) + "px";
                hoverCard.style.display = "block";
                canvas2D.style.cursor = "pointer";
            } else {
                hoverCard.style.display = "none";
                canvas2D.style.cursor = isDragging ? "grabbing" : "grab";
            }

            if (isDragging) {
                panX = e.clientX - startDragX;
                panY = e.clientY - startDragY;
                draw2D();
            }
        }

        function mouseWheelZoom(e) {
            e.preventDefault();
            const zoomFactor = 1.1;
            const rect = canvas2D.getBoundingClientRect();
            const mouseX = e.clientX - rect.left;
            const mouseY = e.clientY - rect.top;
            
            const xFeet = (mouseX - panX) / zoom;
            const zFeet = (mouseY - panY) / zoom;
            
            if (e.deltaY < 0) {
                zoom *= zoomFactor;
            } else {
                zoom /= zoomFactor;
            }
            zoom = Math.max(1, Math.min(100, zoom));
            
            panX = mouseX - xFeet * zoom;
            panY = mouseY - zFeet * zoom;
            draw2D();
        }

        function draw2D() {
            const selectedFloor = document.getElementById("floorSelect").value;
            ctx.fillStyle = "#12121e";
            ctx.fillRect(0, 0, canvas2D.width, canvas2D.height);
            
            // Grid Background
            ctx.strokeStyle = "rgba(255, 255, 255, 0.05)";
            ctx.lineWidth = 0.5;
            const gridSizeFeet = 5;
            const gridSizePixels = gridSizeFeet * zoom;
            const startX = panX % gridSizePixels;
            const startY = panY % gridSizePixels;
            
            for (let x = startX; x < canvas2D.width; x += gridSizePixels) {
                ctx.beginPath(); ctx.moveTo(x, 0); ctx.lineTo(x, canvas2D.height); ctx.stroke();
            }
            for (let y = startY; y < canvas2D.height; y += gridSizePixels) {
                ctx.beginPath(); ctx.moveTo(0, y); ctx.lineTo(canvas2D.width, y); ctx.stroke();
            }
            
            ctx.save();
            ctx.translate(panX, panY);
            ctx.scale(zoom, zoom);
            
            const activeRooms = roomsList.filter(r => r.floor === selectedFloor);
            
            // 1. Draw Outdoor / Balconies
            activeRooms.filter(r => r.isOutdoor).forEach(room => {
                ctx.fillStyle = room.name.includes("Garden") ? "rgba(46, 204, 113, 0.15)" : 
                                room.name.includes("Parking") ? "rgba(127, 140, 141, 0.2)" : 
                                "rgba(244, 196, 48, 0.1)";
                ctx.strokeStyle = room.name.includes("Garden") ? "#2ecc71" : "#7f8c8d";
                ctx.lineWidth = 0.1;
                ctx.setLineDash([0.3, 0.3]);
                ctx.fillRect(room.x - room.w/2, room.z - room.l/2, room.w, room.l);
                ctx.strokeRect(room.x - room.w/2, room.z - room.l/2, room.w, room.l);
                ctx.setLineDash([]);
            });
            
            // 2. Draw Rooms Slabs
            activeRooms.filter(r => !r.isOutdoor).forEach(room => {
                let col = "rgba(45, 52, 54, 0.3)";
                if (room.name.includes("Living")) col = "rgba(215, 204, 200, 0.2)";
                else if (room.name.includes("Kitchen")) col = "rgba(149, 175, 192, 0.2)";
                else if (room.name.includes("Bedroom")) col = "rgba(255, 236, 179, 0.2)";
                else if (room.name.includes("Bathroom")) col = "rgba(189, 195, 199, 0.25)";
                else if (room.name.includes("Staircase")) col = "rgba(127, 140, 141, 0.15)";
                else if (room.name.includes("Pool")) col = "rgba(52, 152, 219, 0.25)";
                
                ctx.fillStyle = col;
                ctx.fillRect(room.x - room.w/2, room.z - room.l/2, room.w, room.l);
                
                ctx.strokeStyle = "rgba(255, 255, 255, 0.1)";
                ctx.lineWidth = 0.05;
                ctx.strokeRect(room.x - room.w/2, room.z - room.l/2, room.w, room.l);
            });
            
            // 3. Draw Room Furniture details
            activeRooms.forEach(room => {
                const rx = room.x; const rz = room.z;
                const rw = room.w; const rl = room.l;
                ctx.strokeStyle = "rgba(255, 255, 255, 0.18)";
                ctx.fillStyle = "rgba(255, 255, 255, 0.03)";
                ctx.lineWidth = 0.1;
                
                if (room.name.includes("Bedroom")) {
                    ctx.strokeRect(rx - 2.5, rz - rl/4, 5, 5.5);
                    ctx.fillRect(rx - 2.5, rz - rl/4, 5, 5.5);
                    ctx.strokeRect(rx - 2.2, rz - rl/4 + 0.3, 1.8, 1.0);
                    ctx.strokeRect(rx + 0.4, rz - rl/4 + 0.3, 1.8, 1.0);
                } else if (room.name.includes("Living")) {
                    ctx.beginPath();
                    ctx.moveTo(rx - rw/2.5, rz + rl/4 - 1.2);
                    ctx.lineTo(rx + rw/2.5, rz + rl/4 - 1.2);
                    ctx.lineTo(rx + rw/2.5, rz - rl/8);
                    ctx.lineTo(rx + rw/3.5, rz - rl/8);
                    ctx.lineTo(rx + rw/3.5, rz + rl/4 - 2.0);
                    ctx.lineTo(rx - rw/2.5, rz + rl/4 - 2.0);
                    ctx.closePath(); ctx.stroke(); ctx.fill();
                    ctx.strokeRect(rx - 1.5, rz - 0.75, 3.0, 1.5);
                } else if (room.name.includes("Dining")) {
                    ctx.strokeRect(rx - 2.5, rz - 1.5, 5.0, 3.0);
                    for (let i = -1.8; i <= 1.8; i += 1.8) {
                        ctx.beginPath(); ctx.arc(rx + i, rz - 1.9, 0.4, 0, Math.PI * 2); ctx.stroke();
                        ctx.beginPath(); ctx.arc(rx + i, rz + 1.9, 0.4, 0, Math.PI * 2); ctx.stroke();
                    }
                } else if (room.name.includes("Kitchen")) {
                    ctx.beginPath();
                    ctx.moveTo(rx - rw/2, rz + rl/2); ctx.lineTo(rx - rw/2 + 2, rz + rl/2);
                    ctx.lineTo(rx - rw/2 + 2, rz - rl/2 + 2); ctx.lineTo(rx + rw/2, rz - rl/2 + 2);
                    ctx.lineTo(rx + rw/2, rz - rl/2); ctx.lineTo(rx - rw/2, rz - rl/2);
                    ctx.closePath(); ctx.stroke(); ctx.fill();
                    ctx.beginPath(); ctx.arc(rx + rw/4, rz - rl/2 + 1, 0.4, 0, Math.PI * 2); ctx.stroke();
                } else if (room.name.includes("Bathroom")) {
                    ctx.strokeRect(rx + rw/2 - 4.2, rz - rl/2, 4.2, 2.0);
                    ctx.beginPath(); ctx.arc(rx - rw/2 + 1.2, rz - rl/2 + 1.2, 0.4, 0, Math.PI * 2); ctx.stroke();
                    ctx.strokeRect(rx - rw/2 + 0.6, rz - rl/2 + 0.2, 1.2, 0.4);
                } else if (room.name.includes("Staircase")) {
                    const numSteps = 8;
                    const stepH = rl / numSteps;
                    for (let i = 0; i <= numSteps; i++) {
                        ctx.beginPath(); ctx.moveTo(rx - rw/2.2, rz - rl/2 + i * stepH); ctx.lineTo(rx + rw/2.2, rz - rl/2 + i * stepH); ctx.stroke();
                    }
                } else if (room.name.includes("Parking")) {
                    ctx.strokeRect(rx - 2.5, rz - 6, 5, 12);
                }
            });

            // 4. Draw Walls with Door Swings & Window lines
            ctx.strokeStyle = "#F4C430";
            ctx.fillStyle = "#F4C430";
            ctx.lineWidth = 0.35;
            
            if (selectedFloor === "Ground Floor") {
                drawWall2D(-W_house/2, -L_house/2, -W_house/2, L_house/2, [
                    { type: 'window', pos: (L_front/2) / L_house, size: 4.0 },
                    { type: 'window', pos: (L_front + L_middle/2) / L_house, size: 4.0 }
                ]);
                const rightOpenings = [{ type: 'window', pos: ((L_front + L_middle)/2) / L_house, size: 6.0 }];
                if (hasGuestBed) rightOpenings.push({ type: 'window', pos: (L_front + L_middle + L_back/2) / L_house, size: 4.0 });
                drawWall2D(W_house/2, -L_house/2, W_house/2, L_house/2, rightOpenings);
                
                drawWall2D(-W_house/2, -L_house/2, W_house/2, -L_house/2, [
                    { type: 'window', pos: (W_left/2) / W_house, size: 4.0 },
                    { type: 'door', pos: (W_left + W_right/2) / W_house, size: 3.5 }
                ]);
                const backOpenings = [];
                if (hasGuestBed) backOpenings.push({ type: 'window', pos: (W_left + W_right/2) / W_house, size: 4.0 });
                drawWall2D(-W_house/2, L_house/2, W_house/2, L_house/2, backOpenings);
                
                drawWall2D(-W_house/2 + W_left, -L_house/2, -W_house/2 + W_left, L_house/2, [
                    { type: 'door', pos: (L_front * 0.7) / L_house, size: 3.0 },
                    { type: 'door', pos: (L_front + L_middle/2) / L_house, size: 8.0 }
                ]);
                drawWall2D(-W_house/2, -L_house/2 + L_front, -W_house/2 + W_left, -L_house/2 + L_front, [{ type: 'door', pos: 0.5, size: 3.0 }]);
                drawWall2D(-W_house/2, -L_house/2 + L_front + L_middle, W_house/2, -L_house/2 + L_front + L_middle, [
                    { type: 'door', pos: (W_left * 0.3) / W_house, size: 3.0 },
                    { type: 'door', pos: (W_left * 0.8) / W_house, size: 3.0 },
                    { type: 'door', pos: (W_left + W_right/2) / W_house, size: 3.0 }
                ]);
                if (hasGuestBath) drawWall2D(-W_house/2 + W_left * 0.6, -L_house/2 + L_front + L_middle, -W_house/2 + W_left * 0.6, L_house/2, []);
            } 
            else if (selectedFloor === "First Floor") {
                drawWall2D(-W_house/2, -L_house/2, -W_house/2, L_house/2, [
                    { type: 'window', pos: (L_front/2) / L_house, size: 4.0 },
                    { type: 'window', pos: (L_front + L_middle/2) / L_house, size: 4.0 }
                ]);
                drawWall2D(W_house/2, -L_house/2, W_house/2, L_house/2, [{ type: 'window', pos: (L_front + L_middle + L_back/2) / L_house, size: 5.0 }]);
                drawWall2D(-W_house/2, -L_house/2, W_house/2, -L_house/2, [{ type: 'door', pos: 0.5, size: 8.0 }]);
                drawWall2D(-W_house/2, L_house/2, W_house/2, L_house/2, [{ type: 'window', pos: (W_left/2) / W_house, size: 3.0 }]);
                drawWall2D(-W_house/2 + W_left, -L_house/2, -W_house/2 + W_left, L_house/2, [
                    { type: 'door', pos: (L_front * 0.5) / L_house, size: 3.0 },
                    { type: 'door', pos: (L_front + L_middle/2) / L_house, size: 3.0 }
                ]);
                if (hasOffice) drawWall2D(-W_house/2, -L_house/2 + L_front, -W_house/2 + W_left, -L_house/2 + L_front, [{ type: 'door', pos: 0.5, size: 3.0 }]);
                drawWall2D(-W_house/2, -L_house/2 + L_front + L_middle, W_house/2, -L_house/2 + L_front + L_middle, [
                    { type: 'door', pos: (W_left * 0.5) / W_house, size: 3.0 },
                    { type: 'door', pos: (W_left + W_right/2) / W_house, size: 3.0 }
                ]);
            } 
            else if (selectedFloor === "Second Floor") {
                drawWall2D(-W_house/2, -L_house/2, -W_house/2, L_house/2, [{ type: 'window', pos: (L_front + L_middle + L_back/2) / L_house, size: 3.0 }]);
                drawWall2D(-W_house/2 + W_left, -L_house/2, -W_house/2 + W_left, L_house/2, [
                    { type: 'door', pos: (L_front + L_middle/2) / L_house, size: 6.0 },
                    { type: 'door', pos: (L_front + L_middle + L_back/2) / L_house, size: 3.0 }
                ]);
                drawWall2D(-W_house/2, -L_house/2 + L_front + L_middle, -W_house/2 + W_left, -L_house/2 + L_front + L_middle, [{ type: 'door', pos: 0.5, size: 3.0 }]);
                if (hasStore) drawWall2D(-W_house/2 + W_left * 0.5, -L_house/2 + L_front + L_middle, -W_house/2 + W_left * 0.5, L_house/2, []);
            }

            // 5. Labels
            ctx.fillStyle = "#ffffff";
            ctx.textAlign = "center";
            ctx.textBaseline = "middle";
            activeRooms.forEach(room => {
                ctx.font = `bold ${Math.max(12 / zoom, 1.2)}px Inter, sans-serif`;
                ctx.fillText(room.name, room.x, room.z - 0.4);
                
                ctx.font = `${Math.max(9 / zoom, 0.9)}px Inter, sans-serif`;
                ctx.fillStyle = "rgba(255,255,255,0.6)";
                ctx.fillText(`${Math.round(room.w)}' × ${Math.round(room.l)}'`, room.x, room.z + 0.6);
                ctx.fillStyle = "#ffffff";
            });
            
            ctx.restore();
        }

        function drawWall2D(startX, startZ, endX, endZ, openings) {
            const dx = endX - startX; const dz = endZ - startZ;
            const len = Math.sqrt(dx * dx + dz * dz);
            const angle = Math.atan2(dz, dx);
            
            openings = openings || [];
            openings.sort((a, b) => a.pos - b.pos);
            let curL = 0;
            
            openings.forEach(op => {
                const opPos = op.pos * len; const opW = op.size;
                const segL = (opPos - opW/2) - curL;
                if (segL > 0.05) {
                    drawSolidWallSegment2D(startX, startZ, curL, segL, angle);
                }
                
                const openX = startX + Math.cos(angle) * opPos;
                const openZ = startZ + Math.sin(angle) * opPos;
                
                if (op.type === 'door') {
                    ctx.save(); ctx.translate(openX, openZ); ctx.rotate(angle);
                    ctx.strokeStyle = "rgba(244, 196, 48, 0.85)";
                    ctx.lineWidth = 0.15;
                    ctx.beginPath(); ctx.moveTo(-opW/2, 0); ctx.lineTo(-opW/2, -opW); ctx.stroke();
                    ctx.strokeStyle = "rgba(244, 196, 48, 0.35)";
                    ctx.setLineDash([0.15, 0.15]);
                    ctx.beginPath(); ctx.arc(-opW/2, 0, opW, 0, -Math.PI / 2, true); ctx.stroke();
                    ctx.restore();
                } else if (op.type === 'window') {
                    ctx.save(); ctx.translate(openX, openZ); ctx.rotate(angle);
                    ctx.fillStyle = "rgba(52, 152, 219, 0.3)";
                    ctx.strokeStyle = "#52b3d9";
                    ctx.lineWidth = 0.1;
                    ctx.fillRect(-opW/2, -0.2, opW, 0.4);
                    ctx.strokeRect(-opW/2, -0.2, opW, 0.4);
                    ctx.beginPath();
                    ctx.moveTo(-opW/2, -0.05); ctx.lineTo(opW/2, -0.05);
                    ctx.moveTo(-opW/2, 0.05); ctx.lineTo(opW/2, 0.05);
                    ctx.stroke();
                    ctx.restore();
                }
                curL = opPos + opW/2;
            });
            
            const lastL = len - curL;
            if (lastL > 0.05) {
                drawSolidWallSegment2D(startX, startZ, curL, lastL, angle);
            }
        }

        function drawSolidWallSegment2D(startX, startZ, offsetL, length, angle) {
            const p1X = startX + Math.cos(angle) * offsetL; const p1Z = startZ + Math.sin(angle) * offsetL;
            const p2X = p1X + Math.cos(angle) * length; const p2Z = p1Z + Math.sin(angle) * length;
            ctx.strokeStyle = "#F4C430";
            ctx.lineWidth = 0.35;
            ctx.beginPath(); ctx.moveTo(p1X, p1Z); ctx.lineTo(p2X, p2Z); ctx.stroke();
        }

        // ==========================================
        // Three.js 3D House Rendering System
        // ==========================================
        let scene, camera, renderer, controls;
        let roofGroup = new THREE.Group();
        let houseGroup = new THREE.Group();
        let showRoof = true;
        let walkthrough = false;
        let moveForward = false, moveBackward = false, moveLeft = false, moveRight = false;
        let walkSpeed = 0.5;
        
        let ambientLight, sunLight;
        let roomLights = [];
        let isNightMode = false;

        init3D();
        init2D(); // Fire up both renderers

        function init3D() {
            const container = document.getElementById("canvas-container");
            const width = container.clientWidth;
            const height = container.clientHeight;

            scene = new THREE.Scene();
            scene.background = new THREE.Color(0x111222);
            scene.fog = new THREE.FogExp2(0x111222, 0.012);

            camera = new THREE.PerspectiveCamera(45, width / height, 0.1, 1000);
            camera.position.set(35, 25, 45);

            renderer = new THREE.WebGLRenderer({ antialias: true, preserveDrawingBuffer: true });
            renderer.setSize(width, height);
            renderer.shadowMap.enabled = true;
            renderer.shadowMap.type = THREE.PCFSoftShadowMap;
            document.getElementById("view-3d").appendChild(renderer.domElement);

            controls = new THREE.OrbitControls(camera, renderer.domElement);
            controls.enableDamping = true;
            controls.dampingFactor = 0.05;
            controls.maxPolarAngle = Math.PI / 2 - 0.05;

            // Lights
            ambientLight = new THREE.AmbientLight(0xffffff, 0.6);
            scene.add(ambientLight);

            sunLight = new THREE.DirectionalLight(0xfffaed, 0.8);
            sunLight.position.set(40, 60, 20);
            sunLight.castShadow = true;
            sunLight.shadow.mapSize.width = 1024;
            sunLight.shadow.mapSize.height = 1024;
            scene.add(sunLight);

            // Ground Plane
            const groundGeo = new THREE.PlaneGeometry(120, 120);
            const groundMat = new THREE.MeshStandardMaterial({ color: 0x1e1e2d, roughness: 0.8 });
            const ground = new THREE.Mesh(groundGeo, groundMat);
            ground.rotation.x = -Math.PI / 2;
            ground.receiveShadow = true;
            scene.add(ground);

<<<<<<< HEAD
            const grid = new THREE.GridHelper(100, 100, 0xF4C430, 0x444455);
=======
            
            const grid = new THREE.GridHelper(80, 80, 0xF4C430, 0x444455);
>>>>>>> b27deffaf14836ddd4fcbd065f8479ee93ebea1e
            grid.position.y = 0.02;
            scene.add(grid);

            buildHouse();
            window.addEventListener('resize', onWindowResize);
            animate();
        }

        function buildHouse() {
            while(houseGroup.children.length > 0){
                houseGroup.remove(houseGroup.children[0]);
            }
            scene.add(houseGroup);
            houseGroup.add(roofGroup);

            const wallMaterial = new THREE.MeshStandardMaterial({ color: 0xeaeaea, roughness: 0.8 });
            const glassMaterial = new THREE.MeshStandardMaterial({ color: 0x88ccff, transparent: true, opacity: 0.5, roughness: 0.1 });
            const doorMaterial = new THREE.MeshStandardMaterial({ color: 0x6f4e37, roughness: 0.9 });
            const roofMaterial = new THREE.MeshStandardMaterial({ color: 0x96281b, roughness: 0.6 });

            roomsList.forEach(room => {
                let yOffset = 0;
                if (room.floor === "First Floor") yOffset = 8;
                else if (room.floor === "Second Floor") yOffset = 16;
                
                let floorColor = 0xdcdde1; let roughness = 0.6;
                if (room.name.includes("Living")) { floorColor = 0xd7ccc8; roughness = 0.4; }
                else if (room.name.includes("Kitchen")) { floorColor = 0x95a5a6; roughness = 0.2; }
                else if (room.name.includes("Bedroom") || room.name.includes("Office")) { floorColor = 0xffecb3; roughness = 0.8; }
                else if (room.name.includes("Bathroom")) { floorColor = 0xbdc3c7; roughness = 0.2; }
                else if (room.name.includes("Garden")) { floorColor = 0x2ecc71; roughness = 0.9; }
                else if (room.name.includes("Parking")) { floorColor = 0x34495e; roughness = 0.7; }
                else if (room.name.includes("Pool")) { floorColor = 0x2980b9; roughness = 0.1; }
                
                const scaleW = room.w * 0.5; const scaleL = room.l * 0.5;
                const floorGeo = new THREE.BoxGeometry(scaleW - 0.05, 0.1, scaleL - 0.05);
                let floorMat;
                if (room.name.includes("Pool")) {
                    floorMat = new THREE.MeshStandardMaterial({ color: 0x3498db, roughness: 0.1, transparent: true, opacity: 0.8 });
                } else {
                    floorMat = new THREE.MeshStandardMaterial({ color: floorColor, roughness: roughness });
                }
                
                const floorMesh = new THREE.Mesh(floorGeo, floorMat);
                floorMesh.position.set(room.x * 0.5, yOffset * 0.5 + 0.05, room.z * 0.5);
                floorMesh.receiveShadow = true;
                floorMesh.userData = { floor: room.floor };
                houseGroup.add(floorMesh);
                
                const rx = room.x * 0.5; const rz = room.z * 0.5;
                const rw = room.w * 0.5; const rl = room.l * 0.5;
                const yScale = yOffset * 0.5;
                
                if (room.name === "Living Room") {
                    buildSofa3D(rx, yScale, rz + rl/4, rw, rl, 0);
                    const coffeeTableGeo = new THREE.BoxGeometry(4.0 * 0.25, 1.0 * 0.25, 2.5 * 0.25);
                    const coffeeTableMat = new THREE.MeshStandardMaterial({ color: 0x2c3e50, roughness: 0.3 });
                    const coffeeTable = new THREE.Mesh(coffeeTableGeo, coffeeTableMat);
                    coffeeTable.position.set(rx, yScale + 0.5 * 0.25, rz);
                    coffeeTable.castShadow = true; coffeeTable.userData = { floor: room.floor };
                    houseGroup.add(coffeeTable);
                } else if (room.name === "Kitchen") {
                    buildKitchenCounter3D(rx, yScale, rz, rw, rl);
                } else if (room.name === "Dining Area") {
                    buildDiningTable3D(rx, yScale, rz, rw, rl);
                } else if (room.name === "Guest Bedroom" || room.name === "Master Bedroom" || room.name === "Children Bedroom") {
                    buildBed3D(rx, yScale, rz - rl/6, rw, rl, 0);
                } else if (room.name === "Guest Bathroom" || room.name === "Master Bathroom") {
                    buildBathroom3D(rx, yScale, rz, rw, rl);
                } else if (room.name === "Parking") {
                    buildCar3D(rx, yScale, rz, rw, rl);
                } else if (room.name === "Staircase") {
                    buildStaircase(rx, yScale, rz, rw, rl);
                } else if (room.name === "Office Room") {
                    const deskGeo = new THREE.BoxGeometry(4.0 * 0.25, 2.6 * 0.25, 2.0 * 0.25);
                    const deskMat = new THREE.MeshStandardMaterial({ color: 0x5c4033, roughness: 0.6 });
                    const desk = new THREE.Mesh(deskGeo, deskMat);
                    desk.position.set(rx, yScale + 1.3 * 0.25, rz - rl/4);
                    desk.castShadow = true; desk.userData = { floor: room.floor };
                    houseGroup.add(desk);
                }
            });

            const h = 4.0;
            buildWallsForLevel("Ground Floor", 0, h, wallMaterial, glassMaterial, doorMaterial);
            if (numFloors >= 2) buildWallsForLevel("First Floor", 8, h, wallMaterial, glassMaterial, doorMaterial);
            if (numFloors >= 3) buildWallsForLevel("Second Floor", 16, h, wallMaterial, glassMaterial, doorMaterial);

            let topHeight = 4.0;
            if (numFloors === 2) topHeight = 8.0;
            else if (numFloors === 3) topHeight = 12.0;
            
            while(roofGroup.children.length > 0){ roofGroup.remove(roofGroup.children[0]); }
            const roofGeo = new THREE.BoxGeometry((W_house + 2) * 0.5, 0.5, (L_house + 2) * 0.5);
            const roofSlab = new THREE.Mesh(roofGeo, roofMaterial);
            roofSlab.position.set(0, topHeight, 0);
            roofSlab.castShadow = true;
            roofGroup.add(roofSlab);
            
            const gableGeo = new THREE.ConeGeometry((W_house - 4) * 0.35, 2.5, 4);
            const gable = new THREE.Mesh(gableGeo, roofMaterial);
            gable.rotation.y = Math.PI / 4;
            gable.position.set(0, topHeight + 1.25, 0);
            gable.castShadow = true;
            roofGroup.add(gable);
            
            roofSlab.userData = { floor: "roof" };
            gable.userData = { floor: "roof" };
            
            update3DVisibility();
        }

        function buildWallsForLevel(floor, yOffset, h, wallMat, glassMat, doorMat) {
            const originalAdd = houseGroup.add;
            houseGroup.add = function(mesh) {
                mesh.userData = { floor: floor };
                mesh.traverse(child => { child.userData = { floor: floor }; });
                originalAdd.call(houseGroup, mesh);
            };
            
            const scaledY = yOffset * 0.5;
            const scaledH = h * 0.5; // Scale height values to match 3D logic (1ft = 0.5 unit)
            
            const wH = W_house * 0.5;
            const lH = L_house * 0.5;
            const wL = W_left * 0.5;
            const wR = W_right * 0.5;
            const lF = L_front * 0.5;
            const lM = L_middle * 0.5;
            const lB = L_back * 0.5;
            
            if (floor === "Ground Floor") {
                drawWallWithOpenings3D(-wH, -lH, -wH, lH, scaledY, scaledH, wallMat, glassMat, doorMat, [
                    { type: 'window', pos: (lF/2) / lH, size: 2.0 },
                    { type: 'window', pos: (lF + lM/2) / lH, size: 2.0 }
                ]);
                const rightOpenings = [{ type: 'window', pos: ((lF + lM)/2) / lH, size: 3.0 }];
                if (hasGuestBed) rightOpenings.push({ type: 'window', pos: (lF + lM + lB/2) / lH, size: 2.0 });
                drawWallWithOpenings3D(wH, -lH, wH, lH, scaledY, scaledH, wallMat, glassMat, doorMat, rightOpenings);
                
                drawWallWithOpenings3D(-wH, -lH, wH, -lH, scaledY, scaledH, wallMat, glassMat, doorMat, [
                    { type: 'window', pos: (wL/2) / wH, size: 2.0 },
                    { type: 'door', pos: (wL + wR/2) / wH, size: 1.75 }
                ]);
                const backOpenings = [];
                if (hasGuestBed) backOpenings.push({ type: 'window', pos: (wL + wR/2) / wH, size: 2.0 });
                drawWallWithOpenings3D(-wH, lH, wH, lH, scaledY, scaledH, wallMat, glassMat, doorMat, backOpenings);
                
                drawWallWithOpenings3D(-wH + wL, -lH, -wH + wL, lH, scaledY, scaledH, wallMat, glassMat, doorMat, [
                    { type: 'door', pos: (lF * 0.7) / lH, size: 1.5 },
                    { type: 'door', pos: (lF + lM/2) / lH, size: 3.5 }
                ]);
                drawWallWithOpenings3D(-wH, -lH + lF, -wH + wL, -lH + lF, scaledY, scaledH, wallMat, glassMat, doorMat, [{ type: 'door', pos: 0.5, size: 1.5 }]);
                drawWallWithOpenings3D(-wH, -lH + lF + lM, wH, -lH + lF + lM, scaledY, scaledH, wallMat, glassMat, doorMat, [
                    { type: 'door', pos: (wL * 0.3) / wH, size: 1.5 },
                    { type: 'door', pos: (wL * 0.8) / wH, size: 1.5 },
                    { type: 'door', pos: (wL + wR/2) / wH, size: 1.5 }
                ]);
                if (hasGuestBath) drawWallWithOpenings3D(-wH + wL * 0.6, -lH + lF + lM, -wH + wL * 0.6, lH, scaledY, scaledH, wallMat, glassMat, doorMat, []);
            } 
            else if (floor === "First Floor") {
                drawWallWithOpenings3D(-wH, -lH, -wH, lH, scaledY, scaledH, wallMat, glassMat, doorMat, [
                    { type: 'window', pos: (lF/2) / lH, size: 2.0 },
                    { type: 'window', pos: (lF + lM/2) / lH, size: 2.0 }
                ]);
                drawWallWithOpenings3D(wH, -lH, wH, lH, scaledY, scaledH, wallMat, glassMat, doorMat, [{ type: 'window', pos: (lF + lM + lB/2) / lH, size: 2.5 }]);
                drawWallWithOpenings3D(-wH, -lH, wH, -lH, scaledY, scaledH, wallMat, glassMat, doorMat, [{ type: 'door', pos: 0.5, size: 4.0 }]);
                drawWallWithOpenings3D(-wH, lH, wH, lH, scaledY, scaledH, wallMat, glassMat, doorMat, [{ type: 'window', pos: (wL/2) / wH, size: 1.5 }]);
                drawWallWithOpenings3D(-wH + wL, -lH, -wH + wL, lH, scaledY, scaledH, wallMat, glassMat, doorMat, [
                    { type: 'door', pos: (lF * 0.5) / lH, size: 1.5 },
                    { type: 'door', pos: (lF + lM/2) / lH, size: 1.5 }
                ]);
                if (hasOffice) drawWallWithOpenings3D(-wH, -lH + lF, -wH + wL, -lH + lF, scaledY, scaledH, wallMat, glassMat, doorMat, [{ type: 'door', pos: 0.5, size: 1.5 }]);
                drawWallWithOpenings3D(-wH, -lH + lF + lM, wH, -lH + lF + lM, scaledY, scaledH, wallMat, glassMat, doorMat, [
                    { type: 'door', pos: (wL * 0.5) / wH, size: 1.5 },
                    { type: 'door', pos: (wL + wR/2) / wH, size: 1.5 }
                ]);
            } 
            else if (floor === "Second Floor") {
                drawWallWithOpenings3D(-wH, -lH, -wH, lH, scaledY, scaledH, wallMat, glassMat, doorMat, [{ type: 'window', pos: (lF + lM + lB/2) / lH, size: 1.5 }]);
                drawWallWithOpenings3D(-wH + wL, -lH, -wH + wL, lH, scaledY, scaledH, wallMat, glassMat, doorMat, [
                    { type: 'door', pos: (lF + lM/2) / lH, size: 3.0 },
                    { type: 'door', pos: (lF + lM + lB/2) / lH, size: 1.5 }
                ]);
                drawWallWithOpenings3D(-wH, -lH + lF + lM, -wH + wL, -lH + lF + lM, scaledY, scaledH, wallMat, glassMat, doorMat, [{ type: 'door', pos: 0.5, size: 1.5 }]);
                if (hasStore) drawWallWithOpenings3D(-wH + wL * 0.5, -lH + lF + lM, -wH + wL * 0.5, lH, scaledY, scaledH, wallMat, glassMat, doorMat, []);
            }
            
            houseGroup.add = originalAdd;
        }

        function drawWallWithOpenings3D(startX, startZ, endX, endZ, yOffset, h, wallMat, glassMat, doorMat, openings) {
            const dx = endX - startX; const dz = endZ - startZ;
            const len = Math.sqrt(dx * dx + dz * dz);
            const angle = Math.atan2(dz, dx);
            const thickness = 0.15;
            
            openings = openings || [];
            openings.sort((a, b) => a.pos - b.pos);
            const wallGroup = new THREE.Group();
            wallGroup.position.set(startX, yOffset, startZ);
            wallGroup.rotation.y = -angle;
            
            let curL = 0;
            openings.forEach(op => {
                const opPos = op.pos * len; const opW = op.size;
                const segL = (opPos - opW/2) - curL;
                if (segL > 0.02) {
                    const segGeo = new THREE.BoxGeometry(segL, h, thickness);
                    const seg = new THREE.Mesh(segGeo, wallMat);
                    seg.position.set(curL + segL/2, h/2, 0);
                    seg.castShadow = true; seg.receiveShadow = true;
                    wallGroup.add(seg);
                }
                
                if (op.type === 'door') {
                    const doorH = 3.4 * 0.5;
                    const headerH = h - doorH;
                    if (headerH > 0.02) {
                        const headerGeo = new THREE.BoxGeometry(opW, headerH, thickness);
                        const header = new THREE.Mesh(headerGeo, wallMat);
                        header.position.set(opPos, doorH + headerH/2, 0);
                        header.castShadow = true; header.receiveShadow = true;
                        wallGroup.add(header);
                    }
                    const leafGeo = new THREE.BoxGeometry(opW, doorH, 0.05);
                    const leaf = new THREE.Mesh(leafGeo, doorMat);
                    leaf.position.set(opPos - opW/2, doorH/2, -opW/2);
                    leaf.rotation.y = Math.PI / 4;
                    leaf.castShadow = true;
                    wallGroup.add(leaf);
                } else if (op.type === 'window') {
                    const sillH = 1.5 * 0.5; const winH = 2.0 * 0.5;
                    const headerH = h - (sillH + winH);
                    if (sillH > 0.02) {
                        const sillGeo = new THREE.BoxGeometry(opW, sillH, thickness);
                        const sill = new THREE.Mesh(sillGeo, wallMat);
                        sill.position.set(opPos, sillH/2, 0);
                        sill.castShadow = true; sill.receiveShadow = true;
                        wallGroup.add(sill);
                    }
                    if (headerH > 0.02) {
                        const headerGeo = new THREE.BoxGeometry(opW, headerH, thickness);
                        const header = new THREE.Mesh(headerGeo, wallMat);
                        header.position.set(opPos, sillH + winH + headerH/2, 0);
                        header.castShadow = true; header.receiveShadow = true;
                        wallGroup.add(header);
                    }
                    const glassGeo = new THREE.BoxGeometry(opW, winH, 0.025);
                    const glass = new THREE.Mesh(glassGeo, glassMat);
                    glass.position.set(opPos, sillH + winH/2, 0);
                    wallGroup.add(glass);
                }
                curL = opPos + opW/2;
            });
            
            const lastL = len - curL;
            if (lastL > 0.02) {
                const segGeo = new THREE.BoxGeometry(lastL, h, thickness);
                const seg = new THREE.Mesh(segGeo, wallMat);
                seg.position.set(curL + lastL/2, h/2, 0);
                seg.castShadow = true; seg.receiveShadow = true;
                wallGroup.add(seg);
            }
            houseGroup.add(wallGroup);
        }

        // --- Low-poly 3D furniture models ---
        function buildBed3D(x, yOffset, z, w, l, rotation) {
            const bedGroup = new THREE.Group();
            const mattressMat = new THREE.MeshStandardMaterial({ color: 0xf5f5f5, roughness: 0.9 });
            const frameMat = new THREE.MeshStandardMaterial({ color: 0x5c4033, roughness: 0.8 });
            
            const mattressGeo = new THREE.BoxGeometry(2.5, 0.6, 3.25);
            const mattress = new THREE.Mesh(mattressGeo, mattressMat);
            mattress.position.set(0, 0.3, 0);
            bedGroup.add(mattress);
            
            const pillowMat = new THREE.MeshStandardMaterial({ color: 0xffffff, roughness: 0.9 });
            const pillowGeo = new THREE.BoxGeometry(0.9, 0.15, 0.6);
            const p1 = new THREE.Mesh(pillowGeo, pillowMat); p1.position.set(-0.55, 0.65, -1.25);
            const p2 = p1.clone(); p2.position.x = 0.55;
            bedGroup.add(p1); bedGroup.add(p2);
            
            const frameGeo = new THREE.BoxGeometry(2.6, 1.25, 0.15);
            const frame = new THREE.Mesh(frameGeo, frameMat); frame.position.set(0, 0.625, -1.65);
            bedGroup.add(frame);
            
            bedGroup.position.set(x, yOffset, z);
            bedGroup.rotation.y = rotation;
            houseGroup.add(bedGroup);
        }

        function buildSofa3D(x, yOffset, z, w, l, rotation) {
            const sofaGroup = new THREE.Group();
            const sofaMat = new THREE.MeshStandardMaterial({ color: 0x708090, roughness: 0.8 });
            
            const baseGeo = new THREE.BoxGeometry(3.5, 0.5, 1.5);
            const base = new THREE.Mesh(baseGeo, sofaMat); base.position.set(0, 0.25, 0);
            sofaGroup.add(base);
            
            const backGeo = new THREE.BoxGeometry(3.5, 1.1, 0.3);
            const back = new THREE.Mesh(backGeo, sofaMat); back.position.set(0, 0.8, -0.6);
            sofaGroup.add(back);
            
            const armGeo = new THREE.BoxGeometry(0.3, 0.9, 1.5);
            const armL = new THREE.Mesh(armGeo, sofaMat); armL.position.set(-1.6, 0.5, 0);
            const armR = armL.clone(); armR.position.x = 1.6;
            sofaGroup.add(armL); sofaGroup.add(armR);
            
            sofaGroup.position.set(x, yOffset, z);
            sofaGroup.rotation.y = rotation;
            houseGroup.add(sofaGroup);
        }

        function buildDiningTable3D(x, yOffset, z, w, l) {
            const tableGroup = new THREE.Group();
            const woodMat = new THREE.MeshStandardMaterial({ color: 0x5c4033, roughness: 0.8 });
            const topGeo = new THREE.BoxGeometry(3.0, 0.08, 2.0);
            const top = new THREE.Mesh(topGeo, woodMat); top.position.set(0, 1.45, 0);
            tableGroup.add(top);
            
            const legGeo = new THREE.CylinderGeometry(0.075, 0.075, 1.4);
            const leg = new THREE.Mesh(legGeo, woodMat);
            leg.position.set(-1.35, 0.7, -0.85); tableGroup.add(leg);
            const l2 = leg.clone(); l2.position.set(1.35, 0.7, -0.85); tableGroup.add(l2);
            const l3 = leg.clone(); l3.position.set(-1.35, 0.7, 0.85); tableGroup.add(l3);
            const l4 = leg.clone(); l4.position.set(1.35, 0.7, 0.85); tableGroup.add(l4);
            
            tableGroup.position.set(x, yOffset, z);
            houseGroup.add(tableGroup);
        }

        function buildKitchenCounter3D(x, yOffset, z, w, l) {
            const counterGroup = new THREE.Group();
            const marbleMat = new THREE.MeshStandardMaterial({ color: 0xf5f5f5, roughness: 0.2 });
            const cabMat = new THREE.MeshStandardMaterial({ color: 0x2d3436, roughness: 0.7 });
            
            const c1 = new THREE.Mesh(new THREE.BoxGeometry(w * 0.8, 1.4, 1.0), cabMat);
            c1.position.set(0, 0.7, -l + 0.5); counterGroup.add(c1);
            
            const t1 = new THREE.Mesh(new THREE.BoxGeometry(w * 0.8, 0.08, 1.05), marbleMat);
            t1.position.set(0, 1.44, -l + 0.5); counterGroup.add(t1);

            counterGroup.position.set(x, yOffset, z);
            houseGroup.add(counterGroup);
        }

        function buildBathroom3D(x, yOffset, z, w, l) {
            const bathGroup = new THREE.Group();
            const whiteMat = new THREE.MeshStandardMaterial({ color: 0xffffff, roughness: 0.1 });
            
            const bowl = new THREE.Mesh(new THREE.CylinderGeometry(0.35, 0.3, 0.6, 16), whiteMat);
            bowl.position.set(-w + 0.75, 0.3, -l + 0.75); bathGroup.add(bowl);
            const tank = new THREE.Mesh(new THREE.BoxGeometry(0.6, 0.75, 0.3), whiteMat);
            tank.position.set(-w + 0.75, 0.925, -l + 0.45); bathGroup.add(tank);
            
            const tub = new THREE.Mesh(new THREE.BoxGeometry(2.25, 0.9, 1.1), whiteMat);
            tub.position.set(w - 1.25, 0.45, l - 0.75); bathGroup.add(tub);

            bathGroup.position.set(x, yOffset, z);
            houseGroup.add(bathGroup);
        }

        function buildCar3D(x, yOffset, z, w, l) {
            const carGroup = new THREE.Group();
            const bodyMat = new THREE.MeshStandardMaterial({ color: 0xd63031, roughness: 0.2 });
            const wheelMat = new THREE.MeshStandardMaterial({ color: 0x111111, roughness: 0.9 });
            
            const chassis = new THREE.Mesh(new THREE.BoxGeometry(2.5, 0.6, 6.0), bodyMat);
            chassis.position.set(0, 0.4, 0); carGroup.add(chassis);
            
            const cabin = new THREE.Mesh(new THREE.BoxGeometry(2.3, 0.6, 3.0), bodyMat);
            cabin.position.set(0, 1.0, -0.25); carGroup.add(cabin);
            
            const whGeo = new THREE.CylinderGeometry(0.35, 0.35, 0.25, 16); whGeo.rotateZ(Math.PI/2);
            const w1 = new THREE.Mesh(whGeo, wheelMat); w1.position.set(-1.3, 0.35, 1.75); carGroup.add(w1);
            const w2 = w1.clone(); w2.position.x = 1.3; carGroup.add(w2);
            const w3 = w1.clone(); w3.position.z = -1.75; carGroup.add(w3);
            const w4 = w2.clone(); w4.position.z = -1.75; carGroup.add(w4);
            
            carGroup.position.set(x, yOffset, z);
            houseGroup.add(carGroup);
        }

        function buildStaircase(x, yOffset, z, w, l) {
            const stepsGroup = new THREE.Group();
            const numSteps = 10;
            const stepHeight = 4.0 / numSteps; // Total floor height is 4.0 in Three.js coords (8 ft)
            const stepDepth = l / numSteps;
            const stepWidth = w * 0.8;
            const stepMaterial = new THREE.MeshStandardMaterial({ color: 0x8b5a2b, roughness: 0.8 });
            
            for (let i = 0; i < numSteps; i++) {
                const stepGeo = new THREE.BoxGeometry(stepWidth, stepHeight, stepDepth);
                const step = new THREE.Mesh(stepGeo, stepMaterial);
                step.position.set(0, i * stepHeight + stepHeight/2, -l/2 + i * stepDepth + stepDepth/2);
                step.castShadow = true; step.receiveShadow = true;
                stepsGroup.add(step);
            }
            stepsGroup.position.set(x, yOffset, z);
            houseGroup.add(stepsGroup);
        }

        // Camera Animation tweening
        function animateCamera(direction) {
            if (walkthrough) toggleWalkthrough();
            
            let targetX, targetY, targetZ;
            if (direction === 'front') { targetX = 0; targetY = 5; targetZ = 22; }
            else if (direction === 'side') { targetX = 22; targetY = 5; targetZ = 0; }
            else if (direction === 'top') { targetX = 0; targetY = 28; targetZ = 0.01; }
            else if (direction === 'iso') { targetX = 18; targetY = 12; targetZ = 22; }

            let step = 0; const steps = 30;
            const startX = camera.position.x; const startY = camera.position.y; const startZ = camera.position.z;

            function cameraTween() {
                step++;
                camera.position.x = startX + (targetX - startX) * (step / steps);
                camera.position.y = startY + (targetY - startY) * (step / steps);
                camera.position.z = startZ + (targetZ - startZ) * (step / steps);
                controls.target.set(0, 2, 0);
                if (step < steps) { requestAnimationFrame(cameraTween); }
            }
            cameraTween();
        }

        // Toggle Roof slab visibility
        function toggleRoof() {
            showRoof = !showRoof;
            roofGroup.visible = showRoof;
            const btn = document.getElementById("roofToggleBtn");
            if (showRoof) {
                btn.style.background = "rgba(0,0,0,0.7)"; btn.style.color = "#fff";
            } else {
                btn.style.background = "var(--yellow)"; btn.style.color = "#121212";
            }
        }

        // Toggle 3D Walkthrough Mode
        function toggleWalkthrough() {
            walkthrough = !walkthrough;
            const overlay = document.getElementById("walkthroughControls");
            const btn = document.getElementById("walkthroughBtn");

            if (walkthrough) {
                overlay.style.display = "block";
                btn.style.background = "var(--yellow)"; btn.style.color = "#121212";
                camera.position.set(0, 0.9, 7.5); // 1.8 units scale (human scale eyes)
                controls.target.set(0, 0.9, 0);
                controls.enabled = false;
                window.addEventListener('keydown', onKeyDown);
                window.addEventListener('keyup', onKeyUp);
            } else {
                overlay.style.display = "none";
                btn.style.background = "rgba(0,0,0,0.7)"; btn.style.color = "#fff";
                controls.enabled = true;
                camera.position.set(18, 12, 22);
                controls.target.set(0, 2, 0);
                window.removeEventListener('keydown', onKeyDown);
                window.removeEventListener('keyup', onKeyUp);
            }
        }

        function onKeyDown(event) {
            switch (event.code) {
                case 'ArrowUp': case 'KeyW': moveForward = true; break;
                case 'ArrowLeft': case 'KeyA': moveLeft = true; break;
                case 'ArrowDown': case 'KeyS': moveBackward = true; break;
                case 'ArrowRight': case 'KeyD': moveRight = true; break;
            }
        }
        function onKeyUp(event) {
            switch (event.code) {
                case 'ArrowUp': case 'KeyW': moveForward = false; break;
                case 'ArrowLeft': case 'KeyA': moveLeft = false; break;
                case 'ArrowDown': case 'KeyS': moveBackward = false; break;
                case 'ArrowRight': case 'KeyD': moveRight = false; break;
            }
        }

        function handleWalkthroughMovement() {
            if (!walkthrough) return;
            const direction = new THREE.Vector3();
            camera.getWorldDirection(direction);
            direction.y = 0; direction.normalize();

            const sideDirection = new THREE.Vector3();
            sideDirection.copy(direction).applyAxisAngle(new THREE.Vector3(0, 1, 0), -Math.PI / 2);

            const speed = 0.25;
            if (moveForward) camera.position.addScaledVector(direction, speed);
            if (moveBackward) camera.position.addScaledVector(direction, -speed);
            if (moveLeft) camera.position.addScaledVector(sideDirection, -speed);
            if (moveRight) camera.position.addScaledVector(sideDirection, speed);
            
            const targetPos = new THREE.Vector3();
            targetPos.copy(camera.position).add(direction);
            camera.lookAt(targetPos);
        }

        // Day/Night Lights Simulation
        function toggleDayNight() {
            isNightMode = !isNightMode;
            const btn = document.getElementById("dayNightBtn");
            
            if (isNightMode) {
                btn.innerHTML = `<i class="fas fa-moon text-info me-1"></i> Night`;
                btn.className = "btn btn-sm btn-info rounded-pill text-white px-3";
                sunLight.intensity = 0.05;
                sunLight.color.setHex(0x334488);
                ambientLight.intensity = 0.15;
                
                roomLights.forEach(l => scene.remove(l));
                roomLights = [];
                
                roomsList.forEach(room => {
                    if (room.isOutdoor) return;
                    let yOffset = 0;
                    if (room.floor === "First Floor") yOffset = 8;
                    else if (room.floor === "Second Floor") yOffset = 16;
                    
                    const light = new THREE.PointLight(0xfff5cc, 1.2, 10);
                    light.position.set(room.x * 0.5, yOffset * 0.5 + 1.75, room.z * 0.5);
                    light.castShadow = true;
                    light.shadow.bias = -0.002;
                    light.shadow.mapSize.width = 512;
                    light.shadow.mapSize.height = 512;
                    
                    const bulbGeo = new THREE.SphereGeometry(0.075, 8, 8);
                    const bulbMat = new THREE.MeshBasicMaterial({ color: 0xffffff });
                    const bulb = new THREE.Mesh(bulbGeo, bulbMat);
                    light.add(bulb);
                    light.userData = { floor: room.floor };
                    
                    scene.add(light);
                    roomLights.push(light);
                });
            } else {
                btn.innerHTML = `<i class="fas fa-sun text-warning me-1"></i> Day`;
                btn.className = "btn btn-sm btn-dark rounded-pill border-secondary text-white px-3";
                sunLight.intensity = 0.8;
                sunLight.color.setHex(0xfffaed);
                ambientLight.intensity = 0.6;
                
                roomLights.forEach(l => scene.remove(l));
                roomLights = [];
            }
            update3DVisibility();
        }

        // Multi-floor level controls filter
        function changeFloorLevel() {
            const selectedFloor = document.getElementById("floorSelect").value;
            const view2d = document.getElementById("view-2d");
            
            if (view2d.style.visibility !== "hidden") {
                draw2D();
            }
            update3DVisibility();
        }

        function update3DVisibility() {
            const selectedFloor = document.getElementById("floorSelect").value;
            
            houseGroup.traverse(child => {
                if (child.userData && child.userData.floor) {
                    if (selectedFloor === "all") {
                        child.visible = (child.userData.floor !== "roof" || showRoof);
                    } else {
                        child.visible = (child.userData.floor === selectedFloor);
                    }
                }
            });
            
            roomLights.forEach(light => {
                if (light.userData && light.userData.floor) {
                    if (selectedFloor === "all") {
                        light.visible = true;
                    } else {
                        light.visible = (light.userData.floor === selectedFloor);
                    }
                }
            });

            if (selectedFloor !== "all") {
                roofGroup.visible = false;
            } else {
                roofGroup.visible = showRoof;
            }
        }

        // View Toggling between 2D & 3D
        function switchView(view) {
            const btn2d = document.getElementById("btn-2d");
            const btn3d = document.getElementById("btn-3d");
            const view2d = document.getElementById("view-2d");
            const view3d = document.getElementById("view-3d");
            const floorSelect = document.getElementById("floorSelect");
            
            if (view === '2d') {
                btn2d.className = "btn btn-gold btn-tab";
                btn3d.className = "btn btn-gold-outline btn-tab";
                view2d.style.visibility = "visible";
                view2d.style.zIndex = "10";
                view3d.style.visibility = "hidden";
                view3d.style.zIndex = "5";
                
                if (floorSelect.value === 'all') {
                    floorSelect.value = 'Ground Floor';
                }
                floorSelect.options[0].disabled = true; // Disable "All Floors" option for 2D
                document.getElementById("dayNightModeContainer").style.display = "none";
                draw2D();
            } else {
                btn2d.className = "btn btn-gold-outline btn-tab";
                btn3d.className = "btn btn-gold btn-tab";
                view2d.style.visibility = "hidden";
                view2d.style.zIndex = "5";
                view3d.style.visibility = "visible";
                view3d.style.zIndex = "10";
                
                floorSelect.options[0].disabled = false;
                document.getElementById("dayNightModeContainer").style.display = "flex";
                update3DVisibility();
                onWindowResize();
            }
        }

        // Handle browser window resize
        function onWindowResize() {
            const container = document.getElementById("canvas-container");
            if (canvas2D) {
                canvas2D.width = container.clientWidth;
                canvas2D.height = container.clientHeight;
                draw2D();
            }
            if (camera && renderer) {
                camera.aspect = container.clientWidth / container.clientHeight;
                camera.updateProjectionMatrix();
                renderer.setSize(container.clientWidth, container.clientHeight);
            }
        }

        function animate() {
            requestAnimationFrame(animate);
            if (walkthrough) {
                handleWalkthroughMovement();
            } else {
                controls.update();
            }
            if (renderer && scene && camera) {
                renderer.render(scene, camera);
            }
        }

        // ==========================================
        // PDF Form Submission with Image Snapshot
        // ==========================================
        function submitPdfForm() {
            const view2d = document.getElementById("view-2d");
            let dataUrl;
            
            if (view2d.style.visibility !== "hidden") {
                // Take 2D snapshot
                dataUrl = canvas2D.toDataURL("image/png");
            } else {
                // Take 3D snapshot
                const oldRoofVisibility = roofGroup.visible;
                roofGroup.visible = false;
                camera.position.set(10, 8, 12);
                controls.target.set(0, 1, 0);
                renderer.render(scene, camera);
                dataUrl = renderer.domElement.toDataURL("image/png");
                
                roofGroup.visible = oldRoofVisibility;
                renderer.render(scene, camera);
            }

            document.getElementById("base64Image").value = dataUrl;
            document.getElementById("pdfForm").submit();
        }
    </script>
</body>
</html>
