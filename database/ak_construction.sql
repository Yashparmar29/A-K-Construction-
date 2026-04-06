-- Create database for A K Construction
CREATE DATABASE IF NOT EXISTS ak_construction;
USE ak_construction;

-- Projects table
CREATE TABLE IF NOT EXISTS projects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL,
    image VARCHAR(255),
    description TEXT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Contacts table for form submissions
CREATE TABLE IF NOT EXISTS contacts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    submitted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample projects data
INSERT INTO projects (title, category, image, description) VALUES
('Modern Villa Residence', 'Residential', 'images/project1.jpg', 'Luxury 4BHK villa with contemporary design and smart home features.'),
('Corporate Office Complex', 'Commercial', 'images/project2.jpg', '5-story corporate headquarters with glass facade and open workspaces.'),
('Luxury Apartment Complex', 'Residential', 'images/project3.jpg', '20-unit premium apartment building with rooftop amenities.'),
('Shopping Mall Development', 'Commercial', 'images/project4.jpg', '3-level shopping mall with 50+ retail stores and food court.'),
('School Renovation', 'Renovation', 'images/project5.jpg', 'Complete renovation of government school with modern classrooms.'),
('Bridge Construction', 'Civil Engineering', 'images/project6.jpg', '2-lane concrete bridge over river with advanced engineering.');

-- Insert sample contact (for testing)
INSERT INTO contacts (name, email, message) VALUES 
('John Doe', 'john@example.com', 'Interested in residential project quote.');

SELECT 'Database created successfully with sample data!' as status;
