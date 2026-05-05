
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

INSERT IGNORE INTO projects (title, category, image, description) VALUES
('Modern Villa Residence', 'Residential', 'images/project1.jpg', 'Luxury 4BHK villa with contemporary design and smart home features.'),
('Corporate Office Complex', 'Commercial', 'images/project2.jpg', '5-story corporate headquarters with glass facade and open workspaces.'),
('Luxury Apartment Complex', 'Residential', 'images/project3.jpg', '20-unit premium apartment building with rooftop amenities.'),
('Shopping Mall Development', 'Commercial', 'images/project4.jpg', '3-level shopping mall with 50+ retail stores and food court.'),
('School Renovation', 'Renovation', 'images/project5.jpg', 'Complete renovation of government school with modern classrooms.'),
('Bridge Construction', 'Civil Engineering', 'images/project6.jpg', '2-lane concrete bridge over river with advanced engineering.');

INSERT IGNORE INTO contacts (name, email, message) VALUES
('John Doe', 'john@example.com', 'Interested in residential project quote.');

-- Default admin account (password: admin123)
INSERT INTO users (name, email, password, role) VALUES
('Administrator', 'admin@akconstruction.com', 'admin123', 'ADMIN')
ON DUPLICATE KEY UPDATE role='ADMIN';

SELECT 'Database created successfully with sample data!' as status;
