USE timesheet_app;

-- Create a normal user
INSERT INTO users (username, password_hash, role, full_name, email)
VALUES (
    'john_doe',
    '$2b$12$yG03Hn6lZz/3EmAi4K7UkeMxx0mYyqcwz90q5ZLq0JcVx85Z8lMgi', -- password = "password123"
    'user',
    'John Doe',
    'john@example.com'
);

-- Create an approver
INSERT INTO users (username, password_hash, role, full_name, email)
VALUES (
    'manager_sara',
    '$2b$12$HZCzi6WUpm0v.6OEvqM9TO9sm3pKJbT1a4uBDz4quQ3JbRPlweXFS', -- password = "approve123"
    'approver',
    'Sara Manager',
    'sara@example.com'
);


UPDATE users SET password_hash='$2b$12$eFvuIq...' WHERE username='john_doe';
UPDATE users SET password_hash='$2b$12$ad9jKl...' WHERE username='manager_sara';


INSERT INTO users (username, password_hash, role, full_name, email) VALUES ('john_doe', '$2b$12$To.Qe/istwRe9zDvtJX3s.VT.MO.vAGsh6kuqdmPh/bPDePkMkRvS', 'user', 'Test john_doe', 'john_doe@example.com');
INSERT INTO users (username, password_hash, role, full_name, email) VALUES ('manager_sara', '$2b$12$lsQv/drqgclxR.4OCxmlJOxTU13SRUKiZJH4WTskjP/Yc4cd6PpPa', 'approver', 'Test manager_sara', 'manager_sara@example.com');


CREATE TABLE timesheet_entries (
    entry_id INT AUTO_INCREMENT PRIMARY KEY,
    timesheet_id INT NOT NULL,
    entry_date DATE NOT NULL,
    hours_worked DECIMAL(5,2) NOT NULL,
    activity VARCHAR(255),
    project VARCHAR(255),
    FOREIGN KEY (timesheet_id) REFERENCES timesheets(timesheet_id)
        ON DELETE CASCADE
);



CREATE TABLE projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(255) NOT NULL,
    client_name VARCHAR(255),
    start_date DATE,
    end_date DATE,
    status ENUM('active','on-hold','completed') DEFAULT 'active'
);



INSERT INTO projects (project_name, client_name, start_date, end_date, status)
VALUES
('Project Alpha', 'Acme Corp', '2025-01-01', NULL, 'active'),
('Project Beta', 'Globex Ltd', '2025-03-15', NULL, 'active'),
('Project Gamma', 'Initech', '2025-06-01', NULL, 'active'),
('Project Delta', 'Umbrella Inc', '2024-11-01', '2025-04-30', 'completed'),
('Project Omega', 'Wayne Enterprises', '2025-05-01', NULL, 'on-hold');



Users
INSERT INTO users (first_name, last_name, email, organization, role) VALUES
('John', 'Smith', 'john.smith@acme.com', 'Acme Corp', 'user'),
('Jane', 'Doe', 'jane.doe@globex.com', 'Globex Ltd', 'user'),
('Alice', 'Brown', 'alice.brown@initech.com', 'Initech', 'user'),
('Michael', 'Johnson', 'michael.j@acme.com', 'Acme Corp', 'approver'),
('Laura', 'Wong', 'laura.wong@globex.com', 'Globex Ltd', 'approver');

Project Approvers
INSERT INTO project_approvers (project_id, user_id) VALUES
(1, 4), -- Michael Johnson approves Project Alpha
(2, 5), -- Laura Wong approves Project Beta
(3, 4), -- Michael Johnson also approves Project Gamma
(3, 5); -- Both Michael + Laura approve Gamma



1. Users
INSERT INTO users (user_id, first_name, last_name, email, organization, role) VALUES
(1, 'John', 'Smith', 'john.smith@acme.com', 'Acme Corp', 'user'),
(2, 'Jane', 'Doe', 'jane.doe@globex.com', 'Globex Ltd', 'user'),
(3, 'Alice', 'Brown', 'alice.brown@initech.com', 'Initech', 'user'),
(4, 'Michael', 'Johnson', 'michael.j@acme.com', 'Acme Corp', 'approver'),
(5, 'Laura', 'Wong', 'laura.wong@globex.com', 'Globex Ltd', 'approver');

-- 2. Projects
INSERT INTO projects (project_id, project_name, client_name, start_date, end_date, status) VALUES
(1, 'Project Alpha', 'Acme Corp', '2025-01-01', NULL, 'active'),
(2, 'Project Beta', 'Globex Ltd', '2025-03-15', NULL, 'active'),
(3, 'Project Gamma', 'Initech', '2025-06-01', NULL, 'active');

-- 3. Project approvers
INSERT INTO project_approvers (project_id, user_id) VALUES
(1, 4), -- Michael Johnson approves Project Alpha
(2, 5), -- Laura Wong approves Project Beta
(3, 4), -- Michael Johnson also approves Project Gamma
(3, 5); -- Both Michael + Laura approve Gamma


  SET FOREIGN_KEY_CHECKS = 0;
        DROP TABLE your_table_name;
        SET FOREIGN_KEY_CHECKS = 1;

    CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    organization VARCHAR(255),
    role ENUM('user','approver','admin') NOT NULL
);



INSERT INTO users (first_name, last_name, email, password_hash, organization, role) VALUES
('John', 'Smith', 'john.smith@acme.com',
'$2b$12$uHWnh4SMW0Re6epR3J0bGOo8JDQ4MolwbjjJVuaf9Vfy.WKTvgl5i',
'Acme Corp', 'user');


INSERT INTO users (first_name, last_name, email, password_hash, organization, role) VALUES
('John', 'Smith', 'john.smith@acme.com',
'$2b$12$uHWnh4SMW0Re6epR3J0bGOo8JDQ4MolwbjjJVuaf9Vfy.WKTvgl5i',
'Acme Corp', 'user');



INSERT INTO users (first_name, last_name, email, password_hash, organization, role) VALUES
('Jane', 'Doe', 'jane.doe@globex.com',
'$2b$12$uHWnh4SMW0Re6epR3J0bGOo8JDQ4MolwbjjJVuaf9Vfy.WKTvgl5i',
'Globex Ltd', 'user'),

('Alice', 'Brown', 'alice.brown@initech.com',
'$2b$12$uHWnh4SMW0Re6epR3J0bGOo8JDQ4MolwbjjJVuaf9Vfy.WKTvgl5i',
'Initech', 'user'),

('Michael', 'Johnson', 'michael.j@acme.com',
'$2b$12$uHWnh4SMW0Re6epR3J0bGOo8JDQ4MolwbjjJVuaf9Vfy.WKTvgl5i',
'Acme Corp', 'approver'),

('Laura', 'Wong', 'laura.wong@globex.com',
'$2b$12$uHWnh4SMW0Re6epR3J0bGOo8JDQ4MolwbjjJVuaf9Vfy.WKTvgl5i',
'Globex Ltd', 'approver');


describe project_approvers;
+------------+------+------+-----+---------+-------+
| Field      | Type | Null | Key | Default | Extra |
+------------+------+------+-----+---------+-------+
| project_id | int  | NO   | PRI | NULL    |       |
| user_id    | int  | NO   | PRI | NULL    |       |
+------------+------+------+-----+---------+-------+
2 rows in set (0.056 sec)

| user_id | first_name | last_name | email                   | password_hash                                                | organization | role     |
+---------+------------+-----------+-------------------------+--------------------------------------------------------------+--------------+----------+
|      11 | John       | Smith     | john.smith@acme.com     | $2b$12$uHWnh4SMW0Re6epR3J0bGOo8JDQ4MolwbjjJVuaf9Vfy.WKTvgl5i | Acme Corp    | user     |
|      12 | Jane       | Doe       | jane.doe@globex.com     | $2b$12$uHWnh4SMW0Re6epR3J0bGOo8JDQ4MolwbjjJVuaf9Vfy.WKTvgl5i | Globex Ltd   | user     |
|      13 | Alice      | Brown     | alice.brown@initech.com | $2b$12$uHWnh4SMW0Re6epR3J0bGOo8JDQ4MolwbjjJVuaf9Vfy.WKTvgl5i | Initech      | user     |
|      14 | Michael    | Johnson   | michael.j@acme.com      | $2b$12$uHWnh4SMW0Re6epR3J0bGOo8JDQ4MolwbjjJVuaf9Vfy.WKTvgl5i | Acme Corp    | approver |
|      15 | Laura      | Wong      | laura.wong@globex.com   | $2b$12$uHWnh4SMW0Re6epR3J0bGOo8JDQ4MolwbjjJVuaf9Vfy.WKTvgl5i | Globex Ltd   | approver |

------------+---------------+-------------------+------------+------------+-----------+
| project_id | project_name  | client_name       | start_date | end_date   | status    |
+------------+---------------+-------------------+------------+------------+-----------+
|          1 | Project Alpha | Acme Corp         | 2025-01-01 | NULL       | active    |
|          2 | Project Beta  | Globex Ltd        | 2025-03-15 | NULL       | active    |
|          3 | Project Gamma | Initech           | 2025-06-01 | NULL       | active    |
|          4 | Project Delta | Umbrella Inc      | 2024-11-01 | 2025-04-30 | completed |
|          5 | Project Omega | Wayne Enterprises | 2025-05-01 | NULL       | on-hold   |
+------------+---------------+-------------------+------------+------------+-----------+


Project Approvers
INSERT INTO project_approvers (project_id, user_id) VALUES
(1, 14), -- Michael Johnson approves Project Alpha
(2, 15), -- Laura Wong approves Project Beta
(3, 14), -- Michael Johnson also approves Project Gamma
(3, 15); -- Both Michael + Laura approve Gamma