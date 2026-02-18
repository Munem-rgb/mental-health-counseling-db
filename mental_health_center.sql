DROP DATABASE IF EXISTS mental_health_center;

CREATE DATABASE mental_health_center;
USE mental_health_center;

CREATE TABLE client (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(20),
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE therapist (
    therapist_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    license_number VARCHAR(50) UNIQUE NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    hire_date DATE
);
CREATE TABLE treatment_plan (
    plan_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    therapist_id INT NOT NULL,
    diagnosis VARCHAR(255),
    description TEXT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR(50) DEFAULT 'Active',
    FOREIGN KEY (client_id) REFERENCES client(client_id)
        ON DELETE CASCADE,
    FOREIGN KEY (therapist_id) REFERENCES therapist(therapist_id)
        ON DELETE CASCADE
);

CREATE TABLE appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    therapist_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status VARCHAR(50) DEFAULT 'Scheduled',
    notes VARCHAR(255),
    FOREIGN KEY (client_id) REFERENCES client(client_id)
        ON DELETE CASCADE,
    FOREIGN KEY (therapist_id) REFERENCES therapist(therapist_id)
        ON DELETE CASCADE
);

CREATE TABLE session_note (
    session_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    session_summary TEXT NOT NULL,
    therapist_comments TEXT,
    session_date DATE,
    FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id)
        ON DELETE CASCADE
);

CREATE TABLE payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    appointment_id INT,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_method VARCHAR(50),
    payment_status VARCHAR(50) DEFAULT 'Completed',
    FOREIGN KEY (client_id) REFERENCES client(client_id)
        ON DELETE CASCADE,
    FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id)
        ON DELETE SET NULL
);

