<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Plan Details - A K Construction</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Three.js Library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
    <!-- OrbitControls -->
    <script src="https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/controls/OrbitControls.js"></script>
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <link rel="stylesheet" href="/css/planner.css">
</head>
<body class="planner-bg">

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark planner-nav sticky-top">
        <div class="container py-2">
            <a class="navbar-brand d-flex align-items-center" href="/" style="font-weight: 800; color: var(--yellow);">
                <i class="fas fa-hammer me-2"></i> A K Construction
            </a>
            <div class="ms-auto d-flex align-items-center gap-3">
                <a href="/planner/dashboard" class="btn btn-gold-outline rounded-pill px-4 btn-sm"><i class="fas fa-th-large me-1"></i> Dashboard</a>
                
                <!-- Download PDF Button Form -->
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

    <!-- Detail View Main Content -->
    <div class="container py-5 fade-in">
        
        <!-- Header details -->
        <div class="d-flex justify-content-between align-items-start mb-5 flex-wrap gap-3">
            <div>
                <span class="badge bg-warning text-dark px-3 py-1.5 rounded-pill mb-2 font-weight-bold" style="font-size: 0.75rem;">${property.style} Plan</span>
                <h1 style="font-weight: 800; color: #fff;" class="mb-1">${property.ownerName}'s Smart House Plan</h1>
                <p class="text-white-50 mb-0"><i class="fas fa-map-marker-alt me-1 text-warning"></i> Located in ${property.city}, ${property.state}, ${property.country}</p>
            </div>
            <div id="architect-approval-container" class="text-end">
                <!-- Set dynamically by script below based on plan approval status -->
                <span class="text-white-50 d-block mb-1" style="font-size: 0.8rem;">Submitted: <fmt:formatDate value="${property.createdAt}" pattern="dd MMM yyyy"/></span>
            </div>
        </div>

        <c:if test="${not empty plan.architectDrawingUrl}">
            <!-- Approved blueprint panel -->
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
            
            <!-- LEFT PANEL: 3D Visualization and Recommendations -->
            <div class="col-xl-8">
                <!-- 3D Viewer Card -->
                <div class="glass-card p-4 mb-4">
                    <h5 style="color: #fff; font-weight: 700;" class="mb-3"><i class="fas fa-cube text-warning me-2"></i> Interactive 3D House Model</h5>
                    
                    <div id="canvas-container">
                        <div class="canvas-badge"><i class="fas fa-eye me-1"></i> Interactive 3D WebGL</div>
                        <div class="canvas-controls">
                            <button class="control-btn" onclick="animateCamera('front')" title="Front View">F</button>
                            <button class="control-btn" onclick="animateCamera('side')" title="Side View">S</button>
                            <button class="control-btn" onclick="animateCamera('top')" title="Top View">T</button>
                            <button class="control-btn" onclick="animateCamera('iso')" title="Isometric View">ISO</button>
                            <button class="control-btn" id="roofToggleBtn" onclick="toggleRoof()" title="Toggle Roof"><i class="fas fa-home"></i></button>
                            <button class="control-btn" id="walkthroughBtn" onclick="toggleWalkthrough()" title="Walkthrough Mode"><i class="fas fa-shoe-prints"></i></button>
                        </div>
                        <div class="walkthrough-overlay" id="walkthroughControls">
                            <strong>Walkthrough Enabled</strong><br>
                            Move: W, A, S, D / Arrow Keys<br>
                            Look: Drag with Left Mouse Button<br>
                            Exit: Press Walkthrough button again
                        </div>
                    </div>
                </div>

                <!-- Recommendations Text Card -->
                <div class="glass-card p-4">
                    <h5 style="color: #fff; font-weight: 700;" class="mb-3"><i class="fas fa-compass text-warning me-2"></i> Spatial & Structural Recommendations</h5>
                    
                    <div class="p-3 bg-white bg-opacity-5 rounded-3 mb-4" style="line-height: 1.8;">
                        <p class="text-white-50 mb-0" style="white-space: pre-line;">${plan.recommendations}</p>
                    </div>

                    <!-- Area Distribution Grid -->
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

            <!-- RIGHT PANEL: Cost breakdown, materials list -->
            <div class="col-xl-4">
                
                <!-- Room dimension values -->
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

                <!-- Cost breakdown and chart -->
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

                <!-- Material recommendations -->
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

        // Render Room Layout table
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
        // Three.js 3D House Visualization
        // ==========================================
        let scene, camera, renderer, controls;
        let roofGroup = new THREE.Group();
        let houseGroup = new THREE.Group();
        let showRoof = true;
        let walkthrough = false;
        
        // Navigation key listener for walkthrough
        let moveForward = false, moveBackward = false, moveLeft = false, moveRight = false;
        let walkSpeed = 0.5;

        init3D();

        function init3D() {
            const container = document.getElementById("canvas-container");
            const width = container.clientWidth;
            const height = container.clientHeight;

            // 1. Scene
            scene = new THREE.Scene();
            scene.background = new THREE.Color(0x1a1a2e);
            scene.fog = new THREE.FogExp2(0x1a1a2e, 0.015);

            // 2. Camera
            camera = new THREE.PerspectiveCamera(45, width / height, 0.1, 1000);
            camera.position.set(35, 25, 45);

            // 3. Renderer (enable preserveDrawingBuffer so we can take canvas snapshot)
            renderer = new THREE.WebGLRenderer({ antialias: true, preserveDrawingBuffer: true });
            renderer.setSize(width, height);
            renderer.shadowMap.enabled = true;
            renderer.shadowMap.type = THREE.PCFSoftShadowMap;
            container.appendChild(renderer.domElement);

            // 4. Controls
            controls = new THREE.OrbitControls(camera, renderer.domElement);
            controls.enableDamping = true;
            controls.dampingFactor = 0.05;
            controls.maxPolarAngle = Math.PI / 2 - 0.05; // don't go below ground

            // 5. Lighting
            const ambientLight = new THREE.AmbientLight(0xffffff, 0.6);
            scene.add(ambientLight);

            const sunLight = new THREE.DirectionalLight(0xfffaed, 0.8);
            sunLight.position.set(40, 60, 20);
            sunLight.castShadow = true;
            sunLight.shadow.mapSize.width = 1024;
            sunLight.shadow.mapSize.height = 1024;
            scene.add(sunLight);

            // 6. Ground Plane
            const groundGeo = new THREE.PlaneGeometry(100, 100);
            const groundMat = new THREE.MeshStandardMaterial({ 
                color: 0x242436,
                roughness: 0.8
            });
            const ground = new THREE.Mesh(groundGeo, groundMat);
            ground.rotation.x = -Math.PI / 2;
            ground.receiveShadow = true;
            scene.add(ground);

            // Grid helper representation
            const grid = new THREE.GridHelper(80, 80, 0xF4C430, 0x444455);
            grid.position.y = 0.02;
            scene.add(grid);

            // 7. Draw House structure dynamically
            buildHouse();

            // 8. Event listener resize
            window.addEventListener('resize', onWindowResize);

            // Start animation loop
            animate();
        }

        function buildHouse() {
            scene.add(houseGroup);
            houseGroup.add(roofGroup);

            // Material Definitions
            const wallMaterial = new THREE.MeshStandardMaterial({ color: 0xcccccc, roughness: 0.7 });
            const glassMaterial = new THREE.MeshStandardMaterial({ color: 0x88ccff, transparent: true, opacity: 0.6, roughness: 0.1 });
            const doorMaterial = new THREE.MeshStandardMaterial({ color: 0x5c4033, roughness: 0.9 });
            const roofMaterial = new THREE.MeshStandardMaterial({ color: 0x8b0000, roughness: 0.5 }); // Terracotta red

            // Let's lay out rooms relative to each other dynamically
            // Width and Length limits
            const rooms = Object.keys(dimensionsObj);

            // Simple placement engine for drawing rooms
            let groundRooms = floorsObj["Ground Floor"] || [];
            let firstRooms = floorsObj["First Floor"] || [];
            let secondRooms = floorsObj["Second Floor"] || [];

            // Draw Ground Floor
            drawFloorLayout(groundRooms, 0, wallMaterial, glassMaterial, doorMaterial);
            
            // Draw First Floor (elevated y=8)
            if (firstRooms.length > 0) {
                drawFloorLayout(firstRooms, 8, wallMaterial, glassMaterial, doorMaterial);
            }

            // Draw Second Floor (elevated y=16)
            if (secondRooms.length > 0) {
                drawFloorLayout(secondRooms, 16, wallMaterial, glassMaterial, doorMaterial);
            }

            // Create Roof (placed on top of the highest floor)
            let topHeight = 8;
            if (secondRooms.length > 0) topHeight = 24;
            else if (firstRooms.length > 0) topHeight = 16;

            const roofGeo = new THREE.BoxGeometry(28, 1.5, 38);
            const roofSlab = new THREE.Mesh(roofGeo, roofMaterial);
            roofSlab.position.set(0, topHeight, 0);
            roofSlab.castShadow = true;
            roofGroup.add(roofSlab);
            
            // Create a small gable block for visual beauty
            const gableGeo = new THREE.ConeGeometry(18, 6, 4);
            const gable = new THREE.Mesh(gableGeo, roofMaterial);
            gable.rotation.y = Math.PI / 4;
            gable.position.set(0, topHeight + 3, 0);
            gable.castShadow = true;
            roofGroup.add(gable);
        }

        // Layout builder that positions rooms in quadrant zones relative to a center point
        function drawFloorLayout(rooms, yOffset, wallMat, glassMat, doorMat) {
            // Plot dimensions scaled (feet to three.js coordinates where 1 ft = 0.5 units)
            const plotL = parseFloat("${property.length}") * 0.83 * 0.5;
            const plotW = parseFloat("${property.width}") * 0.83 * 0.5;
            const h = 4.0; // 8 ft height = 4 units

            rooms.forEach(room => {
                let dimStr = dimensionsObj[room] || "12x10";
                let parts = dimStr.split("x");
                let w = parseFloat(parts[0]) || 12;
                let l = parseFloat(parts[1]) || 10;

                // Scale feet to three.js coordinates
                w = w * 0.5;
                l = l * 0.5;

                let posX = 0;
                let posZ = 0;
                let posY = yOffset + h / 2;

                // Ground Floor Rooms arrangement
                if (yOffset === 0) {
                    if (room.includes("Living Room")) {
                        posX = plotW / 4;
                        posZ = plotL / 4;
                    } else if (room.includes("Kitchen")) {
                        posX = -plotW / 4;
                        posZ = -plotL / 4;
                    } else if (room.includes("Dining Area")) {
                        posX = -plotW / 4;
                        posZ = 0;
                    } else if (room.includes("Guest Bedroom")) {
                        posX = plotW / 4;
                        posZ = -plotL / 4;
                    } else if (room.includes("Guest Bathroom")) {
                        posX = 0;
                        posZ = -plotL / 4;
                    } else if (room.includes("Staircase")) {
                        posX = -plotW / 4;
                        posZ = plotL / 4;
                    } else if (room.includes("Parking")) {
                        posX = -plotW / 2 - 4.5;
                        posZ = plotL / 2 - 3.75;
                    } else if (room.includes("Garden")) {
                        posX = plotW / 2 + 4.5;
                        posZ = plotL / 2 - 2.5;
                    }
                } 
                // First Floor Rooms arrangement
                else if (yOffset === 8) {
                    if (room.includes("Master Bedroom")) {
                        posX = plotW / 4;
                        posZ = plotL / 4;
                    } else if (room.includes("Children Bedroom")) {
                        posX = -plotW / 4;
                        posZ = -plotL / 4;
                    } else if (room.includes("Master Bathroom")) {
                        posX = plotW / 4;
                        posZ = -plotL / 4;
                    } else if (room.includes("Office Room")) {
                        posX = -plotW / 4;
                        posZ = 0;
                    } else if (room.includes("Balcony")) {
                        posX = 0;
                        posZ = plotL / 2 + 1.25;
                    } else if (room.includes("Family Lounge")) {
                        posX = 0;
                        posZ = 0;
                    }
                } 
                // Second Floor Rooms arrangement
                else if (yOffset === 16) {
                    if (room.includes("Terrace")) {
                        posX = 0;
                        posZ = plotL / 4;
                    } else if (room.includes("Utility Area")) {
                        posX = -plotW / 4;
                        posZ = -plotL / 4;
                    } else if (room.includes("Store Room")) {
                        posX = plotW / 4;
                        posZ = -plotL / 4;
                    } else if (room.includes("Rooftop Pool")) {
                        posX = -plotW / 4;
                        posZ = 0;
                    }
                }

                // Create floor representing room space
                let floorColor = 0xa3a3a3;
                if (room.includes("Living")) floorColor = 0xd7ccc8; // wood
                else if (room.includes("Kitchen")) floorColor = 0xcfd8dc; // tile
                else if (room.includes("Bedroom")) floorColor = 0xffecb3; // warm carpet
                else if (room.includes("Garden")) floorColor = 0x81c784; // grass green
                else if (room.includes("Parking")) floorColor = 0x555566; // asphalt gray
                else if (room.includes("Balcony") || room.includes("Terrace")) floorColor = 0xb0bec5; // outdoor tile

                const rFloorGeo = new THREE.BoxGeometry(w - 0.1, 0.1, l - 0.1);
                const rFloorMat = new THREE.MeshStandardMaterial({ color: floorColor, roughness: 0.6 });
                const rFloor = new THREE.Mesh(rFloorGeo, rFloorMat);
                rFloor.position.set(posX, yOffset + 0.05, posZ);
                rFloor.receiveShadow = true;
                houseGroup.add(rFloor);

                // Create outer walls around this room box (exclude garden/parking)
                if (!room.includes("Garden") && !room.includes("Parking") && !room.includes("Terrace") && !room.includes("Balcony")) {
                    createRoomWalls(posX, posY, posZ, w, h, l, wallMat, glassMat, doorMat);
                } else if (room.includes("Balcony") || room.includes("Terrace")) {
                    // Create safety railings instead of full walls
                    createRailing(posX, yOffset + 0.5, posZ, w, 1.0, l, wallMat);
                }
            });
        }

        function createRailing(x, y, z, w, h, l, wallMat) {
            const thickness = 0.15;
            // Front railing
            const railFrontGeo = new THREE.BoxGeometry(w, h, thickness);
            const railFront = new THREE.Mesh(railFrontGeo, wallMat);
            railFront.position.set(x, y, z + l/2);
            houseGroup.add(railFront);
            // Left railing
            const railLeftGeo = new THREE.BoxGeometry(thickness, h, l);
            const railLeft = new THREE.Mesh(railLeftGeo, wallMat);
            railLeft.position.set(x - w/2, y, z);
            houseGroup.add(railLeft);
            // Right railing
            const railRightGeo = new THREE.BoxGeometry(thickness, h, l);
            const railRight = new THREE.Mesh(railRightGeo, wallMat);
            railRight.position.set(x + w/2, y, z);
            houseGroup.add(railRight);
        }

        // Draw individual walls around a room footprint, placing windows and doors
        function createRoomWalls(x, y, z, w, h, l, wallMat, glassMat, doorMat) {
            const thickness = 0.3;

            // 1. Back wall (Z-direction boundary)
            const wallBackGeo = new THREE.BoxGeometry(w, h, thickness);
            const wallBack = new THREE.Mesh(wallBackGeo, wallMat);
            wallBack.position.set(x, y, z - l/2);
            wallBack.castShadow = true;
            wallBack.receiveShadow = true;
            houseGroup.add(wallBack);

            // 2. Front Wall with window
            const wallFrontGeo = new THREE.BoxGeometry(w, h, thickness);
            const wallFront = new THREE.Mesh(wallFrontGeo, wallMat);
            wallFront.position.set(x, y, z + l/2);
            wallFront.castShadow = true;
            wallFront.receiveShadow = true;
            houseGroup.add(wallFront);

            // Window mesh in front wall
            const winGeo = new THREE.BoxGeometry(w * 0.4, h * 0.4, thickness + 0.05);
            const win = new THREE.Mesh(winGeo, glassMat);
            win.position.set(x, y + 0.5, z + l/2);
            houseGroup.add(win);

            // 3. Left Wall with door
            const wallLeftGeo = new THREE.BoxGeometry(thickness, h, l);
            const wallLeft = new THREE.Mesh(wallLeftGeo, wallMat);
            wallLeft.position.set(x - w/2, y, z);
            wallLeft.castShadow = true;
            wallLeft.receiveShadow = true;
            houseGroup.add(wallLeft);

            // Door mesh on left wall
            const doorGeo = new THREE.BoxGeometry(thickness + 0.05, h * 0.8, w * 0.25);
            const door = new THREE.Mesh(doorGeo, doorMat);
            door.position.set(x - w/2, y - h * 0.1, z);
            houseGroup.add(door);

            // 4. Right Wall
            const wallRightGeo = new THREE.BoxGeometry(thickness, h, l);
            const wallRight = new THREE.Mesh(wallRightGeo, wallMat);
            wallRight.position.set(x + w/2, y, z);
            wallRight.castShadow = true;
            wallRight.receiveShadow = true;
            houseGroup.add(wallRight);
        }

        // Camera Animation controller
        function animateCamera(direction) {
            if (walkthrough) toggleWalkthrough(); // Disable walkthrough on view change
            
            let targetX, targetY, targetZ;
            if (direction === 'front') {
                targetX = 0; targetY = 10; targetZ = 45;
            } else if (direction === 'side') {
                targetX = 45; targetY = 10; targetZ = 0;
            } else if (direction === 'top') {
                targetX = 0; targetY = 55; targetZ = 0.01; // slight offset to prevent gimbal lock
            } else if (direction === 'iso') {
                targetX = 35; targetY = 25; targetZ = 45;
            }

            // Simple tween animation
            let step = 0;
            const steps = 30;
            const startX = camera.position.x;
            const startY = camera.position.y;
            const startZ = camera.position.z;

            function cameraTween() {
                step++;
                camera.position.x = startX + (targetX - startX) * (step / steps);
                camera.position.y = startY + (targetY - startY) * (step / steps);
                camera.position.z = startZ + (targetZ - startZ) * (step / steps);
                controls.target.set(0, 4, 0);
                
                if (step < steps) {
                    requestAnimationFrame(cameraTween);
                }
            }
            cameraTween();
        }

        // Toggle Roof slab
        function toggleRoof() {
            showRoof = !showRoof;
            roofGroup.visible = showRoof;
            const btn = document.getElementById("roofToggleBtn");
            if (showRoof) {
                btn.style.background = "rgba(0,0,0,0.7)";
                btn.style.color = "#fff";
            } else {
                btn.style.background = "var(--yellow)";
                btn.style.color = "#121212";
            }
        }

        // Toggle Walkthrough Mode
        function toggleWalkthrough() {
            walkthrough = !walkthrough;
            const overlay = document.getElementById("walkthroughControls");
            const btn = document.getElementById("walkthroughBtn");

            if (walkthrough) {
                overlay.style.display = "block";
                btn.style.background = "var(--yellow)";
                btn.style.color = "#121212";
                
                // Set camera to human scale eye-level
                camera.position.set(0, 1.8, 15);
                controls.target.set(0, 1.8, 0);
                controls.enabled = false; // Disable Orbit rotation control
                
                // Listeners
                window.addEventListener('keydown', onKeyDown);
                window.addEventListener('keyup', onKeyUp);
            } else {
                overlay.style.display = "none";
                btn.style.background = "rgba(0,0,0,0.7)";
                btn.style.color = "#fff";
                
                controls.enabled = true;
                camera.position.set(35, 25, 45);
                controls.target.set(0, 4, 0);

                window.removeEventListener('keydown', onKeyDown);
                window.removeEventListener('keyup', onKeyUp);
            }
        }

        // Keyboard inputs for moving walkthrough camera
        function onKeyDown(event) {
            switch (event.code) {
                case 'ArrowUp':
                case 'KeyW':
                    moveForward = true;
                    break;
                case 'ArrowLeft':
                case 'KeyA':
                    moveLeft = true;
                    break;
                case 'ArrowDown':
                case 'KeyS':
                    moveBackward = true;
                    break;
                case 'ArrowRight':
                case 'KeyD':
                    moveRight = true;
                    break;
            }
        }

        function onKeyUp(event) {
            switch (event.code) {
                case 'ArrowUp':
                case 'KeyW':
                    moveForward = false;
                    break;
                case 'ArrowLeft':
                case 'KeyA':
                    moveLeft = false;
                    break;
                case 'ArrowDown':
                case 'KeyS':
                    moveBackward = false;
                    break;
                case 'ArrowRight':
                case 'KeyD':
                    moveRight = false;
                    break;
            }
        }

        function handleWalkthroughMovement() {
            if (!walkthrough) return;
            
            // Get direction vector of camera
            const direction = new THREE.Vector3();
            camera.getWorldDirection(direction);
            direction.y = 0; // lock to horizontal plane
            direction.normalize();

            const sideDirection = new THREE.Vector3();
            sideDirection.copy(direction).applyAxisAngle(new THREE.Vector3(0, 1, 0), -Math.PI / 2);

            if (moveForward) {
                camera.position.addScaledVector(direction, walkSpeed);
            }
            if (moveBackward) {
                camera.position.addScaledVector(direction, -walkSpeed);
            }
            if (moveLeft) {
                camera.position.addScaledVector(sideDirection, -walkSpeed);
            }
            if (moveRight) {
                camera.position.addScaledVector(sideDirection, walkSpeed);
            }
            
            // Keep walking target aligned in front of camera
            const targetPos = new THREE.Vector3();
            targetPos.copy(camera.position).add(direction);
            camera.lookAt(targetPos);
        }

        function animate() {
            requestAnimationFrame(animate);
            
            if (walkthrough) {
                handleWalkthroughMovement();
            } else {
                controls.update();
            }
            
            renderer.render(scene, camera);
        }

        function onWindowResize() {
            const container = document.getElementById("canvas-container");
            camera.aspect = container.clientWidth / container.clientHeight;
            camera.updateProjectionMatrix();
            renderer.setSize(container.clientWidth, container.clientHeight);
        }

        // ==========================================
        // PDF Form Submission with 3D Canvas Snapshot
        // ==========================================
        function submitPdfForm() {
            // 1. Hide roof temporarily to take screenshot of floor layout (very helpful for viewing floor plan in PDF)
            const oldRoofVisibility = roofGroup.visible;
            roofGroup.visible = false;
            
            // 2. Set camera to Top-down / Isometric for a better PDF print angle
            camera.position.set(22, 18, 28);
            controls.target.set(0, 3, 0);
            renderer.render(scene, camera);

            // 3. Extract base64 image data from the WebGL canvas
            const dataUrl = renderer.domElement.toDataURL("image/png");
            
            // 4. Restore original visibility
            roofGroup.visible = oldRoofVisibility;
            renderer.render(scene, camera);

            // 5. Submit form
            document.getElementById("base64Image").value = dataUrl;
            document.getElementById("pdfForm").submit();
        }
    </script>
</body>
</html>
