-- #################################################################
-- # DATABASE CREATION SCRIPT FOR FLEET_MANAGEMENT
-- # (Tables and Triggers only)
-- #################################################################

CREATE DATABASE IF NOT EXISTS fleet_management
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE fleet_management;


-- =================================================================
-- 1. BASE TABLES CREATION
-- =================================================================

CREATE TABLE Users (
    user_id VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT (UUID()),
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL COMMENT 'hasher le mdp avant insertion !'
) ENGINE=InnoDB;


CREATE TABLE Service_Addresses (
    service_address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255),
    street_number VARCHAR(10),
    postal_code VARCHAR(10),
    city VARCHAR(100),
    country VARCHAR(50)
) ENGINE=InnoDB;


CREATE TABLE Departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    service_address_id INT NOT NULL,
    FOREIGN KEY (service_address_id) REFERENCES Service_Addresses(service_address_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Providers (
    provider_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    street VARCHAR(255),
    street_number VARCHAR(10),
    postal_code VARCHAR(10),
    city VARCHAR(100),
    country VARCHAR(50)
) ENGINE=InnoDB;


CREATE TABLE Staff (
    employee_id INT PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL
) ENGINE=InnoDB;


CREATE TABLE Accidents (
    accident_id INT AUTO_INCREMENT PRIMARY KEY,
    accident_date DATE NOT NULL,
    time TIME,
    street VARCHAR(255),
    street_number VARCHAR(10),
    postal_code VARCHAR(10),
    city VARCHAR(100),
    country VARCHAR(50),
    accident_type ENUM('Accident en faute', 'Accident en droit', 'Accident indécis', 'Vandalisme', 'Dégâts en faute', 'Dégâts en droit'),
    damages TEXT,
    circumstances TEXT,
    report_number VARCHAR(50),
    info_number VARCHAR(50),
    other_party_info TEXT,
    documents VARCHAR(255),
    repair_completed BOOLEAN DEFAULT FALSE
) ENGINE=InnoDB;


-- =================================================================
-- 2. DEPENDENT TABLES CREATION
-- =================================================================

CREATE TABLE Vehicles (
    vin VARCHAR(50) PRIMARY KEY COMMENT 'Vehicle Identification Number',
    vehicle_number INT UNIQUE,
    license_plate VARCHAR(20) NOT NULL UNIQUE,
    make VARCHAR(50),
    model VARCHAR(50),
    manufacture_date DATE,
    fuel_type ENUM('Essence', 'Diesel', 'Hybride', 'Electrique'),
    license_type ENUM('AM', 'A1', 'A2', 'A', 'B', 'C1', 'C', 'D1', 'D', 'E'),
    vehicle_configuration ENUM('Stripping', 'Battenburg', 'Banalisé', 'Civil'),
    inspection_expiry_date DATE,
    tire_size VARCHAR(50),
    insurance_number VARCHAR(75),
    comprehensive_insurance BOOLEAN DEFAULT FALSE,
    maintenance_contract BOOLEAN DEFAULT FALSE,
    maintenance_contract_end_km INT,
    maintenance_contract_end_date DATE,
    maintenance_contract_number VARCHAR(75),
    other_info TEXT,
    documents VARCHAR(255),
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Contacts (
    contact_id INT AUTO_INCREMENT PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100),
    email VARCHAR(255),
    phone_number VARCHAR(20),
    provider_id INT NOT NULL,
    FOREIGN KEY (provider_id) REFERENCES Providers(provider_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Staff_Accidents (
    employee_id INT,
    accident_id INT,
    role ENUM('Conducteur', 'Passager', 'Témoin') NOT NULL,
    PRIMARY KEY (employee_id, accident_id),
    FOREIGN KEY (employee_id) REFERENCES Staff(employee_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (accident_id) REFERENCES Accidents(accident_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Interventions (
    intervention_id INT AUTO_INCREMENT PRIMARY KEY,
    intervention_type VARCHAR(100),
    creation_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    details TEXT,
    garage_entry_date DATETIME,
    garage_exit_date DATETIME,
    intervention_completed BOOLEAN DEFAULT FALSE,
    vehicle_vin VARCHAR(50) NOT NULL,
    user_id VARCHAR(36) NOT NULL,
    accident_id INT NULL,
    provider_id INT NOT NULL,
    FOREIGN KEY (vehicle_vin) REFERENCES Vehicles(vin) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (accident_id) REFERENCES Accidents(accident_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (provider_id) REFERENCES Providers(provider_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;


CREATE TABLE Invoices (
    invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    amount DECIMAL(10, 2) NOT NULL,
    documents VARCHAR(255),
    invoice_number VARCHAR(50) UNIQUE,
    invoice_paid BOOLEAN DEFAULT FALSE,
    intervention_id INT NOT NULL,
    FOREIGN KEY (intervention_id) REFERENCES Interventions(intervention_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;


-- =================================================================
-- 3. TRIGGERS CREATION
-- (Requires DELIMITER as it contains internal semicolons)
-- =================================================================

DELIMITER //

-- Trigger 1A: Normalize License Plate BEFORE INSERT
CREATE TRIGGER before_vehicle_insert_normalize_plate
BEFORE INSERT ON Vehicles
FOR EACH ROW
BEGIN
    SET NEW.license_plate = UPPER(NEW.license_plate);
    SET NEW.license_plate = REPLACE(NEW.license_plate, ' ', '');
    SET NEW.license_plate = REPLACE(NEW.license_plate, '-', '');
    SET NEW.license_plate = REPLACE(NEW.license_plate, '.', '');
END;
//

-- Trigger 1B: Normalize License Plate BEFORE UPDATE
CREATE TRIGGER before_vehicle_update_normalize_plate
BEFORE UPDATE ON Vehicles
FOR EACH ROW
BEGIN
    SET NEW.license_plate = UPPER(NEW.license_plate);
    SET NEW.license_plate = REPLACE(NEW.license_plate, ' ', '');
    SET NEW.license_plate = REPLACE(NEW.license_plate, '-', '');
    SET NEW.license_plate = REPLACE(NEW.license_plate, '.', '');
END;
//

-- Trigger 2: Automatic update of Repair status
CREATE TRIGGER after_intervention_update_update_accident
AFTER UPDATE ON Interventions
FOR EACH ROW
BEGIN
    -- Updates repair_completed to TRUE if the intervention was just finished AND it was linked to an accident.
    IF NEW.intervention_completed = TRUE AND OLD.intervention_completed = FALSE AND NEW.accident_id IS NOT NULL THEN
        UPDATE Accidents
        SET repair_completed = TRUE
        WHERE accident_id = NEW.accident_id;
    END IF;
END;
//

DELIMITER ;