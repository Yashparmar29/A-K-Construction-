
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
('Modern Villa Residence', 'Residential', 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80', 'Luxury 4BHK villa with contemporary design, smart home features, and landscaped gardens. Located in Bodakdev, Ahmedabad, Gujarat.'),
('Corporate Office Complex', 'Commercial', 'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&w=800&q=80', '5-story corporate headquarters with a double-glazed glass facade, energy-efficient HVAC, and collaborative open workspaces. Located in GIFT City, Gandhinagar, Gujarat.'),
('Luxury Apartment Complex', 'Residential', 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?auto=format&fit=crop&w=800&q=80', '20-unit premium residential apartment building offering high-end finishings, dedicated parking, and premium rooftop amenities. Located on Dumas Road, Surat, Gujarat.'),
('Shopping Mall Development', 'Commercial', 'https://images.unsplash.com/photo-1567449300518-034dbdc82661?auto=format&fit=crop&w=800&q=80', '3-level premium retail shopping mall with capacity for 50+ stores, dynamic digital signage, central atrium, and a large food court. Located on Race Course Road, Rajkot, Gujarat.'),
('Premium School Renovation', 'Renovation', 'https://images.unsplash.com/photo-1580582932707-520aed937b7b?auto=format&fit=crop&w=800&q=80', 'Complete structural and aesthetic renovation of a high school facility, including modern science labs, smart classrooms, and sports grounds. Located in Akota, Vadodara, Gujarat.'),
('Cable-Stayed Bridge Construction', 'Civil Engineering', 'https://images.unsplash.com/photo-1544982503-9f984c14501a?auto=format&fit=crop&w=800&q=80', 'State-of-the-art 4-lane concrete cable-stayed bridge built over the Tapi River, engineered with advanced seismic resistance and design. Located in Surat, Gujarat.');

INSERT IGNORE INTO contacts (name, email, message) VALUES
('John Doe', 'john@example.com', 'Interested in residential project quote.');

INSERT INTO users (name, email, password, role) VALUES
('Administrator', 'admin@akconstruction.com', 'admin123', 'ADMIN')
ON DUPLICATE KEY UPDATE role='ADMIN';

SELECT 'Database created successfully with sample data!' as status;
