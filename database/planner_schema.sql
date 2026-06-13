USE ak_construction;

CREATE TABLE IF NOT EXISTS property_details (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    owner_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    length DOUBLE NOT NULL,
    width DOUBLE NOT NULL,
    plot_area DOUBLE NOT NULL,
    floors INT NOT NULL,
    bedrooms INT NOT NULL,
    bathrooms INT NOT NULL,
    kitchen_type VARCHAR(50) NOT NULL,
    parking VARCHAR(10) NOT NULL,
    garden VARCHAR(10) NOT NULL,
    pool VARCHAR(10) NOT NULL,
    office VARCHAR(10) NOT NULL,
    budget_range VARCHAR(50) NOT NULL,
    style VARCHAR(50) NOT NULL,
    vastu VARCHAR(10) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS house_plans (
    id INT PRIMARY KEY AUTO_INCREMENT,
    property_id INT NOT NULL,
    buildable_area DOUBLE NOT NULL,
    open_area DOUBLE NOT NULL,
    parking_area DOUBLE NOT NULL,
    garden_area DOUBLE NOT NULL,
    floor_details TEXT NOT NULL,
    room_dimensions TEXT NOT NULL,
    recommendations TEXT NOT NULL,
    is_approved BOOLEAN DEFAULT FALSE,
    architect_drawing_url VARCHAR(255) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES property_details(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS cost_estimations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    property_id INT NOT NULL,
    foundation_cost DOUBLE NOT NULL,
    wall_cost DOUBLE NOT NULL,
    roof_cost DOUBLE NOT NULL,
    electrical_cost DOUBLE NOT NULL,
    plumbing_cost DOUBLE NOT NULL,
    flooring_cost DOUBLE NOT NULL,
    painting_cost DOUBLE NOT NULL,
    interior_cost DOUBLE NOT NULL,
    labor_cost DOUBLE NOT NULL,
    total_cost DOUBLE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES property_details(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS material_estimations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    property_id INT NOT NULL,
    cement_bags INT NOT NULL,
    steel_kg DOUBLE NOT NULL,
    bricks_pcs INT NOT NULL,
    sand_cft DOUBLE NOT NULL,
    aggregate_cft DOUBLE NOT NULL,
    paint_liters DOUBLE NOT NULL,
    tiles_sqft DOUBLE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES property_details(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS pdf_reports (
    id INT PRIMARY KEY AUTO_INCREMENT,
    property_id INT NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES property_details(id) ON DELETE CASCADE
);
