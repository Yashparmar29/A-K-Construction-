CREATE DATABASE IF NOT EXISTS ak_construction;
USE ak_construction;

CREATE TABLE IF NOT EXISTS projects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL,
    image VARCHAR(255),
    description TEXT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS contacts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    message TEXT NOT NULL,
    submitted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employee_code VARCHAR(50),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) DEFAULT 'USER',
    profile_image VARCHAR(255),
    address TEXT,
    joining_date DATE,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Work Types Table
CREATE TABLE IF NOT EXISTS work_types (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    category VARCHAR(100),
    status VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Contractor-Worker Parent-Child Relationship Table
CREATE TABLE IF NOT EXISTS contractor_worker (
    id INT PRIMARY KEY AUTO_INCREMENT,
    contractor_id INT NOT NULL,
    worker_id INT NOT NULL,
    assigned_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    FOREIGN KEY (contractor_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (worker_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Worker Work Assignments Table
CREATE TABLE IF NOT EXISTS worker_work_assignments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    worker_id INT NOT NULL,
    contractor_id INT NOT NULL,
    project_id INT NOT NULL,
    work_type_id INT NOT NULL,
    task_title VARCHAR(255) NOT NULL,
    task_description TEXT,
    start_date DATE,
    expected_end_date DATE,
    actual_end_date DATE,
    priority VARCHAR(20) DEFAULT 'MEDIUM',
    status VARCHAR(20) DEFAULT 'ASSIGNED',
    completion_percentage INT DEFAULT 0,
    remarks TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (worker_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (contractor_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
    FOREIGN KEY (work_type_id) REFERENCES work_types(id) ON DELETE CASCADE
);

-- Employee Attendance Table
CREATE TABLE IF NOT EXISTS employee_attendance (
    id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT NOT NULL,
    contractor_id INT,
    date DATE NOT NULL,
    check_in TIME,
    check_out TIME,
    working_hours DOUBLE DEFAULT 0,
    status VARCHAR(20) DEFAULT 'PRESENT',
    remarks TEXT,
    latitude DOUBLE,
    longitude DOUBLE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Daily Work Reports Table
CREATE TABLE IF NOT EXISTS daily_work (
    id INT PRIMARY KEY AUTO_INCREMENT,
    worker_id INT NOT NULL,
    contractor_id INT NOT NULL,
    project_id INT NOT NULL,
    work_type_id INT NOT NULL,
    assignment_id INT,
    date DATE NOT NULL,
    start_time TIME,
    end_time TIME,
    hours_worked DOUBLE DEFAULT 0,
    work_description TEXT,
    completion_percentage INT DEFAULT 0,
    materials_used TEXT,
    equipment_used TEXT,
    photos TEXT,
    remarks TEXT,
    status VARCHAR(20) DEFAULT 'SUBMITTED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (worker_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (contractor_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
    FOREIGN KEY (work_type_id) REFERENCES work_types(id) ON DELETE CASCADE
);

-- Material Requests Table
CREATE TABLE IF NOT EXISTS material_requests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    worker_id INT NOT NULL,
    contractor_id INT NOT NULL,
    project_id INT NOT NULL,
    material_name VARCHAR(150) NOT NULL,
    quantity DOUBLE NOT NULL,
    unit VARCHAR(50) NOT NULL,
    reason TEXT,
    priority VARCHAR(20) DEFAULT 'MEDIUM',
    requested_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'PENDING',
    remarks TEXT,
    FOREIGN KEY (worker_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (contractor_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

-- Site Reports Table
CREATE TABLE IF NOT EXISTS site_reports (
    id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT NOT NULL,
    contractor_id INT NOT NULL,
    worker_id INT NOT NULL,
    work_type_id INT NOT NULL,
    report_date DATE NOT NULL,
    weather VARCHAR(50),
    workers_present INT DEFAULT 1,
    work_completed TEXT,
    materials_used TEXT,
    equipment_used TEXT,
    issues TEXT,
    safety_observations TEXT,
    progress_percentage INT DEFAULT 0,
    remarks TEXT,
    photos TEXT,
    status VARCHAR(20) DEFAULT 'SUBMITTED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
    FOREIGN KEY (contractor_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (worker_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (work_type_id) REFERENCES work_types(id) ON DELETE CASCADE
);

TRUNCATE TABLE projects;

INSERT INTO projects (title, category, image, description) VALUES
('Modern Villa Residence', 'Residential', 'images/project1.jpg', 'Luxury 4BHK villa with contemporary design, smart home features, and landscaped gardens. Located in Bodakdev, Ahmedabad, Gujarat.'),
('Corporate Office Complex', 'Commercial', 'images/project2.jpg', '5-story corporate headquarters with a double-glazed glass facade, energy-efficient HVAC, and collaborative open workspaces. Located in GIFT City, Gandhinagar, Gujarat.'),
('Luxury Apartment Complex', 'Residential', 'images/project3.jpg', '20-unit premium residential apartment building offering high-end finishings, dedicated parking, and premium rooftop amenities. Located on Dumas Road, Surat, Gujarat.'),
('Shopping Mall Development', 'Commercial', 'images/project4.jpg', '3-level premium retail shopping mall with capacity for 50+ stores, dynamic digital signage, central atrium, and a large food court. Located on Race Course Road, Rajkot, Gujarat.'),
('Premium School Renovation', 'Renovation', 'images/project5.jpg', 'Complete structural and aesthetic renovation of a high school facility, including modern science labs, smart classrooms, and sports grounds. Located in Akota, Vadodara, Gujarat.'),
('Cable-Stayed Bridge Construction', 'Civil Engineering', 'images/project6.jpg', 'State-of-the-art 4-lane concrete cable-stayed bridge built over the Tapi River, engineered with advanced seismic resistance and design. Located in Surat, Gujarat.');

INSERT IGNORE INTO contacts (name, email, message) VALUES
('John Doe', 'john@example.com', 'Interested in residential project quote.');

-- Insert Core Users & Seed Accounts
INSERT INTO users (employee_code, name, email, phone, password, role, status) VALUES
('EMP-101', 'Administrator', 'admin@akconstruction.com', '+91 9876543210', 'admin123', 'ADMIN', 'ACTIVE'),
('CON-201', 'Vikram Singh Contractor', 'contractor@akconstruction.com', '+91 9898989898', 'con123', 'CONTRACTOR', 'ACTIVE'),
('WRK-301', 'Amit Patel', 'worker@akconstruction.com', '+91 9797979797', 'wrk123', 'WORKER', 'ACTIVE'),
('WRK-302', 'Ramesh Kumar', 'ramesh.worker@akconstruction.com', '+91 9696969696', 'wrk123', 'WORKER', 'ACTIVE'),
('EMP-401', 'Rajesh Kumar', 'employee@akconstruction.com', '+91 9595959595', 'emp123', 'EMPLOYEE', 'ACTIVE'),
('USR-501', 'Demo Client', 'user@akconstruction.com', '+91 9494949494', 'user123', 'USER', 'ACTIVE')
ON DUPLICATE KEY UPDATE role=VALUES(role), phone=VALUES(phone);

-- Seed Work Types
INSERT IGNORE INTO work_types (name, description, category) VALUES
('Masonry', 'Structural block and stone laying', 'Structural'),
('Brick Work', 'Red brick & fly ash brick wall construction', 'Masonry'),
('Concrete Work', 'RMC pouring, vibration & slab curing', 'Structural'),
('Foundation Work', 'Excavation, piling, and footing reinforcement', 'Structural'),
('Plaster Work', 'Internal and external cement plastering', 'Finishing'),
('Painting', 'Primer, putty, emulsion & exterior weathercoat', 'Finishing'),
('Electrical Work', 'Conduit layout, wiring, DB box & fixtures', 'MEP'),
('Plumbing Work', 'CPVC/UPVC piping, drainage & sanitary fitting', 'MEP'),
('Carpentry', 'Door frames, wooden shuttering & furniture', 'Finishing'),
('Tile Work', 'Vitrified floor tiling & wall dado tiles', 'Finishing'),
('Flooring', 'Granite, marble & epoxy flooring installation', 'Finishing'),
('Roofing', 'Truss fabrication, sheet roofing & waterproofing', 'Structural'),
('Welding', 'Structural steel joint welding & fabrication', 'Steel'),
('Steel Work', 'TMT bar cutting, bending & binding', 'Steel'),
('Shuttering', 'Plywood and steel formwork installation', 'Formwork'),
('Bar Bending', 'Rebar cage fabrication for columns & beams', 'Steel'),
('Excavation', 'Earthmoving, trench digging & land leveling', 'Earthwork'),
('Waterproofing', 'Basement membrane & terrace waterproofing', 'Chemical'),
('Interior Work', 'False ceiling, modular kitchen & woodwork', 'Interior'),
('Exterior Work', 'Facade elevation, cladding & ACP panels', 'Exterior'),
('General Labour', 'Site cleanup, material handling & support', 'Labour');

-- Seed Contractor-Worker Mapping (Assign Amit Patel & Ramesh Kumar to Vikram Singh Contractor)
SET @contractor_id = (SELECT id FROM users WHERE email='contractor@akconstruction.com' LIMIT 1);
SET @worker1_id = (SELECT id FROM users WHERE email='worker@akconstruction.com' LIMIT 1);
SET @worker2_id = (SELECT id FROM users WHERE email='ramesh.worker@akconstruction.com' LIMIT 1);

INSERT IGNORE INTO contractor_worker (contractor_id, worker_id, status) VALUES
(@contractor_id, @worker1_id, 'ACTIVE'),
(@contractor_id, @worker2_id, 'ACTIVE');

-- Seed Sample Worker Assignment
SET @project_id = (SELECT id FROM projects LIMIT 1);
SET @work_type_id = (SELECT id FROM work_types WHERE name='Brick Work' LIMIT 1);

INSERT INTO worker_work_assignments (worker_id, contractor_id, project_id, work_type_id, task_title, task_description, start_date, expected_end_date, priority, status, completion_percentage)
VALUES
(@worker1_id, @contractor_id, @project_id, @work_type_id, 'Construct Ground Floor Walls', 'Build 9-inch perimeter brick walls with M20 mortar mix', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 10 DAY), 'HIGH', 'IN_PROGRESS', 40);

SELECT 'Employee Portal Schema & Seed Data Initialized Successfully!' as status;


