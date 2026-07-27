
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

CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('USER','ADMIN') DEFAULT 'USER',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

TRUNCATE TABLE projects;

INSERT INTO projects (title, category, image, description) VALUES
('Modern Villa Residence', 'Residential', '/images/user_project_1.jpg', 'Luxury 4BHK villa with contemporary design, smart home features, and landscaped gardens. Located in Bodakdev, Ahmedabad, Gujarat.'),
('Corporate Office Complex', 'Commercial', '/images/user_project_2.jpg', '5-story corporate headquarters with a double-glazed glass facade, energy-efficient HVAC, and collaborative open workspaces. Located in GIFT City, Gandhinagar, Gujarat.'),
('Luxury Apartment Complex', 'Residential', '/images/user_project_3.jpg', '20-unit premium residential apartment building offering high-end finishings, dedicated parking, and premium rooftop amenities. Located on Dumas Road, Surat, Gujarat.'),
('Shopping Mall Development', 'Commercial', '/images/user_project_4.jpg', '3-level premium retail shopping mall with capacity for 50+ stores, dynamic digital signage, central atrium, and a large food court. Located on Race Course Road, Rajkot, Gujarat.'),
('Premium School Renovation', 'Renovation', '/images/user_project_5.jpg', 'Complete structural and aesthetic renovation of a high school facility, including modern science labs, smart classrooms, and sports grounds. Located in Akota, Vadodara, Gujarat.'),
('Cable-Stayed Bridge Construction', 'Civil Engineering', '/images/user_project_6.jpg', 'State-of-the-art 4-lane concrete cable-stayed bridge built over the Tapi River, engineered with advanced seismic resistance and design. Located in Surat, Gujarat.'),
('Heritage Commercial Renovation', 'Renovation', '/images/user_project_7.jpg', 'Restoration and modern structural retrofitting of heritage commercial property. Located in Walled City, Ahmedabad, Gujarat.'),
('High-Rise Residential Towers', 'Residential', '/images/user_project_8.jpg', 'Twin 15-story luxury residential towers with subterranean parking and rooftop garden. Located in Alkapuri, Vadodara, Gujarat.'),
('Commercial Business Hub', 'Commercial', '/images/user_project_9.jpg', 'Modern IT and business park with integrated green building technology. Located on SG Highway, Ahmedabad, Gujarat.'),
('Industrial Expressway Corridor', 'Civil Engineering', '/images/user_project_10.jpg', 'Heavy civil engineering 6-lane elevated express corridor connecting port hubs. Located in Bhavnagar, Gujarat.'),
('Multi-Specialty Medical Center', 'Commercial', '/images/user_project_11.jpg', '300-bed state-of-the-art hospital facility built to international medical infrastructure standards. Located in Jamnagar, Gujarat.');

INSERT IGNORE INTO contacts (name, email, message) VALUES
('John Doe', 'john@example.com', 'Interested in residential project quote.');

INSERT INTO users (name, email, password, role) VALUES
('Administrator', 'admin@akconstruction.com', 'admin123', 'ADMIN')
ON DUPLICATE KEY UPDATE role='ADMIN';

SELECT 'Database created successfully with sample data!' as status;
