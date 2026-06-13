<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Smart House Planner - New Request</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/planner.css">
    <style>
        .form-container {
            max-width: 800px;
            width: 100%;
            margin: 0 auto;
        }
    </style>
</head>
<body class="planner-bg">

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark planner-nav sticky-top">
        <div class="container py-2">
            <a class="navbar-brand d-flex align-items-center" href="/" style="font-weight: 800; color: var(--yellow);">
                <i class="fas fa-hammer me-2"></i> A K Construction
            </a>
            <div class="ms-auto">
                <a href="/planner/dashboard" class="btn btn-gold-outline rounded-pill px-4 btn-sm"><i class="fas fa-chevron-left me-1"></i> Back to Dashboard</a>
            </div>
        </div>
    </nav>

    <!-- Loading Overlay -->
    <div id="loading-overlay" style="display: none;">
        <div class="spinner-gold mb-4"></div>
        <h3 class="text-white mb-2" style="font-weight: 700;">AI Engine Analyzing Plot Specifications</h3>
        <p class="text-white-50 text-center px-4" style="max-width: 450px;">Calculating buildable footprint coverage, distributing floor plans, compiling structural material lists, and compiling cost budgets...</p>
    </div>

    <!-- Main Form Container -->
    <div class="container py-5">
        <div class="form-container">
            
            <!-- Step Indicators -->
            <div class="wizard-steps">
                <div class="wizard-step active" id="step1-indicator">1</div>
                <div class="wizard-step" id="step2-indicator">2</div>
                <div class="wizard-step" id="step3-indicator">3</div>
                <div class="wizard-step" id="step4-indicator">4</div>
            </div>

            <!-- Form Card -->
            <div class="glass-card p-5 rounded-4 fade-in">
                
                <form id="plannerForm" action="/planner/generate" method="post">
                    
                    <!-- STEP 1: CONTACT DETAILS -->
                    <div class="form-step active" id="step1">
                        <h4 style="font-weight: 700; color: #fff;" class="mb-4"><i class="fas fa-address-card text-warning me-2"></i> Owner & Contact Information</h4>
                        
                        <div class="mb-3">
                            <label for="ownerName" class="form-label text-white-50">Owner Name</label>
                            <input type="text" class="form-control glass-input" id="ownerName" name="ownerName" placeholder="Enter owner's full name" value="${sessionScope.user.name}" required>
                        </div>
                        
                        <div class="row g-3">
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label text-white-50">Email Address</label>
                                <input type="email" class="form-control glass-input" id="email" name="email" placeholder="example@domain.com" value="${sessionScope.user.email}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="phone" class="form-label text-white-50">Phone Number</label>
                                <input type="tel" class="form-control glass-input" id="phone" name="phone" placeholder="Enter 10-digit number" required>
                            </div>
                        </div>
                        
                        <div class="d-flex justify-content-end mt-4">
                            <button type="button" class="btn btn-gold px-4" onclick="nextStep(2)">Continue <i class="fas fa-arrow-right ms-1"></i></button>
                        </div>
                    </div>

                    <!-- STEP 2: PROPERTY DIMENSIONS -->
                    <div class="form-step" id="step2">
                        <h4 style="font-weight: 700; color: #fff;" class="mb-4"><i class="fas fa-ruler-combined text-warning me-2"></i> Property Dimensions & Location</h4>
                        
                        <div class="row g-3">
                            <div class="col-md-6 mb-3">
                                <label for="length" class="form-label text-white-50">Property Length (feet)</label>
                                <input type="number" class="form-control glass-input" id="length" name="length" placeholder="e.g. 50" min="15" max="300" oninput="calcPlotArea()" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="width" class="form-label text-white-50">Property Width (feet)</label>
                                <input type="number" class="form-control glass-input" id="width" name="width" placeholder="e.g. 30" min="15" max="300" oninput="calcPlotArea()" required>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label text-white-50">Estimated Plot Area</label>
                            <div class="p-3 bg-white bg-opacity-5 rounded-3 border border-secondary border-opacity-25 d-flex align-items-center justify-content-between">
                                <span class="text-white-50">Calculated Footprint:</span>
                                <strong class="text-warning h4 mb-0"><span id="plotAreaText">0</span> sq ft</strong>
                            </div>
                        </div>

                        <div class="row g-3">
                            <div class="col-md-4 mb-3">
                                <label for="city" class="form-label text-white-50">City</label>
                                <input type="text" class="form-control glass-input" id="city" name="city" placeholder="Ahmedabad" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="state" class="form-label text-white-50">State</label>
                                <input type="text" class="form-control glass-input" id="state" name="state" placeholder="Gujarat" required>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="country" class="form-label text-white-50">Country</label>
                                <input type="text" class="form-control glass-input" id="country" name="country" placeholder="India" value="India" required>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <button type="button" class="btn btn-gold-outline px-4" onclick="prevStep(1)"><i class="fas fa-arrow-left me-1"></i> Back</button>
                            <button type="button" class="btn btn-gold px-4" onclick="nextStep(3)">Continue <i class="fas fa-arrow-right ms-1"></i></button>
                        </div>
                    </div>

                    <!-- STEP 3: HOUSE PREFERENCES -->
                    <div class="form-step" id="step3">
                        <h4 style="font-weight: 700; color: #fff;" class="mb-4"><i class="fas fa-couch text-warning me-2"></i> Rooms & Architecture Design</h4>
                        
                        <div class="row g-3">
                            <div class="col-md-4 mb-3">
                                <label for="floors" class="form-label text-white-50">Number of Floors</label>
                                <select class="form-select glass-input" id="floors" name="floors" required>
                                    <option value="1">1 (Ground Floor Only)</option>
                                    <option value="2" selected>2 (Ground + First)</option>
                                    <option value="3">3 (Ground + 2 Floors)</option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="bedrooms" class="form-label text-white-50">Bedrooms (BHK)</label>
                                <select class="form-select glass-input" id="bedrooms" name="bedrooms" required>
                                    <option value="1">1 BHK</option>
                                    <option value="2">2 BHK</option>
                                    <option value="3" selected>3 BHK</option>
                                    <option value="4">4 BHK</option>
                                    <option value="5">5 BHK</option>
                                </select>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="bathrooms" class="form-label text-white-50">Bathrooms</label>
                                <select class="form-select glass-input" id="bathrooms" name="bathrooms" required>
                                    <option value="1">1</option>
                                    <option value="2" selected>2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                </select>
                            </div>
                        </div>

                        <div class="row g-3">
                            <div class="col-md-6 mb-3">
                                <label for="kitchenType" class="form-label text-white-50">Kitchen Type</label>
                                <select class="form-select glass-input" id="kitchenType" name="kitchenType" required>
                                    <option value="Modular" selected>Modular Kitchen</option>
                                    <option value="Open Layout">Open Kitchen Layout</option>
                                    <option value="Closed Traditional">Traditional Closed</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="style" class="form-label text-white-50">Construction Style</label>
                                <select class="form-select glass-input" id="style" name="style" required>
                                    <option value="Modern" selected>Modern</option>
                                    <option value="Contemporary">Contemporary</option>
                                    <option value="Traditional">Traditional</option>
                                    <option value="Luxury">Luxury</option>
                                    <option value="Minimalist">Minimalist</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="budgetRange" class="form-label text-white-50">Budget Range</label>
                            <select class="form-select glass-input" id="budgetRange" name="budgetRange" required>
                                <option value="Under 20 Lakhs">Under 20 Lakhs (Economy)</option>
                                <option value="20 to 50 Lakhs" selected>20 to 50 Lakhs (Standard)</option>
                                <option value="50 Lakhs to 1 Crore">50 Lakhs to 1 Crore (Premium)</option>
                                <option value="Above 1 Crore">Above 1 Crore (Luxury Grand)</option>
                            </select>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <button type="button" class="btn btn-gold-outline px-4" onclick="prevStep(2)"><i class="fas fa-arrow-left me-1"></i> Back</button>
                            <button type="button" class="btn btn-gold px-4" onclick="nextStep(4)">Continue <i class="fas fa-arrow-right ms-1"></i></button>
                        </div>
                    </div>

                    <!-- STEP 4: AMENITIES & VASTU -->
                    <div class="form-step" id="step4">
                        <h4 style="font-weight: 700; color: #fff;" class="mb-4"><i class="fas fa-tree text-warning me-2"></i> Amenities & Vastu Preferences</h4>
                        
                        <div class="row g-3">
                            <div class="col-md-6 mb-3">
                                <label class="form-label text-white-50">Parking Space Required?</label>
                                <div class="d-flex gap-3">
                                    <input type="radio" class="btn-check" name="parking" id="parkingYes" value="Yes" checked>
                                    <label class="btn btn-outline-light rounded-pill px-4 text-center w-50" for="parkingYes">Yes</label>

                                    <input type="radio" class="btn-check" name="parking" id="parkingNo" value="No">
                                    <label class="btn btn-outline-light rounded-pill px-4 text-center w-50" for="parkingNo">No</label>
                                </div>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label text-white-50">Garden Space Required?</label>
                                <div class="d-flex gap-3">
                                    <input type="radio" class="btn-check" name="garden" id="gardenYes" value="Yes" checked>
                                    <label class="btn btn-outline-light rounded-pill px-4 text-center w-50" for="gardenYes">Yes</label>

                                    <input type="radio" class="btn-check" name="garden" id="gardenNo" value="No">
                                    <label class="btn btn-outline-light rounded-pill px-4 text-center w-50" for="gardenNo">No</label>
                                </div>
                            </div>
                        </div>

                        <div class="row g-3">
                            <div class="col-md-6 mb-3">
                                <label class="form-label text-white-50">Swimming Pool Required?</label>
                                <div class="d-flex gap-3">
                                    <input type="radio" class="btn-check" name="pool" id="poolYes" value="Yes">
                                    <label class="btn btn-outline-light rounded-pill px-4 text-center w-50" for="poolYes">Yes</label>

                                    <input type="radio" class="btn-check" name="pool" id="poolNo" value="No" checked>
                                    <label class="btn btn-outline-light rounded-pill px-4 text-center w-50" for="poolNo">No</label>
                                </div>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label text-white-50">Home Office Room Required?</label>
                                <div class="d-flex gap-3">
                                    <input type="radio" class="btn-check" name="office" id="officeYes" value="Yes">
                                    <label class="btn btn-outline-light rounded-pill px-4 text-center w-50" for="officeYes">Yes</label>

                                    <input type="radio" class="btn-check" name="office" id="officeNo" value="No" checked>
                                    <label class="btn btn-outline-light rounded-pill px-4 text-center w-50" for="officeNo">No</label>
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label text-white-50">Vastu Shastra Planning Compliant?</label>
                            <div class="d-flex gap-3">
                                <input type="radio" class="btn-check" name="vastu" id="vastuYes" value="Yes" checked>
                                <label class="btn btn-outline-light rounded-pill px-4 text-center w-50" for="vastuYes">Yes</label>

                                <input type="radio" class="btn-check" name="vastu" id="vastuNo" value="No">
                                <label class="btn btn-outline-light rounded-pill px-4 text-center w-50" for="vastuNo">No</label>
                            </div>
                        </div>

                        <div class="mb-4">
                            <label for="notes" class="form-label text-white-50">Additional Architectural Notes</label>
                            <textarea class="form-control glass-input" id="notes" name="notes" placeholder="Enter special requirements e.g. double height living room, staircase styling, tile preference, etc." rows="3"></textarea>
                        </div>

                        <div class="d-flex justify-content-between mt-4">
                            <button type="button" class="btn btn-gold-outline px-4" onclick="prevStep(3)"><i class="fas fa-arrow-left me-1"></i> Back</button>
                            <button type="submit" class="btn btn-gold px-4" id="submitBtn"><i class="fas fa-cogs me-1"></i> Generate House Plan</button>
                        </div>
                    </div>

                </form>

            </div>

        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function nextStep(step) {
            // Simple validation
            let valid = true;
            const activeStep = document.querySelector(".form-step.active");
            const inputs = activeStep.querySelectorAll("input[required], select[required]");
            
            inputs.forEach(input => {
                if(!input.value) {
                    input.classList.add("is-invalid");
                    valid = false;
                } else {
                    input.classList.remove("is-invalid");
                }
            });

            if(!valid) return;

            // Update step displays
            document.querySelectorAll(".form-step").forEach(el => el.classList.remove("active"));
            document.getElementById("step" + step).classList.add("active");

            // Update progress indicators
            document.querySelectorAll(".wizard-step").forEach((el, index) => {
                if (index < step) {
                    el.classList.add("active");
                } else {
                    el.classList.remove("active");
                }
            });

            // Adjust completed
            document.querySelectorAll(".wizard-step").forEach((el, index) => {
                if (index < step - 1) {
                    el.classList.add("completed");
                } else {
                    el.classList.remove("completed");
                }
            });
        }

        function prevStep(step) {
            document.querySelectorAll(".form-step").forEach(el => el.classList.remove("active"));
            document.getElementById("step" + step).classList.add("active");

            document.querySelectorAll(".wizard-step").forEach((el, index) => {
                if (index < step) {
                    el.classList.add("active");
                    el.classList.remove("completed");
                } else {
                    el.classList.remove("active");
                    el.classList.remove("completed");
                }
            });
        }

        function calcPlotArea() {
            const l = parseFloat(document.getElementById("length").value) || 0;
            const w = parseFloat(document.getElementById("width").value) || 0;
            const area = l * w;
            document.getElementById("plotAreaText").innerText = area.toLocaleString();
        }

        // Show loader on form submission
        document.getElementById("plannerForm").addEventListener("submit", function() {
            document.getElementById("loading-overlay").style.display = "flex";
        });
    </script>
</body>
</html>
