CREATE DATABASE timesheet_app;
USE timesheet_app;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('user','approver','admin') NOT NULL DEFAULT 'user',
    full_name VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE timesheets (
    timesheet_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    week_start DATE NOT NULL,
    hours_worked DECIMAL(5,2) NOT NULL,
    project VARCHAR(255),
    status ENUM('draft','submitted','approved','rejected') DEFAULT 'draft',
    approver_id INT,
    submitted_at TIMESTAMP NULL,
    approved_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (approver_id) REFERENCES users(user_id)
);
